class Schedule < ActiveRecord::Base
  attr_accessible :results_attributes, :round_id, :table

  belongs_to :round
  has_many :results, :dependent => :destroy

  accepts_nested_attributes_for :results

  validates_associated :results
  validates :table, :presence => true, :numericality => { :only_integer => true }
  validates :round_id, :presence => true, :numericality => { :only_integer => true }

  def self.calculate_schedule(round, params_trigger, params_seed)
    if params_trigger == "Schedule" or params_trigger == "Manual"
      round.schedules.each do |schedule|
        schedule.destroy
      end
    	participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", round.tournament_id, Var.bye_id], :include => :results).sort_by(&:place)
    	participants = Schedule.sort_pair(participants, round, params_seed)
      Schedule.create_schedule(round, participants)
      round.ready
    end
    Schedule.find_all_by_round_id(round.id, :include => :results)
  end

  private

  def self.sort_pair(participants, round, params_seed)
    if round.round_robin?
      participants = participants.sort_by(&:id)
    elsif round.number == 1 and params_seed == "Random"
      participants = participants.shuffle
    elsif round.number == 1 and params_seed == "Seeded"
      half = (participants.count / 2) - 1
      last = participants.count - 1
      counter = 0
      pair = false
      participants = participants.sort_by(&:rating).reverse
      participants.each do
        if participants[half + counter] and pair == true and not participants[half + counter] == participants[last]
          p = participants[counter]
          participants[counter] = participants[half + counter]
          participants[half + counter] = p
        end
        counter = counter + 1
        pair = (not pair)
      end
    elsif round.swiss?
      pair = true
      counter = 0
      participants.each do
        if pair == true
          pair = false
          counter = counter + 1
        elsif pair == false
          c = counter + 1
          while participants[counter] and Participant.check_past_encounter(participants[counter - 1], participants[counter]) do
            p = participants[counter]
            participants[counter] = participants[c]
            participants[c] = p
            c = c + 1
          end
          pair = true
          counter = counter + 1
        end
      end
      if participants.count.even?
        pair = true
        counter = -1
        participants.reverse.each do
          if pair == true
            pair = false
            counter = counter - 1
          elsif pair == false
            c = counter - 1
            while participants[counter] and Participant.check_past_encounter(participants[counter + 1], participants[counter]) do
              p = participants[counter]
              participants[counter] = participants[c]
              participants[c] = p
              c = c - 1
            end
            pair = true
            counter = counter - 1
          end
        end
      elsif participants.count.odd?
        pair = true
        counter = 0
        participants.reverse.each do
          if pair == true
            pair = false
            counter = counter - 1
          elsif pair == false
            c = counter - 1
            if counter == -1
              while participants[counter] and Participant.check_past_encounter(Participant.find_by_tournament_id_and_player_id(participants[counter].tournament_id, Var.bye_id), participants[counter]) do
                p = participants[counter]
                participants[counter] = participants[c]
                participants[c] = p
                c = c - 1
              end
            else
              while participants[counter] and Participant.check_past_encounter(participants[counter + 1], participants[counter]) do
                p = participants[counter]
                participants[counter] = participants[c]
                participants[c] = p
                c = c - 1
              end
            end
            pair = true
            counter = counter - 1
          end
        end
      end
    end
    participants
  end

  def self.create_schedule(round, participants)
    table = 1
    bye = Participant.bye(round.tournament_id)
    if round.swiss?
      pair = true
      participant_id = 0
      schedule = Schedule.new
      player_with_bye = participants.last
      participants.each do |participant|
        if participant == player_with_bye and participants.count.odd?
          schedule = Schedule.create :round_id => round.id, :table => table
          Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => bye.id, :corp_game_points => 0, :runner_game_points => 0, :prestige => 6
          Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => bye.id, :opponent_id => participant.id, :corp_game_points => 0, :runner_game_points => 0, :prestige => 0
        else
          if pair == true
            participant_id = participant.id
            pair = false
          elsif pair == false
            schedule = Schedule.create :round_id => round.id, :table => table
            Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant_id, :opponent_id => participant.id
            Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => participant_id
            pair = true
            table = table + 1
          end
        end
      end
    elsif round.round_robin?
      counter = 0
      pair = true
      participants.each do |participant|
        if pair == true
          opponent_loc = counter + round.number
          opponent_loc = opponent_loc - participants.count + 1 if opponent_loc > participants.count and participants.count.odd?
          opponent_loc = opponent_loc - participants.count + 2 if opponent_loc > participants.count - 1 and participants.count.even?
          opponent = participants[opponent_loc]
          schedule = Schedule.create :round_id => round.id, :table => table
          if opponent
            Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => opponent.id
            Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => opponent.id, :opponent_id => participant.id
          else
            Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => bye.id, :corp_game_points => 0, :runner_game_points => 0, :prestige => 6
            Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => bye.id, :opponent_id => participant.id, :corp_game_points => 0, :runner_game_points => 0, :prestige => 0
          end
          table = table + 1
        end
        counter = counter + 1
        pair = (not pair) if counter % round.number == 0
        pair = false if round.number < counter + 2 and ((participants.count.odd? and round.number == participants.count) or (participants.count.even? and round.number == participants.count - 1))
      end
    elsif round.single_elimination?
      counter = 0
      participant_limit = 2**(round.tournament.rounds.sort_by(&:number).last.number - round.number + 1)
      participant_limit_half = participant_limit / 2
      participants.each do |participant|
        if counter < participant_limit / 2
          opponent = participants[counter + (participant_limit / 2)]
          schedule = Schedule.create :round_id => round.id, :table => table
          if opponent
            Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => opponent.id
            Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => opponent.id, :opponent_id => participant.id
          else
            Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => bye.id, :corp_game_points => 0, :runner_game_points => 0, :prestige => 6
            Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => bye.id, :opponent_id => participant.id, :corp_game_points => 0, :runner_game_points => 0, :prestige => 0
          end
          table = table + 1
          counter = counter + 1
        end
      end
    end
  end

  def self.calculate_prestige(schedule, current_schedule)
    schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"1"][:prestige] = 0

    if schedule[:results_attributes][:"0"][:corp_game_points].to_i == 10
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 2
    elsif schedule[:results_attributes][:"1"][:runner_game_points].to_i == 10
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 2
    else
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 1
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 1
    end

    if schedule[:results_attributes][:"0"][:runner_game_points].to_i == 10
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 2
    elsif schedule[:results_attributes][:"1"][:corp_game_points].to_i == 10
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 2
    else
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 1
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 1
    end

    if schedule[:results_attributes][:"0"][:prestige] > 2
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 2
    elsif schedule[:results_attributes][:"1"][:prestige] > 2
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 2
    elsif schedule[:results_attributes][:"0"][:prestige] == 2 and (schedule[:results_attributes][:"0"][:corp_game_points].to_i + schedule[:results_attributes][:"0"][:runner_game_points].to_i) > (schedule[:results_attributes][:"1"][:corp_game_points].to_i + schedule[:results_attributes][:"1"][:runner_game_points].to_i)
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 2
    elsif schedule[:results_attributes][:"1"][:prestige] == 2 and (schedule[:results_attributes][:"0"][:corp_game_points].to_i + schedule[:results_attributes][:"0"][:runner_game_points].to_i) < (schedule[:results_attributes][:"1"][:corp_game_points].to_i + schedule[:results_attributes][:"1"][:runner_game_points].to_i)
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 2
    else
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 1
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 1
    end

    participant_0 = Participant.find(current_schedule.results.first.participant_id)
    participant_1 = Participant.find(current_schedule.results.last.participant_id)
    participant_bye = Participant.find_by_tournament_id_and_player_id(current_schedule.round.tournament_id, Var.bye_id)
    unless participant_0 == participant_bye or participant_1 == participant_bye
      score = schedule[:results_attributes][:"0"][:prestige] / 6.0 - (1 / (1 + 10**((participant_0.rating + participant_0.rating_scores - participant_1.rating - participant_1.rating_scores) / 400.0)))
      schedule[:results_attributes][:"0"][:rating_score] = score / Var.rating_lose_divider * current_schedule.round.tournament.rating_multiplier.to_f * current_schedule.round.tournament.rating_boost.to_f if score < 0.0
      schedule[:results_attributes][:"0"][:rating_score] = score * Var.rating_win_multiplier * current_schedule.round.tournament.rating_multiplier.to_f * current_schedule.round.tournament.rating_boost.to_f if score > 0.0
      score = schedule[:results_attributes][:"1"][:prestige] / 6.0 - (1 / (1 + 10**((participant_1.rating + participant_1.rating_scores - participant_0.rating - participant_0.rating_scores) / 400.0)))
      schedule[:results_attributes][:"1"][:rating_score] = score / Var.rating_lose_divider * current_schedule.round.tournament.rating_multiplier.to_f * current_schedule.round.tournament.rating_boost.to_f if score < 0.0
      schedule[:results_attributes][:"1"][:rating_score] = score * Var.rating_win_multiplier * current_schedule.round.tournament.rating_multiplier.to_f * current_schedule.round.tournament.rating_boost.to_f if score > 0.0
    end
    schedule[:results_attributes][:"0"][:corp_game_points] = schedule[:results_attributes][:"0"][:runner_game_points] = "0" if participant_1 == participant_bye
    schedule[:results_attributes][:"1"][:corp_game_points] = schedule[:results_attributes][:"1"][:runner_game_points] = "0" if participant_0 == participant_bye

    schedule
  end
end

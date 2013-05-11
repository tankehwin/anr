class Schedule < ActiveRecord::Base
  attr_accessible :results_attributes, :round_id, :table

  belongs_to :round
  has_many :results, :dependent => :destroy

  accepts_nested_attributes_for :results

  validates_associated :results
  validates :table, :presence => true

  def self.calculate_schedule(round, params_trigger)
    if params_trigger == "Schedule" or params_trigger == "Manual"
      round.schedules.each do |schedule|
        schedule.destroy
      end
    	participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", round.tournament_id, 1]).sort_by(&:place)
    	participants = Schedule.sort_pair(participants, round)
      Schedule.create_schedule(round, participants)
      round.ready
    end
    Schedule.find_all_by_round_id(round.id, :include => :results)
  end

  private

  def self.sort_pair(participants, round)
    if round.number == 1
      participants.shuffle
    else
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
              while participants[counter] and Participant.check_past_encounter(Participant.find_by_tournament_id_and_player_id(participants[counter].tournament_id, 1), participants[counter]) do
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
    pair = true
    table = 1
    opponent_id = 0
    schedule = Schedule.new
    result = Result.new
    player_with_bye = participants.last
    participants.each do |participant|
      if participant == player_with_bye and participants.count.odd?
        schedule = Schedule.create :round_id => round.id, :table => table
        Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => Participant.bye_id(round.tournament_id), :corp_match_points => 10, :runner_match_points => 10, :prestige => 6
        Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => Participant.bye_id(round.tournament_id), :opponent_id => participant.id, :corp_match_points => 0, :runner_match_points => 0, :prestige => 0
      else
        if pair == true
          schedule = Schedule.create :round_id => round.id, :table => table
          result = Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => 0
          opponent_id = participant.id
          pair = false
        elsif pair == false
          result.opponent_id = participant.id
          result.save
          Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => opponent_id
          pair = true
          table = table + 1
        end
      end
    end
  end

  def self.calculate_prestige(schedule, current_schedule)
    schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"1"][:prestige] = 0

    if schedule[:results_attributes][:"0"][:corp_match_points].to_i == 10
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 2
    elsif schedule[:results_attributes][:"1"][:runner_match_points].to_i == 10
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 2
    else
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 1
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 1
    end

    if schedule[:results_attributes][:"0"][:runner_match_points].to_i == 10
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 2
    elsif schedule[:results_attributes][:"1"][:corp_match_points].to_i == 10
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 2
    else
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 1
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 1
    end

    if schedule[:results_attributes][:"0"][:prestige] > 2
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 2
    elsif schedule[:results_attributes][:"1"][:prestige] > 2
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 2
    elsif schedule[:results_attributes][:"0"][:prestige] == 2 and (schedule[:results_attributes][:"0"][:corp_match_points].to_i + schedule[:results_attributes][:"0"][:runner_match_points].to_i) > (schedule[:results_attributes][:"1"][:corp_match_points].to_i + schedule[:results_attributes][:"1"][:runner_match_points].to_i)
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 2
    elsif schedule[:results_attributes][:"1"][:prestige] == 2 and (schedule[:results_attributes][:"0"][:corp_match_points].to_i + schedule[:results_attributes][:"0"][:runner_match_points].to_i) < (schedule[:results_attributes][:"1"][:corp_match_points].to_i + schedule[:results_attributes][:"1"][:runner_match_points].to_i)
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 2
    else
      schedule[:results_attributes][:"0"][:prestige] = schedule[:results_attributes][:"0"][:prestige] + 1
      schedule[:results_attributes][:"1"][:prestige] = schedule[:results_attributes][:"1"][:prestige] + 1
    end

    rating_0 = Participant.find(current_schedule.results.first.participant_id).rating
    rating_1 = Participant.find(current_schedule.results.last.participant_id).rating
    score_0 = schedule[:results_attributes][:"0"][:prestige]/6 - (1/(1 + 10**((rating_0 - rating_1)/400)))
    score_1 = schedule[:results_attributes][:"1"][:prestige]/6 - (1/(1 + 10**((rating_1 - rating_0)/400)))
    score_0 = score_0 / 20 if score_0 < 0
    score_1 = score_1 / 20 if score_1 < 0
    score_0 = score_0 * 20 if score_0 > 0
    score_1 = score_1 * 20 if score_1 > 0
    schedule[:results_attributes][:"0"][:rating_score] = score_0 * current_schedule.round.tournament.rating_multiplier
    schedule[:results_attributes][:"1"][:rating_score] = score_1 * current_schedule.round.tournament.rating_multiplier

    schedule
  end
end

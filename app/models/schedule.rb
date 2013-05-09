class Schedule < ActiveRecord::Base
  attr_accessible :results_attributes, :round_id, :table

  belongs_to :round
  has_many :results, :dependent => :destroy

  accepts_nested_attributes_for :results

  def self.calculate_schedule(round, params_trigger)
    if params_trigger == "Schedule" or params_trigger == "Manual"
      round.schedules.each do |schedule|
        schedule.destroy
      end
    	participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", round.tournament_id, 1])
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
      if round.number > 2
      end
      participants
    end
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

  def self.calculate_prestige(schedule)
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

    schedule
  end
end

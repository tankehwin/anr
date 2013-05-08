class Schedule < ActiveRecord::Base
  attr_accessible :results_attributes, :round_id, :table

  belongs_to :round
  has_many :results, :dependent => :destroy

  accepts_nested_attributes_for :results

  def self.calculate_schedule(round)
    round.schedules.each do |s|
      s.destroy
    end
  	participants = Participant.find_all_by_tournament_id round.tournament_id
    pair = true
    table = 1
    opponent_id = 0
    result = Result.new
  	if round.number == 1
  		participants = participants.shuffle
  		if (participants.count - 1).odd?
  			player_with_bye = participants.last
  			participants.each do |participant|
  				if participant == player_with_bye
  					schedule = Schedule.create :round_id => round.id, :table => table
	  				Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => Participant.bye_id(round.tournament_id), :corp_match_points => 10, :runner_match_points => 10, :prestige => 6
	  				Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => Participant.bye_id(round.tournament_id), :opponent_id => participant.id, :corp_match_points => 0, :runner_match_points => 0, :prestige => 0
            table = table + 1
          else
            unless participant.id == Participant.bye_id(round.tournament_id)
      				if pair == true
    	  				schedule = Schedule.create :round_id => round.id, :table => table
    	  				result = Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => 0
                opponent_id = participant.id
    	  				pair = false
    	  			else
    	  				schedule = Schedule.last
                result.opponent_id = participant.id
                result.save
    	  				Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => opponent_id
    	  				pair = true
    	  				table = table + 1
              end
            end
	  			end
  			end
  		else
  			participants.each do |participant|
          unless participant.id == Participant.bye_id(round.tournament_id)
    				if pair == true
  	  				schedule = Schedule.create :round_id => round.id, :table => table
  	  				result = Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => 0
              opponent_id = participant.id
  	  				pair = false
  	  			else
  	  				schedule = Schedule.last
              result.opponent_id = participant.id
              result.save
  	  				Result.create :tournament_id => participant.tournament_id, :schedule_id => schedule.id, :participant_id => participant.id, :opponent_id => opponent_id
  	  				pair = true
  	  				table = table + 1
  	  			end
          end
  			end
  		end
  	else
  	end
  	round.state = "Ready"
  	round.action = "Start"
    round.start = nil
  	round.save
    Schedule.find_all_by_round_id round.id
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

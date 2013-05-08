class Round < ActiveRecord::Base
  attr_accessible :action, :end, :number, :schedules_attributes, :start, :state, :tournament_id

  belongs_to :tournament
  has_many :schedules, :dependent => :destroy

  accepts_nested_attributes_for :schedules

  def self.calculate_round(tournament)
    rounds = Round.find_all_by_tournament_id tournament.id
    rounds.each do |r|
      r.destroy
    end
  	participants = Participant.find_all_by_tournament_id tournament.id
    count = participants.count - 2
    round = Math.log2(count).to_i if count > 1
    round = 0 if count < 2
    Round.create :tournament_id => tournament.id, :state => "Not Scheduled", :action => "Schedule", :number => 1 unless count < 1
    number = 2
    round.times do
      Round.create :tournament_id => tournament.id, :state => "Not Ready", :action => "Pre-Round", :number => number
      number = number + 1
    end
    unless count < 1
      tournament.state = "Tournament has started."
      tournament.save
    else
      tournament.state = "Tournament is not started."
      tournament.save
    end
    Participant.reset(tournament.id)
  end

  def self.trigger(round, trigger)
    if trigger == "Start"
      round.start = Time.now
      round.state = "In Progress"
      round.action = "End"
      round.save
      "Round has started."
    elsif trigger == "End"
      round.end = Time.now
      round.state = "Closed"
      round.action = "Post-Round"
      round.save
      round.schedules.each do |s|
        s.results.each do |r|
          Participant.update_personal_points(r) unless r.participant_id == Participant.bye_id(round.tournament_id)
        end
      end
      Participant.update_opponent_points(round)
      next_round = Round.find_by_tournament_id_and_number(round.tournament_id, round.number + 1)
      next_round.state = "Not Scheduled"
      next_round.action = "Schedule"
      next_round.save
      "Round has ended."
    end
  end

  def self.update_table(round)
    round.schedules.each do |s|
      result = Result.find_by_opponent_id s.results.first.participant_id
      result.schedule_id = s.results.first.schedule_id
      result.prestige = nil
      result.corp_match_points = nil
      result.runner_match_points = nil
      if result.participant_id == Participant.bye_id(round.tournament_id)
        result.prestige = 0
        result.corp_match_points = 0
        result.runner_match_points = 0
      elsif result.opponent_id == Participant.bye_id(round.tournament_id)
        result.prestige = 6
        result.corp_match_points = 10
        result.runner_match_points = 10
      end
      result.save
      first = s.results.first
      first.prestige = nil
      first.corp_match_points = nil
      first.runner_match_points = nil
      if first.participant_id == Participant.bye_id(round.tournament_id)
        first.prestige = 0
        first.corp_match_points = 0
        first.runner_match_points = 0
      elsif first.opponent_id == Participant.bye_id(round.tournament_id)
        first.prestige = 6
        first.corp_match_points = 10
        first.runner_match_points = 10
      end
      first.save
    end
    round
  end
end

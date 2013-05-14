class Round < ActiveRecord::Base
  attr_accessible :action, :end, :number, :schedules_attributes, :start, :state,
                  :tournament_id

  belongs_to :tournament
  has_many :schedules, :dependent => :destroy

  accepts_nested_attributes_for :schedules

  validates_associated :schedules

  def ready
    self.start = nil
    self.state = "Ready"
    self.action = "Start"
    self.save
  end

  def in_progress
    self.start = Time.now
    self.state = "In Progress"
    self.action = "End"
    self.save
  end

  def closed
    self.start = Time.now unless self.start
    self.end = Time.now
    self.state = "Closed"
    self.action = "Post-Round"
    self.save
  end

  def not_scheduled
    self.state = "Not Scheduled"
    self.action = "Schedule"
    self.save
  end

  def self.calculate_round(tournament)
    rounds = Round.find_all_by_tournament_id tournament.id
    rounds.each do |round|
      round.destroy
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
    if count < 1
      tournament.state = "Tournament is not started."
      tournament.save
    else
      tournament.state = "Tournament has started."
      tournament.save
    end
    Participant.reset(tournament.id)
  end

  def update_table
    self.schedules.each do |schedule|
      result = Result.find_by_opponent_id schedule.results.first.participant_id
      result.schedule_id = schedule.results.first.schedule_id
      Round.reset_score_or_bye(result)
      first = schedule.results.first
      Round.reset_score_or_bye(first)
    end
    self.ready
    self
  end

  private

  def self.trigger(round, trigger)
    if trigger == "Start"
      round.in_progress
      "Round has started."
    elsif trigger == "End"
      round.closed
      round.schedules.each do |schedule|
        schedule.results.each do |result|
          Participant.update_personal_points(result) unless result.participant_id == Participant.bye(round.tournament_id).id
        end
      end
      Participant.update_opponent_points(round)
      next_round = Round.find_by_tournament_id_and_number(round.tournament_id, round.number + 1)
      next_round.not_scheduled if next_round
      Participant.update_standings(round)
      "Round has ended."
    end
  end

  def self.reset_score_or_bye(result)
    result.prestige = nil
    result.corp_match_points = nil
    result.runner_match_points = nil
    result.rating_score = 0.0
    if result.participant_id == Participant.bye(result.tournament_id).id
      result.prestige = 0
      result.corp_match_points = 0
      result.runner_match_points = 0
    elsif result.opponent_id == Participant.bye(result.tournament_id).id
      result.prestige = 6
      result.corp_match_points = 10
      result.runner_match_points = 10
    end
    result.save
  end
end

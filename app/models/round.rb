class Round < ActiveRecord::Base
  attr_accessible :action, :end, :number, :schedules_attributes, :start, :state,
                  :tournament_id

  belongs_to :tournament
  has_many :schedules, :dependent => :destroy

  accepts_nested_attributes_for :schedules
  validates :tournament_id, :presence => true, :numericality => { :only_integer => true }

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

  def ready?
    @isReady ||= (self.state == "Ready")? true : false
  end

  def in_progress?
    @isInProgress ||= (self.state == "In Progress")? true : false
  end

  def not_scheduled?
    @isNotScheduled ||= (self.state == "Not Scheduled")? true : false
  end

  def update_table
    self.schedules.each do |schedule|
      # initialize data (must not use cache)
      opponent_result = Result.find(schedule.results.first.opponent.results.first.id)
      schedule_id = Result.find(schedule.results.first.id).schedule_id
      result = Result.find(schedule.results.last)
      opponent_schedule_id = Result.find(schedule.results.last.opponent.results.first.id).schedule_id
      # set first result table
      opponent_result.schedule_id = schedule_id
      Round.reset_score_or_bye(opponent_result)
      # set last result table
      result.schedule_id = opponent_schedule_id
      Round.reset_score_or_bye(result)
    end
    self.ready
    self
  end

  private

  def self.calculate_round(tournament, trigger)
    tournament.rounds.each do |round|
      round.destroy
    end
    if trigger == "Without"
      count = tournament.participants.count - 2
      round = Math.log2(count).to_i if count > 1
      round = 0 if count < 2
      Round.create :tournament_id => tournament.id, :state => "Not Scheduled", :action => "Schedule", :number => 1 unless count < 1
      number = 2
      round.times do
        Round.create :tournament_id => tournament.id, :state => "Not Ready", :action => "Pre-Round", :number => number
        number = number + 1
      end
    elsif trigger == "With4"
      count = tournament.participants.count - 2
      round = Math.log2(count).to_i if count > 1
      round = 0 if count < 2
      Round.create :tournament_id => tournament.id, :state => "Not Scheduled", :action => "Schedule", :number => 1 unless count < 1
      number = 2
      round.times do
        Round.create :tournament_id => tournament.id, :state => "Not Ready", :action => "Pre-Round", :number => number
        number = number + 1
      end
    elsif trigger == "With8"
      count = tournament.participants.count - 2
      round = Math.log2(count).to_i if count > 1
      round = 0 if count < 2
      Round.create :tournament_id => tournament.id, :state => "Not Scheduled", :action => "Schedule", :number => 1 unless count < 1
      number = 2
      round.times do
        Round.create :tournament_id => tournament.id, :state => "Not Ready", :action => "Pre-Round", :number => number
        number = number + 1
      end
    end
    if count < 1
      tournament.not_started
    else
      tournament.started
    end
    Participant.reset(tournament)
  end

  def self.trigger(round, trigger)
    participant_bye_id = Participant.bye(round.tournament_id).id
    if trigger == "Start"
      round.in_progress
      "Round has started."
    elsif trigger == "End"
      round.schedules.each do |schedule|
        schedule.results.each do |result|
          Participant.update_personal_points(result) unless result.participant_id == participant_bye_id
        end
      end
      Participant.update_opponent_points(round)
      next_round = Round.find_by_tournament_id_and_number(round.tournament_id, round.number + 1)
      next_round.not_scheduled if next_round
      Participant.update_standings(round)
      round.closed
      "Round has ended."
    end
  end

  def self.reset_score_or_bye(result)
    participant_bye_id = Participant.bye(result.tournament_id).id
    result.prestige = nil
    result.corp_game_points = nil
    result.runner_game_points = nil
    result.rating_score = 0.0
    if result.participant_id == participant_bye_id
      result.prestige = 0
      result.corp_game_points = 0
      result.runner_game_points = 0
    elsif result.opponent_id == participant_bye_id
      result.prestige = 6
      result.corp_game_points = 10
      result.runner_game_points = 10
    end
    result.save
  end
end

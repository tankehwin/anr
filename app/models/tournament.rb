class Tournament < ActiveRecord::Base
  attr_accessible :description, :flag, :name, :organizer_id, :rating_multiplier,
                  :scheduling_type, :state, :time_zone

  belongs_to :organizer
  has_many :participants, :dependent => :destroy
  has_many :results
  has_many :rounds, :dependent => :destroy
  has_many :schedules, through: :rounds
  has_many :players, through: :participants

  validates :name, :presence => true, :length => { :in => 4..140 }
  validates :organizer_id, :presence => true, :numericality => { :only_integer => true }
  validates :rating_multiplier, :numericality => { :only_integer => true }, :inclusion => { :in => 1..99, :message => "%{value} is not a valid rating multiplier" }, :allow_nil => true
  validates :rating_boost, :numericality => { :only_integer => true }, :inclusion => { :in => 1..10, :message => "%{value} is not a valid rating boost" }, :allow_nil => true

  after_create :seed_bye

  def not_started
    self.state = "Tournament is not started."
    self.scheduling_type = "Not Scheduled"
    self.save
  end

  def started
    self.start = Time.now
    self.state = "Tournament has started."
    self.save
  end

  def closed
    self.end = Time.now
    self.state = "Tournament is closed."
    self.save
  end

  def without
    self.scheduling_type = "Without Playoff"
    self.save
  end

  def with4
    self.scheduling_type = "With Playoff (Top 4)"
    self.save
  end

  def with8
    self.scheduling_type = "With Playoff (Top 8)"
    self.save
  end

  def robin
    self.scheduling_type = "Round Robin"
    self.save
  end

  def elimination1
    self.scheduling_type = "Single Elimination"
    self.save
  end

  def elimination2
    self.scheduling_type = "Double Elimination"
    self.save
  end

  def not_started?
    @isNotStarted ||= (self.state == "Tournament is not started.")? true : false
  end

  def started?
    @isStarted ||= (self.state == "Tournament has started.")? true : false
  end

  def closed?
    @isClosed ||= (self.state == "Tournament is closed.")? true : false
  end

  def single_elimination?
    @isSingleElimination ||= (self.scheduling_type == "Single Elimination")? true : false
  end

  def activate_points
    participant_bye = Participant.bye(self.id)
    self.participants.each do |participant|
      unless participant == participant_bye
        participant.results.each do |result|
          if result.opponent_id == participant_bye.id
            participant.obtained_bye = true
            participant.bye_prestiges = result.prestige
            participant.bye_game_points = result.corp_game_points + result.runner_game_points
          end
        end
        participant.active = true
        participant.save
      end
    end
  end

  def update_time_zone
    unless self.time_zone == self.organizer.time_zone
      self.time_zone = self.organizer.time_zone
      self.save
    end
  end

  private

  def self.trigger(tournament)
    tournament.closed
    tournament.rounds.each do |round|
      round.closed
    end
    tournament.activate_points
    Player.update_points(tournament)
    "Tournament has been closed."
  end

  def self.create_new(tournament, current_organizer_id)
    tournament[:state] = "Tournament is not started."
    tournament[:organizer_id] = current_organizer_id
    Tournament.new(tournament)
  end

  def seed_bye
    Participant.find_or_create_by_tournament_id_and_player_id :tournament_id => self.id, :player_id => Var.bye_id, :name => "Bye"
  end
end

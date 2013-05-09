class Tournament < ActiveRecord::Base
  attr_accessible :name, :state

  has_many :participants, :dependent => :destroy
  has_many :results
  has_many :rounds, :dependent => :destroy

  after_create :seed_bye

  private

  def closed
    self.state = "Tournament is closed."
    self.save
  end

  def self.trigger(tournament, trigger)
    tournament.closed
    tournament.rounds.each do |round|
      round.closed
    end
    tournament.activate_points
    Player.update_points(tournament)
    "Tournament has been closed."
  end

  def activate_points
    self.participants.each do |participant|
      participant.active = true
      participant.save
    end
  end

  def seed_bye
    Participant.find_or_create_by_tournament_id_and_player_id :tournament_id => self.id, :player_id => 1
  end
end

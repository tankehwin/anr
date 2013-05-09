class Player < ActiveRecord::Base
  attr_accessible :active, :country_id, :email, :match_points, :matches, :name, :prestiges, :tournaments, :username
  attr_accessible :active, :country_id, :email, :id, :match_points, :matches, :name, :prestiges, :tournaments, :username, :as => :seed

  belongs_to :country
  has_many :participants

  def self.update_points(tournament)
  	tournament.participants.each do |participant|
  	  participants = Participant.find(:all, :conditions => ["player_id = ? and active = ?", participant.player_id, true])
  	  participant.player.prestiges = participants.map(&:prestiges).sum
  	  participant.player.match_points = participants.map(&:match_points).sum
  	  participant.player.matches = participants.map(&:matches).sum
  	  participant.player.tournaments = participants.count
  	  participant.player.save
    end
  end
end

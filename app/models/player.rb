class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable
  include ActiveModel::Validations

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :active, :country_id, :match_points, :matches, :name,
                  :prestiges, :rating, :tournaments, :username

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :active, :country_id, :match_points, :matches, :name,
                  :prestiges, :rating, :tournaments, :username, :as => :seed

  belongs_to :country
  has_many :participants
  has_many :player_services

  validates :email, :email => true
  validates :name, :presence => true, :length => { :in => 2..140 }

  def self.find_for_database_authentication(conditions={})
    self.where("username = ?", conditions[:email]).limit(1).first ||
    self.where("email = ?", conditions[:email]).limit(1).first
  end

  def self.update_points(tournament)
  	tournament.participants.each do |participant|
  	  participants = Participant.find(:all, :conditions => ["player_id = ? and active = ?", participant.player_id, true])
  	  participant.player.prestiges = participants.map(&:prestiges).sum
  	  participant.player.match_points = participants.map(&:match_points).sum
  	  participant.player.matches = participants.map(&:matches).sum
  	  participant.player.tournaments = participants.count
      participant.player.rating = (participant.player.rating + participant.rating + participant.rating_scores) / 2
  	  participant.player.save
    end
  end
end

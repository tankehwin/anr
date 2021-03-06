class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable
  include ActiveModel::Validations

  attr_accessor :tournament_id

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :active, :bye_game_points, :bye_prestiges, :country_id,
                  :login, :game_points, :matches, :matches_with_bye, :name,
                  :prestiges, :rating, :tournament_id, :tournaments, :username

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :active, :bye_game_points, :bye_prestiges, :country_id,
                  :login, :game_points, :matches, :matches_with_bye, :name,
                  :prestiges, :rating, :tournaments, :username, :as => :seed

  belongs_to :country
  has_many :competitor_relations
  has_many :competitors, through: :competitor_relations, source: :competitor
  has_many :participants
  has_many :player_services

  validates :email, :email => true, :length => { :in => 6..140 }
  validates :name, :presence => true, :length => { :in => 2..140 }

  after_create :create_participant, :if => :has_participant?

  def self.find_for_database_authentication(conditions={})
    self.where("username = ?", conditions[:email]).limit(1).first ||
    self.where("email = ?", conditions[:email]).limit(1).first
  end

  def self.update_points(tournament)
    participant_bye = Participant.bye(tournament.id)
  	tournament.participants.each do |participant|
      unless participant == participant_bye
    	  participants = Participant.find(:all, :conditions => ["player_id = ? and active = ?", participant.player_id, true])
    	  participant.player.prestiges = participants.map(&:prestiges).sum
    	  participant.player.game_points = participants.map(&:game_points).sum
    	  participant.player.matches = participants.map(&:matches).sum
        if participant.obtained_bye
          participant.player.matches_with_bye = 0
          participant.player.bye_prestiges = 0
          participant.player.bye_game_points = 0
          participants.each do |p|
            participant.player.matches_with_bye = participant.player.matches_with_bye + 1 if p.obtained_bye == true
            participant.player.bye_prestiges = participant.player.bye_prestiges + p.bye_prestiges
            participant.player.bye_game_points = participant.player.bye_game_points + p.bye_game_points
          end
        end
    	  participant.player.tournaments = participants.count
        participant.player.rating = participant.player.rating + participant.rating_scores
    	  participant.player.save
        participant.results.each do |result|
          competitor_relation = CompetitorRelation.find_or_create_by_player_id_and_competitor_id(result.participant.player_id, result.opponent.player_id)
          competitor_relation.matches = competitor_relation.matches + 1
          competitor_relation.prestiges = competitor_relation.prestiges + result.prestige
          competitor_relation.game_points = competitor_relation.game_points + result.corp_game_points + result.runner_game_points
          competitor_relation.net_rating = competitor_relation.net_rating + result.rating_score
          competitor_relation.save
        end
      end
    end
  end

  private

  def self.activate_or_create(params_player)
    if params_player[:email] and not params_player[:email].blank?
      player = Player.find_by_email params_player[:email], :include => :country
      player.active = true if player
    end
    unless player
      player = Player.new(params_player, :include => :country)
      player.username = player.country.iso + ((Player.count + 90210) * 5 / 2).to_s(16).upcase
    end
    player
  end

  def has_participant?
    true if self.tournament_id
    false unless self.tournament_id
  end

  def create_participant
    Participant.create :player_id => self.id, :tournament_id => self.tournament_id, :rating => self.rating, :name => self.name, :country_id => self.country_id, :place => Participant.find_all_by_tournament_id(self.tournament_id).count
  end
end

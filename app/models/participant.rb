class Participant < ActiveRecord::Base
  attr_accessible :active, :bye_game_points, :bye_prestiges, :country_id, :drop,
                  :head_to_head, :game_points, :matches, :name, :obtained_bye,
                  :ogw, :omw, :pgw, :pmw, :place, :player_id, :points_strength,
                  :prestiges, :prestige_strength, :rating, :rating_scores,
                  :status, :tournament_id

  belongs_to :country
  belongs_to :player
  belongs_to :tournament
  has_many :results, :dependent => :destroy
  has_many :opponents, through: :results, source: :opponent

  validates :tournament_id, :presence => true, :numericality => { :only_integer => true }
  validates :player_id, :presence => true, :uniqueness => { :scope => :tournament_id, :message => "Player was already added." }, :numericality => { :only_integer => true }

  after_create :update_rating_multiplier
  after_destroy :update_rating_multiplier

  def self.bye(tournament_id)
    Participant.find_by_tournament_id_and_player_id(tournament_id, Var.bye_id)
  end

  def self.reset(tournament)
    participant_bye = Participant.bye(tournament.id)
    tournament.participants.each do |participant|
      unless participant == participant_bye
        participant.prestiges = 0
        participant.game_points = 0
        participant.head_to_head = 0
        participant.prestige_strength = 0
        participant.points_strength = 0
        participant.matches = 0
        participant.rating_scores = 0.0
        participant.pmw = 0.0
        participant.omw = 0.0
        participant.pgw = 0.0
        participant.ogw = 0.0
        participant.save
      end
    end
  end

  def self.check_past_encounter(participant1, participant2)
    flag = false
    participant1.results.each do |result|
      flag = true if result.opponent_id == participant2.id
    end
    flag
  end

  def self.update_personal_points(result)
  	result.participant.prestiges = result.participant.results.map(&:prestige).sum
  	result.participant.game_points = result.participant.results.map(&:corp_game_points).sum + result.participant.results.map(&:runner_game_points).sum
  	result.participant.matches = result.participant.results.count
  	result.participant.pmw = result.participant.prestiges.to_f / result.participant.matches.to_f / 6.0 * 100.0
  	result.participant.pmw = (100.0 / 3.0) if result.participant.pmw < (100.0 / 3.0)
  	result.participant.pgw = result.participant.game_points.to_f / result.participant.matches.to_f / 20.0 * 100.0
    result.participant.rating_scores = result.participant.results.map(&:rating_score).sum
  	result.participant.save
  end

  def self.update_opponent_points(round)
    # initialize data (must not use cache)
    participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", round.tournament_id, Var.bye_id])
    participant_bye = Participant.bye(round.tournament_id)
  	participants.each do |participant|
      unless participant.opponents.first.results.blank?
        participant.head_to_head = 0
        participant.prestige_strength = 0
        participant.points_strength = 0
        omw = 0.0
        ogw = 0.0
        fought_bye = false
        participant.opponents.each do |opponent|
          if opponent == participant_bye
            fought_bye = true
          else
            participant.head_to_head = participant.head_to_head + 1 if opponent.prestiges == participant.prestiges
            participant.prestige_strength = participant.prestige_strength + opponent.prestiges
            participant.points_strength = participant.points_strength + opponent.game_points
            omw = omw + opponent.pmw
            opponent.pgw = (100.0 / 3.0) if opponent.pgw < (100.0 / 3.0)
            ogw = ogw + opponent.pgw
          end
        end
        if fought_bye and participant.opponents.count > 1
          participant.omw = omw / (participant.opponents.count - 1).to_f
          participant.ogw = ogw / (participant.opponents.count - 1).to_f
        else
          participant.omw = omw / participant.opponents.count.to_f
          participant.ogw = ogw / participant.opponents.count.to_f
        end
        participant.save
      end
  	end
  end

  def self.update_standings(round)
    participant_bye = Participant.bye(round.tournament_id)
    place = 1
    round.tournament.participants.sort_by{|p| [p.prestiges, p.game_points, p.head_to_head, p.prestige_strength, p.points_strength, p.omw, p.pgw, p.ogw]}.reverse.each do |participant|
      unless participant == participant_bye
        participant.place = place
        participant.save
        place = place + 1
      end
    end
  end

  def self.register_player(player, tournament_id)
    params_participant = Participant.new(:tournament_id => tournament_id, :player_id => player.id, :rating => player.rating, :name => player.name, :country_id => player.country_id, :place => Participant.find_all_by_tournament_id(tournament_id).count)
    params_participant.save
  end

  private

  def self.find_by_player_id_or_create(params_participant)
    if params_participant[:player_id]
      participant = Participant.find_by_tournament_id_and_player_id(params_participant[:tournament_id], params_participant[:player_id])
      params_participant = Participant.initialize_data(params_participant)
    end
    participant = Participant.new(params_participant) unless participant
    participant
  end

  def self.initialize_data(participant)
    player = Player.find(participant[:player_id])
    participant[:place] = Participant.find_all_by_tournament_id(participant[:tournament_id]).count
    participant[:rating] = player.rating
    participant[:name] = player.name
    participant[:country_id] = player.country_id
    participant
  end

  def update_rating_multiplier
    self.tournament.rating_multiplier = Math.sqrt(self.tournament.participants.count).round
    self.tournament.save
  end
end

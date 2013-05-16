class Participant < ActiveRecord::Base
  attr_accessible :active, :bye_match_points, :bye_prestiges, :drop,
                  :head_to_head, :match_points, :matches, :obtained_bye,
                  :ogw, :omw, :pgw, :pmw, :place, :player_id, :prestiges,
                  :rating, :rating_scores, :schedule_strength, :tournament_id

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

  def self.update_personal_points(result)
  	results = Result.find_all_by_tournament_id_and_participant_id(result.tournament_id, result.participant_id, :include => :participant)
  	result.participant.prestiges = results.map(&:prestige).sum
  	result.participant.match_points = results.map(&:corp_match_points).sum + results.map(&:runner_match_points).sum
  	result.participant.matches = results.count
  	result.participant.pmw = result.participant.prestiges.to_f / result.participant.matches.to_f / 6.0 * 100.0
  	result.participant.pmw = (100.0 / 3.0) if result.participant.pmw < (100.0 / 3.0)
  	result.participant.pgw = result.participant.match_points.to_f / result.participant.matches.to_f / 20.0 * 100.0
    result.participant.rating_scores = results.map(&:rating_score).sum
  	result.participant.save
  end

  def self.update_opponent_points(round)
  	participants = Participant.find(:all, :conditions => ["tournament_id = ? and id != ?", round.tournament_id, Participant.bye(round.tournament_id).id])
  	participants.each do |participant|
      opponents_result = Result.find(:all, :conditions => ["opponent_id = ? and participant_id != ?", participant.id, Participant.bye(round.tournament_id).id], :include => :participant)
      unless opponents_result.blank?
        participant.head_to_head = 0
        participant.schedule_strength = 0
        omw = 0.0
        ogw = 0.0
        opponents_result.each do |opponent|
          participant.head_to_head = participant.head_to_head + 1 if opponent.participant.prestiges == participant.prestiges
          participant.schedule_strength = participant.schedule_strength + opponent.participant.prestiges
          omw = omw + opponent.participant.pmw
          opponent.participant.pgw = (100.0 / 3.0) if opponent.participant.pgw < (100.0 / 3.0)
          ogw = ogw + opponent.participant.pgw
        end
    	  participant.omw = omw / opponents_result.count.to_f
        participant.ogw = ogw / opponents_result.count.to_f
        participant.save
      end
  	end
  end

  def self.reset(tournament_id)
    participants = Participant.find(:all, :conditions => ["tournament_id = ? and id != ?", tournament_id, Participant.bye(tournament_id).id])
    participants.each do |participant|
      participant.prestiges = 0
      participant.match_points = 0
      participant.head_to_head = 0
      participant.schedule_strength = 0
      participant.matches = 0
      participant.rating_scores = 0.0
      participant.pmw = 0.0
      participant.omw = 0.0
      participant.pgw = 0.0
      participant.ogw = 0.0
      participant.save
    end
  end

  def self.update_standings(round)
    participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", round.tournament_id, Var.bye_id])
    participants = participants.sort_by{|participant| [participant.prestiges, participant.match_points, participant.head_to_head, participant.schedule_strength, participant.omw, participant.pgw, participant.ogw]}.reverse
    place = 1
    participants.each do |participant|
      participant.place = place
      participant.save
      place = place + 1
    end
  end

  def self.check_past_encounter(participant1, participant2)
    flag = false
    results = Result.find_all_by_tournament_id_and_participant_id(participant1.tournament_id, participant1.id)
    results.each do |result|
      flag = true if result.opponent_id == participant2.id
    end
    flag
  end

  def self.register_player(player, tournament_id)
    params_participant = Participant.new
    params_participant[:tournament_id] = tournament_id
    params_participant[:player_id] = player.id
    params_participant[:rating] = player.rating
    params_participant[:place] = Participant.find_all_by_tournament_id(tournament_id).count
    params_participant.save
  end

  private

  def self.find_by_player_id_or_create(params_participant)
    if params_participant[:player_id]
      participant = Participant.find_by_tournament_id_and_player_id(params_participant[:tournament_id], params_participant[:player_id])
      params_participant = Participant.initialize_rating(params_participant)
    end
    participant = Participant.new(params_participant) unless participant
    participant
  end

  def self.initialize_rating(participant)
    participant[:place] = Participant.find_all_by_tournament_id(participant[:tournament_id]).count
    participant[:rating] = Player.find(participant[:player_id]).rating
    participant
  end

  def update_rating_multiplier
    participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", self.tournament_id, Var.bye_id])
    self.tournament.rating_multiplier = Math.sqrt(participants.count).round
    self.tournament.save
  end
end

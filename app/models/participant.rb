class Participant < ActiveRecord::Base
  attr_accessible :active, :match_points, :matches, :ogw, :omw, :pgw, :pmw, :place, :player_id, :prestiges, :tournament_id

  belongs_to :player
  belongs_to :tournament
  has_many :results, :dependent => :destroy

  def self.bye_id(tournament_id)
  	Participant.find_or_create_by_tournament_id_and_player_id(tournament_id, 1).id
  end

  def self.update_personal_points(result)
  	results = Result.find_all_by_tournament_id_and_participant_id(result.tournament_id, result.participant_id, :include => :participant)
  	result.participant.prestiges = results.map(&:prestige).sum
  	result.participant.match_points = results.map(&:corp_match_points).sum + results.map(&:runner_match_points).sum
  	result.participant.matches = results.count
  	result.participant.pmw = result.participant.prestiges.to_f / result.participant.matches.to_f / 6.0 * 100.0
  	result.participant.pmw = (100.0 / 3.0) if result.participant.pmw < (100.0 / 3.0)
  	result.participant.pgw = result.participant.match_points.to_f / result.participant.matches.to_f / 20.0 * 100.0
  	result.participant.save
  end

  def self.update_opponent_points(round)
  	participants = Participant.find(:all, :conditions => ["tournament_id = ? and id != ?", round.tournament_id, Participant.bye_id(round.tournament_id)])
  	participants.each do |participant|
      opponents_result = Result.find(:all, :conditions => ["opponent_id = ? and participant_id != ?", participant.id, Participant.bye_id(round.tournament_id)], :include => :participant)
      unless opponents_result.blank?
        omw = 0.0
        ogw = 0.0
        opponents_result.each do |opponent|
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
    participants = Participant.find(:all, :conditions => ["tournament_id = ? and id != ?", tournament_id, Participant.bye_id(tournament_id)])
    participants.each do |participant|
      participant.prestiges = 0
      participant.match_points = 0
      participant.matches = 0
      participant.pmw = 0.0
      participant.omw = 0.0
      participant.pgw = 0.0
      participant.ogw = 0.0
      participant.save
    end
  end

  def self.update_standings(round)
    participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", round.tournament_id, 1])
    participants = participants.sort_by{|participant| [participant.prestiges, participant.match_points, participant.omw, participant.pgw, participant.ogw]}.reverse
    place = 1
    participants.each do |participant|
      participant.place = place
      participant.save
      place = place + 1
    end
  end
end

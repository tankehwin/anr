class Result < ActiveRecord::Base
  attr_accessible :corp_game_points, :opponent_id, :participant_id, :prestige,
  				  :rating_score, :runner_game_points, :schedule_id, :tournament_id

  belongs_to :schedule
  belongs_to :participant
  belongs_to :tournament
  belongs_to :opponent, class_name: "Participant"

  validates :opponent_id, :presence => true, :numericality => { :only_integer => true }
  validates :corp_game_points, :runner_game_points, :numericality => { :only_integer => true }, :inclusion => { :in => 0..10, :message => "%{value} is not a valid points" }, :allow_nil => true
end

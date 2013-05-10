class Result < ActiveRecord::Base
  attr_accessible :corp_match_points, :opponent_id, :participant_id, :prestige, :rating_score, :runner_match_points, :schedule_id, :tournament_id

  belongs_to :schedule
  belongs_to :participant
  belongs_to :tournament

  validates :opponent_id, :presence => true, :numericality => { :only_integer => true }
  validates :corp_match_points, :runner_match_points, :numericality => { :only_integer => true }, :inclusion => { :in => 0..10,
    :message => "%{value} is not a valid points" }, :allow_nil => true
end

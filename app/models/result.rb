class Result < ActiveRecord::Base
  attr_accessible :corp_match_points, :opponent_id, :participant_id, :prestige, :runner_match_points, :schedule_id, :tournament_id

  belongs_to :schedule
  belongs_to :participant
  belongs_to :tournament
end

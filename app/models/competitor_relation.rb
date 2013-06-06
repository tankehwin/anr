class CompetitorRelation < ActiveRecord::Base
  attr_accessible :competitor_id, :game_points, :matches, :net_rating, :player_id, :prestiges

  belongs_to :player
  belongs_to :competitor, class_name: "Player"
end

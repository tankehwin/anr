class Competitor < ActiveRecord::Base
  attr_accessible :competitor_id, :game_points, :matches, :net_rating, :player_id, :prestiges
end

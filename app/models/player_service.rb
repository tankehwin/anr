class PlayerService < ActiveRecord::Base
  attr_accessible :player_id, :provider, :uemail, :uid, :uname

  belongs_to :player
end

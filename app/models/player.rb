class Player < ActiveRecord::Base
  attr_accessible :email, :matches, :name, :points
  attr_accessible :email, :id, :matches, :name, :points, :as => :seed

  has_many :participants
end

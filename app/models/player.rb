class Player < ActiveRecord::Base
  attr_accessible :email, :matches, :name, :points, :username
  attr_accessible :email, :id, :matches, :name, :points, :username, :as => :seed

  has_many :participants
end

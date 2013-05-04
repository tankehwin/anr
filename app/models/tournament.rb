class Tournament < ActiveRecord::Base
  attr_accessible :name, :state

  has_many :participants, :dependent => :destroy
  has_many :results
  has_many :rounds, :dependent => :destroy
end

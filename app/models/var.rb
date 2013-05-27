class Var < ActiveRecord::Base
  def self.bye_id
  	1
  end

  def self.rating_win_multiplier
  	20.0
  end

  def self.rating_lose_divider
  	20.0
  end

  def self.per_page
  	100
  end

  def self.default_email
  	"neo@thematrix.com"
  end
end

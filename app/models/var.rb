class Var < ActiveRecord::Base
  def self.bye_id
  	1
  end

  def self.per_page
  	100
  end

  def self.default_email
  	"neo@thematrix.com"
  end
end

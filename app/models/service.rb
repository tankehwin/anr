class Service < ActiveRecord::Base
  attr_accessible :organizer_id, :provider, :uemail, :uid, :uname
end

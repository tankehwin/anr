class OrganizerService < ActiveRecord::Base
  attr_accessible :organizer_id, :provider, :uemail, :uid, :uname

  belongs_to :organizer
end

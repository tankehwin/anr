class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_admin_or_organizer!
    if admin_signed_in?
      return
    else
      authenticate_organizer!
    end
  end
end

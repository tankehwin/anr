class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    redirect_to current_organizer if organizer_signed_in?
    redirect_to console_path if admin_signed_in?
  end
  
  private
  
  # GET /pages/about
  def about
  end

  # GET /pages/contact
  def contact
  end
end

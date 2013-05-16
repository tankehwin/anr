class OrganizersController < ApplicationController
  before_filter :authenticate_organizer!, :only => :show
  # GET /organizers
  # GET /organizers.json
  def index
    @organizers = Organizer.paginate(:page => params[:page], :per_page => Var.per_page).order('id DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizers }
    end
  end

  # GET /organizers/1
  # GET /organizers/1.json
  def show
    @organizer = current_organizer
    @pre_tournaments = Tournament.paginate(:conditions => ["state = ?", "Tournament is not started."], :page => params[:pre_page], :per_page => Var.per_page).order('created_at DESC')
    @post_tournaments = Tournament.paginate(:conditions => ["state = ?", "Tournament has started."], :page => params[:post_page], :per_page => Var.per_page).order('created_at DESC')
    @closed_tournaments = Tournament.paginate(:conditions => ["state = ?", "Tournament is closed."], :page => params[:page], :per_page => Var.per_page).order('created_at DESC')
    @tournament = Tournament.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organizer }
    end
  end
end

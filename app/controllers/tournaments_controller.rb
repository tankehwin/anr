class TournamentsController < ApplicationController
  before_filter :authenticate_organizer!, :only => [:new, :edit, :create, :update, :destroy]
  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.paginate(:page => params[:page], :per_page => Var.per_page).order('created_at DESC')
    @tournament = Tournament.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tournaments }
    end
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
    @tournament = Tournament.find(params[:id])
    @participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", @tournament.id, Var.bye_id], :include => :player)
    @participant = Participant.new
    @participate = true
    @players = Player.find(:all, :conditions => ["id != ?", Var.bye_id])
    @rounds = @tournament.rounds.includes(:schedules => {:results => {:participant => :player}}).all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: [@tournament, @participants, @rounds] }
    end
  end

  # GET /tournaments/new
  # GET /tournaments/new.json
  def new
    @tournament = Tournament.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tournament }
    end
  end

  # GET /tournaments/1/edit
  def edit
    @tournament = Tournament.find(params[:id], :include => :participants)
    redirect_to @tournament, notice: @tournament.state and return if @tournament.state == "Tournament is closed."

    if params[:trigger] == "Close"
      notice = Tournament.trigger(@tournament, params[:trigger])
      respond_to do |format|
        format.html { redirect_to @tournament, notice: notice }
        format.json { render json: @tournament }
      end
    end
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.create_new(params[:tournament], current_organizer.id)

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created. To continue, add participants for this tournament and then choose the schedule type.' }
        format.json { render json: @tournament, status: :created, location: @tournament }
      else
        format.html { render action: "new" }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tournaments/1
  # PUT /tournaments/1.json
  def update
    @tournament = Tournament.find(params[:id])
    redirect_to @tournament, notice: @tournament.state and return if @tournament.state == "Tournament is closed."

    respond_to do |format|
      if @tournament.update_attributes(params[:tournament])
        format.html { redirect_to @tournament, notice: 'Tournament details was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament = Tournament.find(params[:id])
    redirect_to @tournament, notice: @tournament.state and return if @tournament.state == "Tournament is closed."
    @tournament.active = false
    @tournament.save

    respond_to do |format|
      format.html { redirect_to tournaments_url }
      format.json { head :no_content }
    end
  end
end

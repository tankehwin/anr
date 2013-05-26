class RoundsController < ApplicationController
  before_filter :authenticate_admin_or_organizer!, :only => [:show, :new, :edit, :update]
  # GET /rounds/1
  # GET /rounds/1.json
  def show
    @round = Round.find(params[:id], :include => [:tournament => {:participants => :player}, :schedules => {:results => {:participant => :player}}])
    @tournament = @round.tournament
    @participant_bye = Participant.bye(@tournament.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @round }
    end
  end

  # GET /rounds/new
  # GET /rounds/new.json
  def new
    @tournament = Tournament.find params[:tournament], :include => [:rounds, :participants]
    redirect_to @tournament, notice: @tournament.state and return if @tournament.closed?
    @round = Round.calculate_round(@tournament)

    respond_to do |format|
      format.html { redirect_to @tournament }
      format.json { render json: @tournament.rounds }
    end
  end

  # GET /rounds/1/edit
  def edit
    @round = Round.find(params[:id], :include => [:tournament, :schedules])
    @tournament = @round.tournament
    redirect_to @tournament, notice: @tournament.state and return if @tournament.closed?
    if params[:trigger] == "Manual" or params[:trigger] == "Modify"
      @schedules = Schedule.calculate_schedule(@round, params[:trigger])
      @round = Round.find(params[:id], :include => [:tournament => {:participants => :results}, :schedules => {:results => {:participant => :player}}]) if params[:trigger] == "Manual"
      @participants = Participant.find(:all, :conditions => ["tournament_id = ?", @tournament.id], :include => :player).sort_by(&:name)
      @participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", @tournament.id, Var.bye_id], :include => :player).sort_by(&:name) if (@participants.count - 1).even?
    else
      notice = Round.trigger(@round, params[:trigger])
      respond_to do |format|
        format.html { redirect_to @tournament, notice: notice }
        format.json { render json: [@round, @participants] }
      end
    end
  end

  # PUT /rounds/1
  # PUT /rounds/1.json
  def update
    @round = Round.find(params[:id], :include => [:tournament, :schedules])
    @tournament = @round.tournament
    redirect_to @tournament, notice: @tournament.state and return if @tournament.closed?

    respond_to do |format|
      if @round.update_attributes(params[:round])
        @round.update_table
        format.html { redirect_to @tournament, notice: 'Schedule was successfully updated.' }
        format.json { head :no_content }
      else
        @participants = Participant.find(:all, :conditions => ["tournament_id = ?", @tournament.id], :include => :player)
        @participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", @tournament.id, Var.bye_id], :include => :player) if (@participants.count - 1).even?
        format.html { render action: "edit" }
        format.json { render json: [@round.errors, @participants], status: :unprocessable_entity }
      end
    end
  end
end

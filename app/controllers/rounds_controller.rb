class RoundsController < ApplicationController
  # GET /rounds/1
  # GET /rounds/1.json
  def show
    @round = Round.find(params[:id], :include => :tournament)
    @participants = @round.tournament.participants.includes(:player).all
    @participant_bye = Participant.bye(@round.tournament_id)
    @schedules = @round.schedules.includes(:results => {:participant => :player}).all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @round }
    end
  end

  # GET /rounds/new
  # GET /rounds/new.json
  def new
    @tournament = Tournament.find params[:tournament]
    redirect_to @tournament, notice: @tournament.state and return if @tournament.state == "Tournament is closed."
    @round = Round.calculate_round(@tournament)
    @rounds = Round.find_all_by_tournament_id @tournament.id

    respond_to do |format|
      format.html { redirect_to @tournament }
      format.json { render json: @rounds }
    end
  end

  # GET /rounds/1/edit
  def edit
    if params[:trigger] == "Manual" or params[:trigger] == "Modify"
      @round = Round.find(params[:id], :include => :tournament)
      redirect_to @round.tournament, notice: @round.tournament.state and return if @round.tournament.state == "Tournament is closed."
      @schedules = Schedule.calculate_schedule(@round, params[:trigger])
      @round = Round.find(params[:id]) if params[:trigger] == "Manual"
      @participants = Participant.find(:all, :conditions => ["tournament_id = ?", @round.tournament_id], :include => :player)
      @participants = Participant.find(:all, :conditions => ["tournament_id = ? and player_id != ?", @round.tournament_id, Var.bye_id], :include => :player) if (@participants.count - 1).even?
    else
      @round = Round.find(params[:id], :include => :tournament)
      redirect_to @round.tournament, notice: @round.tournament.state and return if @round.tournament.state == "Tournament is closed."
      notice = Round.trigger(@round, params[:trigger])
      respond_to do |format|
        format.html { redirect_to @round.tournament, notice: notice }
        format.json { render json: @round }
      end
    end
  end

  # PUT /rounds/1
  # PUT /rounds/1.json
  def update
    @round = Round.find(params[:id], :include => :tournament)
    redirect_to @round.tournament, notice: @round.tournament.state and return if @round.tournament.state == "Tournament is closed."

    respond_to do |format|
      if @round.update_attributes(params[:round])
        @round.update_table
        format.html { redirect_to @round.tournament, notice: 'Schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round = Round.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to @round.tournament }
      format.json { head :no_content }
    end
  end
end

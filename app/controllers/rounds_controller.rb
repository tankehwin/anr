class RoundsController < ApplicationController
  # GET /rounds
  # GET /rounds.json
  def index
    @rounds = Round.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rounds }
    end
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
    @round = Round.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @round }
    end
  end

  # GET /rounds/new
  # GET /rounds/new.json
  def new
    @tournament = Tournament.find params[:tournament]
    @round = Round.calculate_round(@tournament)
    @rounds = Round.find_all_by_tournament_id @tournament.id

    respond_to do |format|
      format.html { redirect_to @tournament }
      format.json { render json: @rounds }
    end
  end

  # GET /rounds/1/edit
  def edit
    @round = Round.find(params[:id])

    if params[:trigger] == "Manual"
      @schedules = Schedule.calculate_schedule(@round)
      @round = Round.find(params[:id])
      @participants = Participant.find(:all, :conditions => ["tournament_id = ?", @round.tournament_id], :include => :player)
    elsif params[:trigger] == "Modify"
      @schedules = Schedule.find_all_by_round_id(params[:id], :include => :results)
      @participants = Participant.find(:all, :conditions => ["tournament_id = ?", @round.tournament_id], :include => :player)
    elsif params[:trigger] == "Start" or params[:trigger] == "End"
      notice = Round.trigger(@round, params[:trigger])
      respond_to do |format|
        format.html { redirect_to @round.tournament, notice: notice }
        format.json { render json: @round }
      end
    end
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(params[:round])

    respond_to do |format|
      if @round.save
        format.html { redirect_to @round, notice: 'Round was successfully created.' }
        format.json { render json: @round, status: :created, location: @round }
      else
        format.html { render action: "new" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rounds/1
  # PUT /rounds/1.json
  def update
    @round = Round.find(params[:id])

    respond_to do |format|
      if @round.update_attributes(params[:round])
        @round = Round.update_table(@round)
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

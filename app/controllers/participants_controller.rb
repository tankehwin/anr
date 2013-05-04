class ParticipantsController < ApplicationController
  # GET /participants/new
  # GET /participants/new.json
  def new
    @participant = Participant.new
    @tournament = Tournament.find params[:tournament]
    @players = Player.find(:all, :conditions => ["id != ?", 1])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant }
    end
  end

  # POST /participants
  # POST /participants.json
  def create
    @current_participant = Participant.find_by_tournament_id_and_player_id(params[:participant][:tournament_id], params[:participant][:player_id])
    params[:participant][:place] = Participant.find_all_by_tournament_id(params[:participant][:tournament_id]).count unless @current_participant
    @participant = Participant.new(params[:participant])

    respond_to do |format|
      if @current_participant
        format.html { redirect_to @participant.tournament, notice: 'Player was already added.' }
        format.json { render json: @current_participant, status: :unprocessable_entity, location: @current_participant }
      else
        if @participant.save
          format.html { redirect_to @participant.tournament, notice: 'Player was successfully added.' }
          format.json { render json: @participant, status: :created, location: @participant }
        else
          format.html { render action: "new" }
          format.json { render json: @participant.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to @participant.tournament, notice: 'Player was successfully removed.' }
      format.json { head :no_content }
    end
  end
end

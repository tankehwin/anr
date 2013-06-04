class ParticipantsController < ApplicationController
  before_filter :authenticate_admin_or_organizer!, :only => [:new, :create, :destroy]
  # GET /participants/new
  # GET /participants/new.json
  def new
    @tournament = Tournament.find(params[:tournament], :include => :organizer)
    redirect_to @tournament, notice: @tournament.state and return if @tournament.closed?
    redirect_to root_url, notice: 'Action Not Authorized' and return unless admin_signed_in? or @tournament.organizer == current_organizer
    @participant = Participant.new
    @participate = true
    @players = Player.find(:all, :conditions => ["id != ?", Var.bye_id], :select => 'id, name')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: [@tournament, @participant, @players] }
    end
  end

  # POST /participants
  # POST /participants.json
  def create
    @tournament = Tournament.find(params[:participant][:tournament_id], :include => :organizer)
    redirect_to @tournament, notice: @tournament.state and return if @tournament.closed?
    redirect_to root_url, notice: 'Action Not Authorized' and return unless admin_signed_in? or @tournament.organizer == current_organizer
    @participate = true
    @participant = Participant.find_by_player_id_or_create(params[:participant])

    respond_to do |format|
      if @participant.id
        format.html { redirect_to @tournament, notice: 'Player was already added.' }
        format.json { render json: @participant, status: :unprocessable_entity, location: @participant }
      elsif params[:participant][:player_id].nil?
        format.html { redirect_to players_url(:tournament => @tournament, :participant => @participate), notice: 'Player list is empty.' }
        format.json { render json: @participant, status: :unprocessable_entity, location: @participant }
      else
        if @participant.save
          format.html { redirect_to @tournament, notice: 'Player was successfully added.' }
          format.json { render json: @participant, status: :created, location: @participant }
        else
          @participate = true
          format.html { render action: "new" }
          format.json { render json: @participant.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant = Participant.find(params[:id], :include => {:tournament => :organizer})
    redirect_to @participant.tournament, notice: @participant.tournament.state and return if @participant.tournament.closed?
    redirect_to root_url, notice: 'Action Not Authorized' and return unless @participant.tournament.organizer == current_organizer
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to @participant.tournament, notice: 'Player was successfully removed.' }
      format.json { head :no_content }
    end
  end
end

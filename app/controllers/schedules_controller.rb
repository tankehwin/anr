class SchedulesController < ApplicationController
  before_filter :authenticate_admin_or_organizer!, :only => [:new, :edit, :update]
  # GET /schedules/new
  # GET /schedules/new.json
  def new
    @round = Round.find(params[:round], :include => {:tournament => [:organizer, :rounds]})
    redirect_to @round.tournament, notice: @round.tournament.state and return if @round.tournament.closed?
    redirect_to root_url, notice: 'Action Not Authorized' and return unless admin_signed_in? or @round.tournament.organizer == current_organizer
    @schedules = Schedule.calculate_schedule(@round, params[:trigger], params[:seed])

    respond_to do |format|
      format.html { redirect_to @round.tournament }
      format.json { render json: [@round, @schedules] }
    end
  end

  # GET /schedules/1/edit
  def edit
    @tournament = Tournament.find(params[:tournament], :include => :organizer)
    redirect_to @tournament, notice: @tournament.state and return if @tournament.closed?
    redirect_to root_url, notice: 'Action Not Authorized' and return unless admin_signed_in? or @tournament.organizer == current_organizer
    @schedule = Schedule.find(params[:id], :include => {:results => {:participant => :player}})
  end

  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    @schedule = Schedule.find(params[:id], :include => [:results => {:participant => :player}, :round => {:tournament => :organizer}])
    @tournament = @schedule.round.tournament
    redirect_to @tournament, notice: @tournament.state and return if @tournament.closed?
    redirect_to root_url, notice: 'Action Not Authorized' and return unless admin_signed_in? or @tournament.organizer == current_organizer
    params_schedule = Schedule.calculate_prestige(params[:schedule], @schedule)

    respond_to do |format|
      if @schedule.update_attributes(params_schedule)
        format.html { redirect_to @tournament, notice: "Results was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end
end

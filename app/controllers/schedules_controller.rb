class SchedulesController < ApplicationController
  # GET /schedules/new
  # GET /schedules/new.json
  def new
    @round = Round.find params[:round], :include => :tournament
    redirect_to @round.tournament, notice: @round.tournament.state and return if @round.tournament.state == "Tournament is closed."
    @schedules = Schedule.calculate_schedule(@round, params[:trigger])

    respond_to do |format|
      format.html { redirect_to @round.tournament }
      format.json { render json: [@round, @schedules] }
    end
  end

  # GET /schedules/1/edit
  def edit
    @tournament = Tournament.find params[:tournament]
    redirect_to @tournament, notice: @tournament.state and return if @tournament.state == "Tournament is closed."
    @schedule = Schedule.find(params[:id], :include => :results)
  end

  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    @schedule = Schedule.find(params[:id], :include => :results)
    @tournament = @schedule.round.tournament
    redirect_to @tournament, notice: @tournament.state and return if @tournament.state == "Tournament is closed."
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

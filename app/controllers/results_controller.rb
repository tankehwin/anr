class ResultsController < ApplicationController
  # GET /results/1/edit
  def edit
    @tournament = Tournament.find params[:tournament]
    redirect_to @tournament, notice: @tournament.state and return if @tournament.state == "Tournament is closed."
    @schedule = Schedule.find(params[:id], :include => :results)
  end
end

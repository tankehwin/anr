class PlayersController < ApplicationController
  # GET /players
  # GET /players.json
  def index
    @players = Player.paginate(:conditions => ["id != ?", Var.bye_id], :page => params[:page], :per_page => Var.per_page).order('rating DESC')
    @players_json = Player.paginate(:conditions => ["id != ?", Var.bye_id], :select => 'username, name, prestiges, match_points, matches, tournaments, rating', :page => params[:page], :per_page => 100).order('rating DESC')
    @rank_counter = (params[:page].to_i - 1) * Var.per_page if params[:page]
    @rank_counter = 0 unless params[:page]
    @title = "All Players Ranking"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players_json }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new
    @password = (100000000000 + rand(899999999999)).to_s(36)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(params[:player])
    @player.username = Country.malaysia_iso + ((Player.count + 90210) * 5 / 2).to_s(16).upcase
    @password = params[:player][:password]

    respond_to do |format|
      if @player.save
        format.html { redirect_to players_url, notice: 'Player was successfully created.' }
        format.json { render json: @player, status: :created, location: @player }
      else
        format.html { render action: "new" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to players_url, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end
end

class PlayersController < ApplicationController
  # GET /players
  # GET /players.json
  def index
    @players = Player.paginate(:conditions => ["id != ? and active != ?", Var.bye_id, false], :page => params[:page], :per_page => Var.per_page).order('rating DESC')
    @players_json = Player.paginate(:conditions => ["id != ? and active != ?", Var.bye_id, false], :select => 'username, name, prestiges, match_points, matches, tournaments, rating', :page => params[:page], :per_page => 100).order('rating DESC')
    @tournament = Tournament.find params[:tournament] if params[:tournament]
    @participate = true if params[:participant]
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
    @tournament = Tournament.find params[:tournament] if params[:tournament]
    @participate = true if params[:participant]
    @player = Player.new
    @password = (10000000000000 + rand(89999999999999)).to_s(36)
    @default_email = Var.default_email

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
    @default_email = Var.default_email
  end

  # POST /players
  # POST /players.json
  def create
    @tournament = Tournament.find params[:player][:tournament_id] if params[:player][:tournament_id]
    @participate = true if @tournament
    @password = params[:player][:password]
    @player = Player.activate_or_create(params[:player])
    @default_email = Var.default_email

    respond_to do |format|
      if @player.save
        format.html { redirect_to players_url(:tournament => @tournament, :participant => @participate), notice: 'Player was successfully created.' }
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
    @default_email = Var.default_email

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
    @player.active = false
    @player.save

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end
end

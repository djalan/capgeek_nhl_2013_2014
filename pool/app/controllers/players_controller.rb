class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
    
  # GET /players
  # GET /players.json
  def index
    @players = Player.where('season = ?', @year).order('points DESC')
    #@players = Player.where('position = "G" and salary = 0').order('points DESC')
    #@players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    
    puts "Now increasing positions if required"
    if player_params[:my_rank_position] != @player.my_rank_position
      @position = @player.position
      
      @players_to_update = if @position == 'L' or @position == 'R'
        Player.where("season = ? AND my_rank_position != 9999 AND my_rank_position >= ? AND (position = 'R' OR position = 'L')", \
          @year, player_params[:my_rank_position]).order('my_rank_position DESC')
      else
        Player.where("season = ? AND my_rank_position != 9999 AND my_rank_position >= ? AND position = ?", \
          @year, player_params[:my_rank_position], @position).order('my_rank_position DESC')
      end
      
      @players_to_update.each do |p|
        p.my_rank_position = p.my_rank_position + 1
        if p.save
          puts 'A position was increased successfully! (saved in DB)'
        else
          puts 'A position was --NOT-- increased successfully! (not saved in DB)'
        end
      end
    end
    
    puts "Now updating player and redirecting surfer"
    respond_to do |format|
      if @player.update(player_params)
        #format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.html { redirect_to session[:return_to], notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end
  
  
  def edit_individual
    @players = Player.find(params[:player_ids])
  end
  
  
  def update_individual
    @players = Player.update(params[:players].keys, params[:players].values).reject { |p| p.errors.empty? }
    if @players.empty?
      puts 'updated'
      flash[:notice] = "Players updated"
      redirect_to players_path
    else
      puts 'not working'
      flash[:notice] = "Players --NOT-- updated"
      render :action => "edit_individual"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :points, :goals, :assists, :rank, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :team, :last_team, :power_play, :pp_last_year, :position, :salary, :color, :games, :drafted, :season, :my_rank_global, :my_rank_position)
    end
    
end

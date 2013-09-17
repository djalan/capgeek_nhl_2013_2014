class HomeController < ApplicationController
  before_action :set_player, only: [:edit, :update]


  # GET /home
  def index
    @no_drafted = Player.where('drafted = "yes"').count
    @players = Player.where('drafted = "no"').order('points DESC')
    
    #@search = Player.new(params[:player])
    #@players = Player.where('position = ?', @search.position)
  end
  
  
  def all
    @players = Player.where('drafted = "no"').order('points DESC')
  end
  
  def skaters
    @players = Player.where('drafted = "no" AND position != "G"').order('points DESC')
  end
  
  def wingers
    @players = Player.where('drafted = "no" AND (position = "L" OR position ="R")').order('points DESC')
  end
  
  def centers
    @players = Player.where('drafted = "no" AND position = "C"').order('points DESC')
  end
  
  def defenders
    @players = Player.where('drafted = "no" AND position = "D"').order('points DESC')
  end
    
  def pplast
  end
  
  def standings
  end
  
  def edit
  end
  
  # GET home/pp
  def pp
    @teams = ['Avalanche', 'Blackhawks', 'Bluejackets', 'Blues', 'Bruins', 'Canadiens', \
      'Canucks', 'Capitals', 'Coyotes', 'Devils', 'Ducks', 'Flames', 'Flyers', 'Hurricanes', \
      'Islanders', 'Jets', 'Kings', 'Lightning', 'Mapleleafs', 'Oilers', 'Panthers', 'Penguins', \
      'Predators', 'Rangers', 'Redwings', 'Sabres', 'Senators', 'Sharks', 'Stars', 'Wild']
  end
  
  
  def i
    @players = Player.limit(10)
  end
  
  
  def test
  end
  
  def draft
    @cap = 64300000
    @alain = @ben = @mark = @math = @couv = 0
  end
  
  
  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to home_i_path, notice: 'Player was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end
  


  def edit_individual
    @players = Player.find(params[:player_ids])
  end

   
  def update_individual
    @players = Player.update(params[:players].keys, params[:players].values).reject { |p| p.errors.empty? }
    if @players.empty?
      flash[:notice] = "Players updated"
      redirect_to players_path
    else
      render :action => "edit_individual"
    end
  end  
 
  
  
  private
  
  def player_info(team, position)
    Player.where("team = '#{team}' AND power_play = '#{position}' AND drafted != 'yes'").take
    #useless cuz not external   Player.where("team = ? AND power_play = ?", team, position).take
  end
  
  def player_drafted(person, position)
    if position == 'W'
      Player.where("drafted = '#{person}' AND (position = 'L' OR position ='R')")
    else
      Player.where("drafted = '#{person}' AND position = '#{position}'")
    end
  end
  
  helper_method :player_info, :player_drafted

=begin
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :points, :goals, :assists, :rank, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :team, :last_team, :power_play, :pp_last_year, :position, :salary, :color, :games, :drafted)
    end
=end


end

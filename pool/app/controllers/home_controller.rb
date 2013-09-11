class HomeController < ApplicationController
  before_action :set_player, only: [:edit, :update]


  # GET /home
  def index
    @players = Player.all
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
    Player.where("team = '#{team}' AND power_play = '#{position}'").take
    #useless cuz not external   Player.where("team = ? AND power_play = ?", team, position).take
  end
  
  helper_method :player_info

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

class HomeController < ApplicationController
  before_action :set_player, only: [:edit, :update]


  # GET /home
  def index
    @players = Player.all
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :points, :goals, :assists, :rank, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :team, :last_team, :power_play, :pp_last_year, :position, :salary, :color, :games, :drafted)
    end

end

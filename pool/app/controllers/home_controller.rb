class HomeController < ApplicationController

  # GET /home
  def index
    @no_drafted = Player.where('drafted = "yes"').count
    @players = Player.where('drafted = "no"').order('points DESC')
    
    #@search = Player.new(params[:player])
    #@players = Player.where('position = ?', @search.position)
  end
  
  
  def all
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND salary <= ?', params[:salary_max]).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no"').order('points DESC')
    end
  end
  
  def skaters
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position != "G" AND salary <= ?', params[:salary_max]).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position != "G"').order('points DESC')
    end
  end
  
  def wingers
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND (position = "L" OR position ="R") AND salary <= ?', params[:salary_max]).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND (position = "L" OR position ="R")').order('points DESC')
    end
  end
  
  def centers
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "C" AND salary <= ?', params[:salary_max]).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "C"').order('points DESC')
    end
  end
  
  def defenders
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "D" AND salary <= ?', params[:salary_max]).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "D"').order('points DESC')
    end
  end
  
  def rank
    @list = Player.where('rank != "nil"').order('rank ASC')
  end
  
  def edit_rank
  end
  
  def update_rank
    
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
    @total_players = Player.count
    @total_drafted = Player.where("drafted != 'no'").count
    
    @cap = 64300000
    @nbr_drafted = {}
    @spent = {}
    @left = {}
    @average = {}
    
    ['Alain', 'Pat', 'Ben', 'Mark', 'Math', 'Couv'].each do |person|
      @nbr_drafted[person]  = Player.where("drafted = '#{person}'").count
      @spent[person]    = Player.select(:salary).where("drafted = '#{person}'").sum(:salary)
      @left[person]     = @cap - @spent[person]
      @average[person]  = @left[person] / (20 - @nbr_drafted[person])
    end
  end
  
  
  
  
  
=begin  
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
=end

=begin
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
=end


end

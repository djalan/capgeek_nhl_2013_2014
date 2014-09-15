class HomeController < ApplicationController

  # GET /home
  def index
    session[:return_to] = request.fullpath
    @no_drafted = Player.where('drafted = "yes" AND season = ?', @year).count
    @players = Player.where('drafted = "no" AND season = ?', @year).order('points DESC')
    
    #@search = Player.new(params[:player])
    #@players = Player.where('position = ?', @search.position)
  end
  
  
  def all
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND season = ?', @year).order('points DESC')
    end
  end
  
  def skaters
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position != "G" AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position != "G" AND season = ?', @year).order('points DESC')
    end
  end
  
  def wingers
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND (position = "L" OR position ="R") AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND (position = "L" OR position ="R") AND season = ?', @year).order('points DESC')
    end
  end
  
  def centers
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "C" AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "C" AND season = ?', @year).order('points DESC')
    end
  end
  
  def defenders
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "D" AND salary <= ? AND season = ?', params[:salary_max], @year).order('points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "D" AND season = ?', @year).order('points DESC')
    end
  end
  
  ############
  # RANK
  ############
  def skaters_rank
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position != "G" AND salary <= ? AND season = ?', params[:salary_max], @year).order('my_rank_position ASC', 'points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position != "G" AND season = ?', @year).order('my_rank_position ASC', 'points DESC')
    end
  end
  
  def wingers_rank
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND (position = "L" OR position ="R") AND salary <= ? AND season = ?', params[:salary_max], @year).order('my_rank_position ASC', 'points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND (position = "L" OR position ="R") AND season = ?', @year).order('my_rank_position ASC', 'points DESC')
    end
  end
  
  def centers_rank
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "C" AND salary <= ? AND season = ?', params[:salary_max], @year).order('my_rank_position ASC', 'points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "C" AND season = ?', @year).order('my_rank_position ASC', 'points DESC')
    end
  end
  
  def defenders_rank
    session[:return_to] = request.fullpath
    if params[:salary_max]
      @players = Player.where('drafted = "no" AND position = "D" AND salary <= ? AND season = ?', params[:salary_max], @year).order('my_rank_position ASC', 'points DESC')
      flash.now[:notice] = params[:salary_max]
    else
      @players = Player.where('drafted = "no" AND position = "D" AND season = ?', @year).order('my_rank_position ASC', 'points DESC')
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
    session[:return_to] = request.fullpath
    @teams = ['Avalanche', 'Blackhawks', 'Bluejackets', 'Blues', 'Bruins', 'Canadiens', \
      'Canucks', 'Capitals', 'Coyotes', 'Devils', 'Ducks', 'Flames', 'Flyers', 'Hurricanes', \
      'Islanders', 'Jets', 'Kings', 'Lightning', 'Mapleleafs', 'Oilers', 'Panthers', 'Penguins', \
      'Predators', 'Rangers', 'Redwings', 'Sabres', 'Senators', 'Sharks', 'Stars', 'Wild']
  end
  
  
  def i
    session[:return_to] = request.fullpath
    @players = Player.limit(10)
  end
  
  
  def test
  end
  
  def draft
    session[:return_to] = request.fullpath
    case @year
    when '2013-2014'
      @cap = 64_300_000
      @poolers = ['Alain', 'Ben', 'Mark', 'Couv']
      @max_to_draft = 20
    when '2014-2015'
      @cap = 69_000_000
      @poolers = ['Ben', 'Alain', 'Mark', 'Math']
      @max_to_draft = 20
    end
    
    @total_players = Player.where('season = ?', @year).count
    @total_drafted = Player.where("drafted != 'no' AND season = ?", @year).count
    
    @nbr_drafted = {}
    @spent = {}
    @left = {}
    @average = {}
    
    @poolers.each do |person|
      @nbr_drafted[person]  = Player.where("drafted = '#{person}' AND season = ?", @year).count
      @spent[person]    = Player.select(:salary).where("drafted = '#{person}' AND season = ?", @year).sum(:salary)
      @left[person]     = @cap - @spent[person]
      if @nbr_drafted[person] == @max_to_draft
        @average[person] = @left[person]
      else
        @average[person]  = @left[person] / (@max_to_draft - @nbr_drafted[person])
      end
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

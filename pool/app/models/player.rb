class Player < ActiveRecord::Base
  
  POOLERS = ['Alain', 'Ben', 'Couv', 'Mark', 'Math', 'Pat', 'no', 'yes']
  
  COLORS = ['green', 'yellow', 'orange', 'red', 'cyan', 'white']



  validates :name, :points, :goals, :assists, :rank, :games, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :position, :salary,
  presence: true

  validates :points, :goals, :assists, :rank, :games, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :salary,
  numericality: {greater_than_or_equal_to: 0}

  validates :rank, :nhl_rank,
  uniqueness: true

  validates :position,
  format: { with: /D|C|L|R|G/i, message: 'must be D C L R G' }

  validates :power_play, :pp_last_year,
  allow_blank: true, format: { with: /F1|F2|F3|F4|D1|D2|D3/i, message: 'must be F1 F2 F3 F4 D1 D2' }
    
  validates :color,
  inclusion: COLORS
    
  validates :drafted,
  inclusion: POOLERS
    


  #validate :points_equal_sum_goals_assists, :nhl_points_equal_sum_nhl_goals_nhl_assists



  private

  def points_equal_sum_goals_assists
    errors.add(:points, "total of points different than sum of goals + assists") unless self.points != (self.goals + self.assists) 
  end


  def nhl_points_equal_sum_nhl_goals_nhl_assists
    errors.add(:nhl_points, "total of nhl_points different than sum of nhl_goals + nhl_assists") unless self.nhl_points != (self.nhl_goals + self.nhl_assists)
  end


end

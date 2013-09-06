class Player < ActiveRecord::Base

#  attr_accessible :name, :points, :goals, :assists, :rank, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :team, :last_team, :power_play, :pp_last_year, :position, :salary, :color

  validates :name, :points, :goals, :assists, :rank, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :position, :salary,
    presence: true

  validates :points, :goals, :assists, :rank, :nhl_points, :nhl_goals, :nhl_assists, :nhl_rank, :salary,
    numericality: {greater_than_or_equal_to: 0}

  validates :rank, :nhl_rank,
    uniqueness: true

  validates :position,
    format: {
      with: /D|C|L|R|G/i, 
      message: 'must be D C L R G'
    }

  validates :power_play, :pp_last_year,
    allow_blank: true,
    format: {
      with: /F1|F2|F3|F4|D1|D2/i, 
      message: 'must be F1 F2 F3 F4 D1 D2'
    }

#  validates :team, :last_team, :power_play, :pp_last_year, :color, allow_blank: true

end

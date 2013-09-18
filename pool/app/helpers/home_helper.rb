module HomeHelper
  
  
  
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
  
  
  
  
end

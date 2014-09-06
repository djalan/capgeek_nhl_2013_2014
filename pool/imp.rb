#!/usr/bin/env ruby



require 'fileutils'


year = '2014-2015'


def go
  File.open(File.expand_path('nhl_to_rails.csv')) do |file|
    file.each_line do |line|
      l = line.split(';')
      p = Player.new

      p.nhl_rank = l[0]
      p.name = l[1]
      p.team = l[2]
      p.last_team = l[3]
      p.position = l[4]
      p.games = l[5]
      p.nhl_goals = l[6]
      p.nhl_assists = l[7]
      p.nhl_points = l[8]
      p.goals = l[9]
      p.assists = l[10]
      p.points = l[11]
      p.salary = l[12]
      p.rank = l[13]
      p.drafted = false
      p.color = 'white'
      p.year = year

      printf("%-25s %s\n", p.name, p.valid?) unless p.valid?
      p.save
    end
  end
end


def import_pp_color
  File.open(File.expand_path('nhl-1.csv')) do |file|
    file.each_line do |line|
      l = line.split(';')
      name = l[0]
      pp = l[1]
      color = l[2]
      p = Player.where('name = ?', name).take
      p.power_play = pp
      p.color = color
      p.save
    end
  end
end



def goalers
  File.open(File.expand_path('goalers.csv')) do |file|
    rank = 9999
    file.each_line do |line|
      rank = rank + 1
      l = line.split(';')
      
      p = Player.new

      p.rank = rank
      p.nhl_rank = rank
      p.name = l[1]
      p.last_team = l[2]
      p.team = l[2]
      p.games = l[3]
      p.position = 'G'
      p.nhl_goals = l[5]
      losses = l[6]
      ot = l[7]
      p.nhl_assists = l[8]
      p.goals = l[9]
      p.assists = l[10]
      our_ot = l[11]
      p.points = l[12]
      p.nhl_points = p.points
      p.salary = 0
      p.drafted = 'no'
      p.color = 'white'
      p.year = year

      #printf("%-25s %s\n", p.name, p.valid?)
      printf("%-25s %s\n", p.name, p.valid?) unless p.valid?
      p.save
    end
  end
end
      
  
  
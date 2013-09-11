#!/usr/bin/env ruby



require 'fileutils'



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

      printf("%-25s %s\n", p.name, p.valid?) unless p.valid?
      p.save
    end
  end
end


def import_pp_color
  File.open(File.expand_path('pp.csv')) do |file|
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
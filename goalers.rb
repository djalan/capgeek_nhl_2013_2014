#!/usr/bin/env ruby



require 'nokogiri'
require 'open-uri'


year=2014
url = "http://www.nhl.com/ice/playerstats.htm?fetchKey=#{year}2ALLGAGAll&sort=wins&viewName=summary"
file = "get/nhl_goalers.html"



File::open( file, 'w' ) { |f| f << open(url).read }



puts "rank;name;old_team;gp;gs;wins;losses;ot;so;our_wins;our_so;our_ot;our_total"
html = Nokogiri::HTML(File.open(File.expand_path(file)))
table = html.css('tbody tr')
table.each do |player|
	cols = player.css('td')

	rank = cols[0].text
	name = cols[1].text
	old_team = cols[2].text
	gp = cols[3].text
	gs = cols[4].text
	wins = cols[5].text
	losses = cols[6].text
	ot = cols[7].text
	so = cols[13].text

	our_wins = wins.to_i * 3
	our_so = so.to_i * 5
	our_ot = ot.to_i * 1
	our_total = our_wins + our_so + our_ot

	puts "#{rank};#{name};#{old_team};#{gp};#{gs};#{wins};#{losses};#{ot};#{so};#{our_wins};#{our_so};#{our_ot};#{our_total}"
end

#!/usr/bin/env ruby



require 'nokogiri'


last = 30


puts "rank;name;old_team;pos;gp;goals;assists;points"

for i in (1..last)
	html = Nokogiri::HTML(File.open(File.expand_path("#{i}.html")))
	table = html.css('tbody tr')
	table.each do |player|
		cols = player.css('td')

		rank = cols[0].text
		name = cols[1].text
		old_team = cols[2].text
		pos = cols[3].text
		gp = cols[4].text
		goals = cols[5].text
		assists = cols[6].text
		points = cols[7].text

		puts "#{rank};#{name};#{old_team};#{pos};#{gp};#{goals};#{assists};#{points}"
	end
end

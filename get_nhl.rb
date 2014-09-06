#!/usr/bin/env ruby



require 'open-uri'


year=2014
nhl_base = "http://www.nhl.com/ice/playerstats.htm?fetchKey=#{year}2ALLSASAll&viewName=summary&sort=points&pg="
last = 30

for i in (1..last)
	url = "#{nhl_base}#{i}"
	save_file = "get/nhl_#{i}.html"
	File::open( save_file, 'w' ) do |f|
		f << open(url).read
	end
end

#!/usr/bin/env ruby



require 'open-uri'



nhl_base = "http://www.nhl.com/ice/playerstats.htm?fetchKey=20132ALLSASAll&viewName=summary&sort=points&pg="
last = 28

for i in (1..last)
	url = "#{nhl_base}#{i}"
	save_file = "get/#{i}.html"
	File::open( save_file, 'w' ) do |f|
		f << open(url).read
	end
end

#!/usr/bin/env ruby



require 'open-uri'



nhl_base = "http://www.nhl.com/ice/playerstats.htm?fetchKey=20122ALLSASAll&viewName=summary&sort=points&pg="
last = 30

for i in (1..last)
	url = "#{nhl_base}#{i}"
	save_file = "#{i}.html"
	File::open( save_file, 'w' ) do |f|
		f << open(url).read
	end
end

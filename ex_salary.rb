#!/usr/bin/env ruby



require 'nokogiri'



teams = %W{ducks bruins sabres flames hurricanes blackhawks avalanche bluejackets stars redwings oilers panthers kings wild canadiens predators devils islanders rangers senators flyers coyotes penguins sharks blues lightning mapleleafs canucks capitals jets}


teams.each do |team|
	html = Nokogiri::HTML(File.open(File.expand_path("get/capgeek_#{team}.html")))
	#html = Nokogiri::HTML(File.open(File.expand_path("get/capgeek_bruins.html")))
	html_table = html.css("tbody tr")
	category = 'None yet'
	html_table.each do |row|
		bb = row.css('strong').text # buyouts or buried
		category = bb unless bb.empty?
		player = row.css('td[class = "player"]')
		unless category == 'Buyouts' || category == 'Buried'
			unless player.css('a').empty?
				name = /^(?:[A-Z]{1} )?(?<last>[[:print:]]*),[[:space:]]*(?<first>[[:print:]]*) .{1}\n?.*$/.match(player.text)
				unless name.nil? #td class = 'player' used for titles in table
					cap = row.at_css('span[class = "cap_hit"]')
					cap_hit = if cap.nil? then 'Not signed' else cap.text end
					puts "#{name['first']} #{name['last']};#{cap_hit};#{team.capitalize};#{category}"
				end
			end
		end
	end
  #break
end



__END__

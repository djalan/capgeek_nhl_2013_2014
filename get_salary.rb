#!/usr/bin/env ruby



require 'open-uri'



website_url = "http://www.capgeek.com"

teams = %W{ducks bruins sabres flames hurricanes blackhawks avalanche bluejackets stars redwings oilers panthers kings wild canadiens predators devils islanders rangers senators flyers coyotes penguins sharks blues lightning mapleleafs canucks capitals jets}



teams.each do |team|
	url = "#{website_url}/#{team}"
	save_file = "get/capgeek_#{team}.html"
	File::open(save_file, 'w') do |f|
		f << open(url).read
	end
end



__END__

require 'open-uri'
require 'nokogiri'
require 'csv'

url = "http://www.parl.gc.ca/HouseChamberBusiness/ChamberVoteDetail.aspx?Language=E&Mode=1&Parl=41&Ses=2&FltrParl=41&FltrSes=2&Vote=467"
alt_tags = Array.new 
page = Nokogiri::HTML(open(url))

vote = []

alt_tags = page.css('img').map{ |i| i['alt'] }

vote << alt_tags

party = []

 page.css('td[headers="Caucus"]').each do |line|
 	party << line.text
 end

name = []

 page.css('a.WebOption').each do |line|
 	name << line.text
 end

CSV.open("Party_vote.csv", "w") do |file|
	file << ["Member", "Pary", "Vote"]

	name.length.times do |i|
		file << [name[i], party[i], vote[i]]
	end
end
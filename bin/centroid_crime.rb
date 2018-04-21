#!/usr/bin/ruby

require 'mongo'


client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')
coll = client[:crime]

#ag = coll.aggregate([
#	{"$match"=> {"properties.type_of_crime": "Other_Theft"}},
#  {"$replaceRoot"=> { newRoot: "$location" }},
#  {"$project"=>	{ "type": 1, szerokosc: { "$arrayElemAt"=> [ "$coordinates", 0 ] },dlugosc: { "$arrayElemAt"=> [ "$coordinates", -1 ] }}},
#  {"$group"=> { _id: "Other_Theft" ,srednia_szerokosc: { "$avg" => "$szerokosc"}, srednia_dlugosc: { "$avg"=> "$dlugosc"} } }
#] )

# Other_Theft

puts "Podaj typ"
type_to_search = gets.chomp #ogarnac male duze literky

ag = coll.aggregate([
	{"$match"=> {"properties.type_of_crime": type_to_search}},
  {"$replaceRoot"=> { newRoot: "$location" }},
  {"$project"=>	{ "type": 1, szerokosc: { "$arrayElemAt"=> [ "$coordinates", 0 ] },dlugosc: { "$arrayElemAt"=> [ "$coordinates", -1 ] }}},
  {"$group"=> { _id: type_to_search ,srednia_szerokosc: { "$avg" => "$szerokosc"}, srednia_dlugosc: { "$avg"=> "$dlugosc"} } }
] )

ag.each do |document|
  puts document
end

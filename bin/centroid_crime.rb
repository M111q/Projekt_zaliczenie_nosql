#!/usr/bin/ruby

require 'mongo'


client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')
coll = client[:crime_driver]
export = client[:crime_export]

# Other_Theft

puts "Podaj typ"
type_to_search = 'other_theft' # gets.chomp.downcase.tr(" ", "_")

ag = coll.aggregate([
	{"$match"=> {"properties.type_of_crime": type_to_search}},
  {"$replaceRoot"=> { newRoot: "$location" }},
  {"$project"=>	{ "type": 1, szerokosc: { "$arrayElemAt"=> [ "$coordinates", 0 ] },dlugosc: { "$arrayElemAt"=> [ "$coordinates", -1 ] }}},
  {"$group"=> { _id: type_to_search ,srednia_szerokosc: { "$avg" => "$szerokosc"}, srednia_dlugosc: { "$avg"=> "$dlugosc"} } }
] )


kordy = []
ag.each do |document|
	kordy.push(document[:srednia_szerokosc])
	kordy.push(document[:srednia_dlugosc])
end

centroid_doc = {"type"=> "Feature", "location"=> { "type"=> "Point", "coordinates"=> kordy },
 "properties"=> { "name"=> "centroid " + type_to_search, "marker-color"=> "#ff0000", "marker-size"=> "large"} }

#doc_to_export = []
#ag.each do |document|
#  puts document
#	doc_to_export = document
#end

result = export.insert_one(centroid_doc)

puts "Wyesportowano do crime_export"

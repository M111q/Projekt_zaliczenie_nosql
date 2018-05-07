#!/usr/bin/ruby

require 'mongo'


client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')
coll = client[:crime_driver]
export = client[:crime_export]

# Other_Theft
puts "Podaj kolor dla punktów (kod heksadecymalny np: aaff00)" #TODO walidacja
chosen_color = "#" + gets.chomp

puts "Wyszukaj typ"
type_to_search = gets.chomp # gets.chomp.downcase.tr(" ", "_")

all_chosen_crimes = coll.find({ "properties.type_of_crime"=> type_to_search })



all_chosen_crimes.each do |document|
  x = {:"marker-color" => chosen_color}
	document["properties"].merge!(x)
	result = export.insert_one(document)
end

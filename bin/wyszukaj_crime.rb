#!/usr/bin/ruby

require 'mongo'


client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')
coll = client[:crime_driver]
wynik = client[:wynik]

puts "Wyszukaj typ"
type_to_search = 'other_theft' # gets.chomp.downcase.tr(" ", "_")

all_chosen_crimes = coll.find({ "properties.type_of_crime"=> type_to_search })



all_chosen_crimes.each do |document|
  puts document
end

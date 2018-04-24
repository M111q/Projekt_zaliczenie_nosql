#!/usr/bin/ruby

require 'mongo'


client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')
coll = client[:crime_driver]

puts "Podaj rok" #TODO walidacja
year_to_search = gets.chomp
puts "Podaj miesiac" #TODO walidacja
month_to_search = gets.chomp

all_chosen_crimes = coll.find({ "properties.year"=> year_to_search.to_i,
  "properties.month"=> month_to_search.to_i })#.limit(10).to_a

properties = []
all_crimes = []
all_chosen_crimes.each do |document| #kazdy document to jeden json
  document.each do |x| #kazdy x to element jsona
    properties = x #
  end

all_crimes.push(properties[1][:type_of_crime])
end

puts all_crimes.group_by{|e| e}.map{|k, v| [k, v.length]}.to_h

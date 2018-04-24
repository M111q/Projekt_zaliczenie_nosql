#!/usr/bin/ruby

require 'mongo'


client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')
coll = client[:crime_driver]
export = client[:crime_export]

puts "Podaj szerokosc geograficzna" #TODO walidacja
longitude_to_search = gets.chomp
puts "Podaj dlugosc geograficzna" #TODO walidacja
latitude_to_search = gets.chomp

#[ -123.122247, 49.27508908 ] },

matched_crime = coll.find(
  {
    "location"=>
      { "$near"=>
        {
          "$geometry"=> { "type"=> "Point",  "coordinates"=> [ longitude_to_search.to_f, latitude_to_search.to_f ] },
          "$minDistance"=> 1000,
          "$maxDistance"=> 5000
        }
      }
   }
).limit(200).to_a


#matched_crime.each do |document|
#  puts document
#end

def export_to_collection(matched_crime)
  doc_to_export = []
    matched_crime.each do |document|
  doc_to_export = document
  end
  result = export.insert_one(doc_to_export)
  puts "Zapisano w kolekcji crime_export"
end






searched_place = {"type"=> "Feature", "location"=> { "type"=> "Point", "coordinates"=> [ longitude_to_search.to_f, latitude_to_search.to_f ] },
 "properties"=> { "name"=> "searched_place", "marker-color"=> "#ffec00", "marker-size"=> "large"} }

puts "Znaleziono #{matched_crime.count} przestepstw w podanej okolicy"

if matched_crime.count > 0
  check = false

  while check == false
      puts "Czy wyexportować? T/N"
      input = gets.chomp.rstrip.upcase
      if input == 'T'
        result = export.insert_one(searched_place)
        matched_crime.each do |document|
          result = export.insert_one(document)
        end
        puts "Zapisano w kolekcji crime_export"
        check = true
      elsif input == 'N'
        puts "Koniec"
        check = true
      else
        puts "Odpowiedz wpisujac T lub N"
      end
   end
end

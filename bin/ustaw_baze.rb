#!/usr/bin/ruby

require 'mongo'


client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')
coll = client[:crime_driver]

coll.indexes.create_one( { "location"=> "2dsphere" } )

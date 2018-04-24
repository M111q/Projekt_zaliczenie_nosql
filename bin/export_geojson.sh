#! /bin/bash


mongoexport -c crime_export --out=crime_temp.geojson

sed -i 's/location/geometry/;s/$/ , /;$s/ , $//g' crime_temp.geojson 

echo -e "{
  \"type\": \"FeatureCollection\",
  \"features\": [" > crime.geojson

cat crime_temp.geojson >> crime.geojson

echo -e "]
}" >> crime.geojson

rm crime_temp.geojson

mv crime.geojson ../data/

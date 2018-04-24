#! /bin/bash

cd ../data/

mongoimport --drop -c crime_temp --headerline --type csv crime.csv
mongo --eval 'db.crime_temp.deleteMany({"HUNDRED_BLOCK" : "OFFSET TO PROTECT PRIVACY"})'
mongoexport -c crime_temp --out=crime_temp.json
mongo --eval 'db.crime_temp.drop()'

cat crime_temp.json |tr " " "_" |tr "," " " | tr ":" " " |tr "}" " " | tee temp

cat temp | while read line
do
  
tablica=($line)
type_of_crime=`echo "${tablica[4]}" | tr '[:upper:]' '[:lower:]'`
echo -e "
 {
    \"type\": \"Feature\",
    \"location\": {
      \"type\": \"Point\",
      \"coordinates\": [
        ${tablica[26]},
        ${tablica[24]}
      ]
    },
    \"properties\": {
      \"type_of_crime\": $type_of_crime,
      \"year\": ${tablica[6]},
      \"month\": ${tablica[8]},
      \"day\": ${tablica[10]},
      \"hour\": ${tablica[12]},
      \"minute\": ${tablica[14]}}
    }"
done | tee crime.json


rm temp
rm crime_temp.json
cd ../bin/

echo "W folderze data wygenerowano plik: crime.json"
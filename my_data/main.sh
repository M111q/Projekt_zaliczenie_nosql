#! /bin/bash

function generowanie_csv()
{
/usr/bin/time --portability mongoimport --drop $1 --headerline --type csv Police_Sample.csv --collection police --writeConcern '$2' 2> temp
 tail -n 3 temp > czas
 rm temp
 cat czas | tr -s '\n' ' ' | tr -s ' ' '\t' |tee -a czas.csv
 echo >> czas.csv
 rm czas
}
function import()
{
type=$1
write_concern=$2
cat czas.csv | tr -s '[:blank:]' ',' | while IFS=, read -r col1 col2 col3 col4 col5 col6; do   echo "{type:'$type',write_concern:'$write_concern',$col1:$col2,$col3:$col4,$col5:$col6}"; done \
| mongoimport  --host localhost:27001  -c czasy
rm czas.csv
}

mongo --host localhost:27001 --eval "db.czasy.drop()"

#replica sets
{ for i in {1..5}; do generowanie_csv  "--host localhost:27001" "{w:1,j:true,wtimeout:500}"; done ; }
import "replica sets" "{w:1,j:true,wtimeout:500}"
#replica sets
{ for i in {1..5}; do generowanie_csv  "--host localhost:27001" "{w:2,j:true,wtimeout:500}"; done ; }
import "replica sets" "{w:2,j:true,wtimeout:500}"
#replica sets
{ for i in {1..5}; do generowanie_csv  "--host localhost:27001" "{w:1,j:false,wtimeout:500}"; done ; }
import "replica sets" "{w:1,j:false,wtimeout:500}"
#replica sets
{ for i in {1..5}; do generowanie_csv  "--host localhost:27001" "{w:2,j:false,wtimeout:500}"; done ; }
import "replica sets" "{w:2,j:false,wtimeout:500}"

mongo --host localhost:27001  < mongo_script.js
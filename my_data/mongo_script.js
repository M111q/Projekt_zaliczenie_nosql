db.czasy_srednie.drop()

db.czasy.aggregate([
{  "$group": {"_id": "$write_concern","sredni_czas_real": { "$avg": "$real" },"sredni_czas_user": { "$avg": "$user" },"sredni_czas_sys": { "$avg": "$sys" } } },
{$addFields: {
              "type": "replica sets"
           }},
{ $out : "czasy_srednie" } 
])


print("|typ|write_concern|sredni czas real|sredni czas user|sredni czas system|")
print("|-|-|-|-|-|")
db.czasy_srednie.find().forEach(function(r) { print("|", r.type, "|", r._id, "|", r.sredni_czas_real,"|", r.sredni_czas_user,"|", r.sredni_czas_sys,"|") })


# Projekt_zaliczenie_nosql
## Ruby Driver

### Wykorzystane dane:
[Crime in Vancouver](https://www.kaggle.com/wosaku/crime-in-vancouver/data)

Data of crimes in Vancouver (Canada) from 2003 to 2017
Columns: 
1) TYPE - Type of Crime - string
1) YEAR - Year when the reported crime activity occurred - numeric
1) MONTH - Month when the reported crime activity occurred - numeric
1) DAY - Day when the reported crime activity occurred - numeric
1) HOUR - Hour when the reported crime activity occurred - numeric
1) MINUTE - Minute when the reported crime activity occurred - numeric
1) HUNDRED_BLOCK - Generalized location of the report crime activity - numeric
1) NEIGHBOURHOOD - Neighbourhood where the reported crime activity occurred - numeric
1) X - Coordinate values projected in UTM Zone 10 - numeric
1) Y - Coordinate values projected in UTM Zone 10 - numeric
1) Latitude - Coordinate values converted to Latitude - numeric
1) Longitude - Coordinate values converted to Longitude - numeric

## Przygotowanie json z pliku crime.csv
```bash
./generowanie_json.sh
```

## Import danych (wygenerowany json) do mongo:
```bash
./importowanie.sh
```

## Utworzenie geo-indeksu 
```bash
./ustaw_baze.rb
```
Tworzy geo_indeks potrzebny do skryptu punkty_w_okolicy.rb

## Wypisanie przestępstw w podanej okolicy
```bash
./punkty_w_okolicy.rb
```
Pobiera długosc i szerokość geograficzną od użytkownika i liczy ilość zbrodni w okolicy ("$minDistance" : 1000, "$maxDistance" : 5000). Następnie skrypt pyta użytkownika czy zapisac w kolekcji crime_export wyszukane zbrodnie.

## Wyliczanie centroidy podanego prze użytkownika przestępstwa
```bash
./centroid_crime.rb
```
Pobiera typ zbrodni i liczy centroide danego typu przestępstwa. Następnie wynik zapisuję w kolekcji.

## Wyświetla liczbę zbrodni każdego typu w wybranym miesiącu
```bash
./policz_w_miesiacu.rb
```
Pobiera rok i miesiąc od użytkownika a następnie wyświetla ilość zarejestrowanych przestępstw w wybranym czasie.

## Eksportuje dane z kolekcji crime_export do formatu geojson
```bash
./export_geojson.sh
```
 Utworzony zostaje plik crime.geojson
 
[Przykladowy GEOJSON](https://github.com/M111q/Projekt_zaliczenie_nosql/blob/master/data/crime.geojson)

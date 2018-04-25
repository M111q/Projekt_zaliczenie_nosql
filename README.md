# Projekt_zaliczenie_nosql

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
generowanie_json.sh
```

## import danych (wygenerowany json) do mongo:
```bash
./importowanie.sh
```

## utworzenie geo-indeksu 
```bash
./ustaw_baze.rb
```

## Pobiera typ zbrodni i liczy centroide danego typu zbrodni
```bash
./centroid_crime.rb
```
Następnie wynik zapisuję w kolekcji

## Wyświetla liczbę zbrodnia wybranym miesiącu
```bash
./policz_w_miesiacu.rb
```
Pobiera rok i miesiąc od użytkownika a następnie wyświetla ilość zarejestrowanych przestępstw w wybranym czasie

#! /bin/bash


mongoimport --drop -c crime_driver --file ../data/crime.json


echo "Zaimportowano do kolekcji 'crime_driver' plik: crime.json"
#! /bin/bash


mongoimport --drop -c crime --file ../data/crime.json


echo "Zaimportowano do kolekcji 'crime' plik: crime.json"
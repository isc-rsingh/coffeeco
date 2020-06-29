#!/bin/sh

for jsonfile in *.json ;
do
    curl -d "@$jsonfile" -H "Content-Type: application/json" -X POST "http://localhost:5273/api/coffeeco/catalog/catalogproduct"
done;

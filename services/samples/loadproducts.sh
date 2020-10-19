#!/bin/sh

IRISDB="http://localhost:52773"

for jsonfile in *.json ;
do
    curl -d "@$jsonfile" -H "Content-Type: application/json" -X POST $IRISDB"/api/coffeeco/catalog/catalogproduct"
done;

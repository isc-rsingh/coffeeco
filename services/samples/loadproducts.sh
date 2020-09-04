#!/bin/sh

SERVER="http://localhost:5273"

for jsonfile in *.json ;
do
    curl -d "@$jsonfile" -H "Content-Type: application/json" -X POST $SERVER"/api/coffeeco/catalog/catalogproduct"
done;

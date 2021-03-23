#!/bin/sh

# Reads JSON files representing bags of roasted coffee coming out of the roastery and uses a REST API to load the data into the sales catalog


IRISDB="http://localhost:52773"

for jsonfile in *.json ;
do
    curl -d "@$jsonfile" -H "Content-Type: application/json" -X POST $IRISDB"/api/coffeeco/catalog/catalogproduct"
done;

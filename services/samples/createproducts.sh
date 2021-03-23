#!/bin/sh

# Creates JSON files representing bags of roasted coffee coming out of the roastery and ready for import into the sales database, ICO.catalog, using loadproducts.sh

freshdate=$(date +"%Y-%m-%d")
staledate=$(date -d "-6 days" +"%Y-%m-%d")

cat >./product_brazil_dark.json <<EOL
{
    "product_code": "BRAZILDARK",
    "quantity": 40,
    "price": 13.99,
    "time_roasted": "${freshdate}T09:00:00",
    "roasting_notes": "Full bodied and low acidity. Thick, creamy, nutty and semi-sweet.",
    "img": "brazil_dark.jpg"
}
EOL

cat >./product_ethiopia_medium.json <<EOL
{
    "product_code": "ETHIOPIAMEDIUM",
    "quantity": 40,
    "price": 14.99,
    "time_roasted": "${freshdate}T06:00:00",
    "roasting_notes": "Sweet floral notes, followed by the potent citrus notes, perfectly married into bergamot.",
    "img": "ethiopia_medium.jpg"
}
EOL

cat >./product_guatemala_light.json <<EOL
{
    "product_code": "GUATEMALALIGHT",
    "quantity": 120,
    "price": 11.99,
    "time_roasted": "${freshdate}T09:00:00",
    "roasting_notes": "Full body and a rich chocolatey-cocoa flavor, and a toffee-like sweetness.",
    "img": "guatemala_light.jpg"
}
EOL

cat >./product_sumatra_dark.json <<EOL
{
    "product_code": "SUMATRADARK",
    "quantity": 80,
    "price": 12.99,
    "time_roasted": "${staledate}T09:00:00",
    "roasting_notes": "Smooth and chocolaty with a sweet edge and minimal earthiness.",
    "img": "sumatra_dark.jpg"
}
EOL

cat >./product_sumatra_light.json <<EOL
{
    "product_code": "SUMATRALIGHT",
    "quantity": 40,
    "price": 12.99,
    "time_roasted": "${staledate}T09:00:00",
    "roasting_notes": "This rich and juicy Sumatra carries sustained notes of cherry and citrus.",
    "img": "sumatra_light.jpg"
}
EOL

exit 0
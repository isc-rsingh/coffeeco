# IRIS Coffee Company: Inventory system

Set up database schemas.
Import JSON manifests into inventory database.

## Database design

### inventory

- vendor_id
- product_code
- quantity_kg
- date_arrival
- date_departure

### catalog

- product_code
- quantity_kg
- date_roasted

## Take JSON from a file, validate and store values in inventory database.

Example file:

```json
{
    "items": [
        {
            "vendor_id": "DKE",
            "vendor_product_code": "SUMA001",
            "quantity_kg": 22.3,
            "date_arrival": "20200406",
            "date_departure": "20200403"
        }
    ]
}
```

## REST interface for working with the data

Get a list of inventory items
GET http://localhost:52773/api/coffeeco/inventory/items

Add JSON capabilities to the tables (persistent classes)
extend JSON.Adaptor
add %JSONFIELDNAMEs to the properties

Get a single item by ID
GET http://localhost:52773/api/coffeeco/inventory/item/1

then when we write the POST REST API to get a single item, it's soooo easy. Just use %OpenId
POST http://localhost:52773/api/coffeeco/inventory/pick/1/2.4


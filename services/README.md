# Roastery and REST

Create REST services (Handler.cls) and JSON export capabilities to persistent classes

## Roasting shrinkage

According to [this post](https://coffee.stackexchange.com/questions/3352/how-much-weight-reduction-occurs-after-roasting-coffee-beans#:~:text=The%20roasting%20process%20leads%20to,20%25%20on%20dark%20roast%20profiles.), weight loss ranges from 15% for light roasts, to 20% for dark.

## JSON body for putting product in the catalog

```json
{
    "inventory_id": "232",
    "product_code": "dd",
    "time_roasted": "ISO time",
    "quantity_kg": 33.33,
    "roasting_notes": "dsfds"
}
```

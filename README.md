# InterSystems IRIS Full Stack QuickStart

This QuickStart is designed to run in the InterSystems Sandbox environment, so [follow the exercise online here](https://play.instruqt.com/embed/intersystems/tracks/iris-for-health?token=em_IEo0iBDc0fgagpas).

In it, you create the basic information management infrastructure for a small manufacturing company. In this case, the company will be roasting, packaging and selling delicious, freshly roasted coffee beans. Along the way, you’ll learn how the InterSystems IRIS data platform can serve as the backbone of your IT architecture.

The QuickStart is divided into three parts and introduces the processes that you, as a coffee manufacturer, follow to set up everything from inventorying raw coffee beans to selling them in an online portal.

## Part 1: Write SQL to create and populate databases.

IRIS Coffee Company has three major divisions in the company:
the warehouse stores the raw coffee bean inventory. Its data will be in the table ICO.inventory
the roastery roasts the beans, and doesn’t need to store data
the storefront, where the company sells the roasted coffee. Its data will be in the table ICO.catalog
Let's use the SQL client built into the InterSystems IRIS Terminal to create those two tables using SQL CREATE statements.

1. Run SQL in `./setup/create_dbs.sql`
2. Update `./setup/connection.config`
3. `pip install intersystems-irispython`
4. Run Python script `./setup/manifestimporter.py`

## Part 2: Build a RESTful API to handle business functions using ObjectScript.

1. `curl -X POST http://localhost:52773/api/coffeeco/inventory/getbeans/1/2.4 | jq`

Let’s do that now. In the services/samples directory, you’ll find 2 scripts:

`createproducts.sh`: Creates 5 sample coffee products ready for sale.The first 3 were roasted today, and the last 2 were roasted 6 days ago. This gives us some relatively stale inventory to discount in the store.

`loadproducts.sh`: Runs a curl command that iterates through every JSON file in the directory and uses the web service you just wrote to load the data into ICO.catalog.

1. cd ./services/samples
2. sh createproducts.sh
3. sh loadproducts.sh

## Part 3: Build an online storefront to sell your artisan coffee beans using the popular JavaScript framework, Vue.js.

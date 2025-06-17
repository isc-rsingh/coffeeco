# InterSystems IRIS Full Stack QuickStart

This QuickStart is designed to run in the InterSystems Sandbox environment, so [follow the exercise online here](https://play.instruqt.com/embed/intersystems/tracks/iris-for-health?token=em_IEo0iBDc0fgagpas).

In it, you create the basic information management infrastructure for a small manufacturing company. In this case, the company will be roasting, packaging and selling delicious, freshly roasted coffee beans. Along the way, you’ll learn how the InterSystems IRIS data platform can serve as the backbone of your IT architecture.

The QuickStart is divided into three parts and introduces the processes that you, as a coffee manufacturer, follow to set up everything from inventorying raw coffee beans to selling them in an online portal.

## Part 1: Create and Populate Databases with SQL

In this part, you will set up the databases needed for the IRIS Coffee Company, which has three main divisions:

- **Warehouse:** Stores raw coffee bean inventory in the `ICO.inventory` table.
- **Roastery:** Handles roasting but does not store data.
- **Storefront:** Sells roasted coffee, with data stored in the `ICO.catalog` table.

Follow these steps to create and populate the databases:

1. Open the SQL client in the InterSystems IRIS Terminal:
   - Confirm the namespace is set to `IRISAPP`. If not, run:
     ```properties
     znspace "IRISAPP"
     ```
   - Launch the SQL shell by entering:
     ```properties
     DO $SYSTEM.SQL.Shell()
     ```

2. Execute the SQL statements found in `./setup/create_dbs.sql` one at a time. This will create the `ICO.inventory` and `ICO.catalog` tables.

3. Update the `./setup/connection.config` file to point to your IRIS server.

4. Install the required Python package and run the data import script:
   ```sh
   pip install intersystems-irispython
   cd setup
   python manifestimporter.py
   ```
## Part 2: Build a RESTful API to handle business functions using ObjectScript.

1. Create a connection to your IRIS server, setting your code directory to services/cls
2. Move ObjectScript classes from cls_samples to cls/ICO and compile them
3. Roast some beans (virtually): `curl -X POST http://localhost:52773/api/coffeeco/inventory/getbeans/1/2.4 | jq`

Let’s put some roasted coffee into our sales catalog. In the services/samples directory, you’ll find 2 scripts:

- `createproducts.sh`: Creates 5 sample coffee products ready for sale.The first 3 were roasted today, and the last 2 were roasted 6 days ago. This gives us some relatively stale inventory to discount in the store.
- `loadproducts.sh`: Runs a curl command that iterates through every JSON file in the directory and uses the web service you just wrote to load the data into ICO.catalog.

1. cd ./services/samples
2. sh createproducts.sh
3. sh loadproducts.sh

## Part 3: Build an online storefront to sell your artisan coffee beans using the popular JavaScript framework, Vue.js.

Query for fresh products:
`curl http://localhost:52773/api/coffeeco/catalog/getproducts | jq`

Query for stale:
`curl http://localhost:52773/api/coffeeco/catalog/getproducts/0 | jq`

Try selling products:
`curl -X POST http://localhost:52773/api/coffeeco/catalog/sellproduct/1/2 | jq`


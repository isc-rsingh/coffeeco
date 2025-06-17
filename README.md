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
## Part 2: Build a RESTful API to handle business functions using ObjectScript

1. Connect to your IRIS server and set your code directory to `services/cls`.

2. Move the ObjectScript classes from the `cls_Sample` directory to `cls/ICO` and compile them to make them available in your namespace.

3. Open the InterSystems Management Portal and navigate to:
   `Administration` -> `Security` -> `Applications` -> `Web Applications`.

4. Create a new web application with the following settings:
   - **Name:** `/api/coffeeco`
   - **Namespace:** `IRISAPP`
   - **Dispatch Class:** `ICO.Handler`

5. Switch to the "Application Roles" tab next to "General". For demonstration purposes, select the `%All` role and click **Assign** to grant access.

6. Roast some beans (virtually):
   ```sh
   curl -X POST http://localhost:52773/api/coffeeco/inventory/getbeans/1/2.4 | jq
   ```
   You should see a JSON response confirming the operation. Additionally, verify that the `ICO.inventory` table has been updated: the row with `vendor_id` of `ETRADER` should now show `197.6` in the `quantity_kg` field.

Next, add roasted coffee products to the sales catalog. In the `services/samples` directory, you will find two scripts:

- `createproducts.sh`: Creates 5 sample coffee products ready for sale.The first 3 were roasted today, and the last 2 were roasted 6 days ago. This gives us some relatively stale inventory to discount in the store.
- `loadproducts.sh`: Runs a curl command that iterates through every JSON file in the directory and uses the web service you just wrote to load the data into ICO.catalog.

To run these scripts, execute the following commands in your terminal:
```sh
cd ./services/samples
sh createproducts.sh
sh loadproducts.sh
```

If you are using Windows PowerShell with Git Bash installed, run these commands instead:
```powershell
cd ./services/samples
./createproducts.sh
./loadproducts.sh
```

## Part 3: Build an online storefront to sell your artisan coffee beans using the popular JavaScript framework, Vue.js.

Query for fresh products:
`curl http://localhost:52773/api/coffeeco/catalog/getproducts | jq`

Query for stale:
`curl http://localhost:52773/api/coffeeco/catalog/getproducts/0 | jq`

Try selling products:
`curl -X POST http://localhost:52773/api/coffeeco/catalog/sellproduct/1/2 | jq`


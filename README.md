# InterSystems IRIS Full Stack QuickStart

This QuickStart is designed to run in the InterSystems Sandbox environment, so [follow the exercise online here](https://play.instruqt.com/embed/intersystems/tracks/iris-for-health?token=em_IEo0iBDc0fgagpas).

In it, you create the basic information management infrastructure for a small manufacturing company. In this case, the company will be roasting, packaging and selling delicious, freshly roasted coffee beans. Along the way, you’ll learn how the InterSystems IRIS data platform can serve as the backbone of your IT architecture.

The QuickStart is divided into three parts and introduces the processes that you, as a coffee manufacturer, follow to set up everything from inventorying raw coffee beans to selling them in an online portal.

## Prerequisites
- Visual Studio Code with the InterSystems ObjectScript extension installed
- Docker and Docker Desktop installed
- Node.js installed for the frontend

## Part 1: Set Up Database via Docker
1. Run the following command in your terminal or command prompt:
```sh
docker-compose up --build
```
> **Note:** If you are using a device with an ARM architecture (e.g., Apple M chips), for better compatibility and performance, update the Dockerfile:
> - Change the line `ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2025.1` to `ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2025.1`

2. After the image finishes downloading (this may take a few minutes depending on your internet speed), you should see output similar to:
```
 ✔ iris
 ✔ Container coffeeco-iris-1
Attaching to iris-1
iris-1  | [INFO] Executing command /home/irisowner/irissys/startISCAgent.sh 2188...
iris-1  | [INFO] Writing status to file: /home/irisowner/irissys/iscagent.status
iris-1  | Reading configuration from file: /home/irisowner/irissys/iscagent.conf
iris-1  | ISCAgent[18]: Starting
iris-1  | ISCAgent[22]: Starting ApplicationServer on *:2188
iris-1  | [INFO] ...executed command /home/irisowner/irissys/startISCAgent.sh 2188
iris-1  | [INFO] Starting InterSystems IRIS instance IRIS...
...
```

3. Connect to the InterSystems IRIS instance using the VSCode extension with these credentials:
- **Hostname**: `localhost`
- **Port**: `52773`
- **Username**: `_SYSTEM`
- **Password**: `SYS`

## Part 2: Create and Populate Databases with SQL

This part sets up the databases for the IRIS Coffee Company, which has three main divisions:

- **Warehouse:** Stores raw coffee bean inventory in the `ICO.inventory` table.
- **Roastery:** Handles roasting but does not store data.
- **Storefront:** Sells roasted coffee, with data stored in the `ICO.catalog` table.

Follow these steps:

1. Open the SQL client in the InterSystems IRIS Terminal:
   - Ensure the namespace is set to `IRISAPP`. If not, run:
     ```properties
     znspace "IRISAPP"
     ```
   - Launch the SQL shell by entering:
     ```properties
     DO $SYSTEM.SQL.Shell()
     ```

2. Execute the SQL statements in `./setup/create_dbs.sql` one at a time to create the `ICO.inventory` and `ICO.catalog` tables.

3. Update the `./setup/connection.config` file to point to your IRIS server.

4. Install the required Python package and run the data import script:
   ```sh
   pip install intersystems-irispython
   cd setup
   python manifestimporter.py
   ```

## Part 3: Build a RESTful API to Handle Business Functions Using ObjectScript

1. Connect to your IRIS server and set your code directory to `services/cls`.

2. Move the ObjectScript classes from the `cls_Sample` directory to `cls/ICO` and compile them by right-clicking on the file and selecting `Import and Compile`.

3. Open the InterSystems Management Portal and navigate to:
   `System Administration` -> `Security` -> `Applications` -> `Web Applications`.

4. Ensure you are in the `IRISAPP` namespace. Create a new web application with the following settings:
   - **Name:** `/api/coffeeco`
   - **Namespace:** `IRISAPP`
   - **Dispatch Class:** `ICO.Handler`

5. Switch to the "Application Roles" tab next to "General". For demonstration purposes, select the `%All` role and click **Assign** to grant access.

6. Roast some beans (virtually) by running:
   ```sh
   curl -X POST http://localhost:52773/api/coffeeco/inventory/getbeans/1/2.4 | jq
   ```
   You should see a JSON response confirming the operation. Verify that the `ICO.inventory` table has been updated: the row with `vendor_id` of `ETRADER` should now show `197.6` in the `quantity_kg` field.

Next, add roasted coffee products to the sales catalog. In the `services/samples` directory, you will find two scripts:

- `createproducts.sh`: Creates 5 sample coffee products ready for sale. The first 3 were roasted today, and the last 2 were roasted 6 days ago, providing some relatively stale inventory to discount in the store.
- `loadproducts.sh`: Runs a curl command that iterates through every JSON file in the directory and uses the web service you just wrote to load the data into `ICO.catalog`.

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

You can try the following curl commands to interact with the API endpoints:

- Query for fresh products:
  ```sh
  curl http://localhost:52773/api/coffeeco/catalog/getproducts | jq
  ```

- Query for stale products:
  ```sh
  curl http://localhost:52773/api/coffeeco/catalog/getproducts/0 | jq
  ```

- Try selling products:
  ```sh
  curl -X POST http://localhost:52773/api/coffeeco/catalog/sellproduct/1/2 | jq
  ```

## Part 4: Build an online storefront to sell your artisan coffee beans using the popular JavaScript framework, Vue.js.

In the final part of the tutorial, you will see the online storefront for your coffee operation.

This storefront is built using the Vue.js JavaScript framework to create a single-page application (SPA). While teaching Vue.js is beyond the scope of this tutorial, you will get a sense of how it was built and how the REST services you created in Part 3 are used by this app.

To start the development server, set your working directory to `frontend` and run:
```sh
npm install
npm run dev
```

You should see output similar to:
```
VITE v6.3.5  ready in 1080 ms

  ➜  Local:   http://localhost:5173/
```

Open your browser and navigate to `http://localhost:5173` or the port shown in the terminal output.

For more details, please see the description [here](/frontend/README.md).

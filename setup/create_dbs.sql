DROP TABLE ICO.inventory
DROP TABLE ICO.catalog

CREATE TABLE ICO.inventory
(
vendor_id VARCHAR(128), 
vendor_product_code VARCHAR(128), 
quantity_kg DECIMAL(10,2), 
date_arrival DATE
)

CREATE TABLE ICO.catalog
(
catalog_id BIGINT IDENTITY, 
product_code VARCHAR(128), 
quantity INTEGER, 
price DECIMAL(10,2), 
time_roasted DATETIME, 
roasting_notes VARCHAR(2048),
img VARCHAR(2048)
)

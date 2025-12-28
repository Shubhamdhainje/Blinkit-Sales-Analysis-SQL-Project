-- CREATE BLINKIT TABLE
DROP TABLE IF EXISTS blinkit;
CREATE TABLE blinkit(
	itemFatContent VARCHAR(50),
	itemIdentifier VARCHAR(50),
	itemType VARCHAR(50),
	outletEstablishYear INT,
	outletIdentifier VARCHAR(50),
	outletLocationType VARCHAR(50),
	outletSize VARCHAR(50),
	outletType VARCHAR(50),
	itemVisibility NUMERIC(10, 2),
	itemWeight NUMERIC(10, 2),
	totalSales NUMERIC(10, 2),
	rating NUMERIC(10, 2)
);

SELECT * FROM blinkit;

-- IMPORT DATA INTO BLINKIT TABLE
COPY blinkit(itemFatContent, itemIdentifier, itemType, outletEstablishYear, outletIdentifier, outletLocationType, 
			 outletSize, outletType, itemVisibility,itemWeight, totalSales, rating)
FROM 'F:\2023_Desktop\SQL_Project\Blinkit\BlinkIT Grocery Data.csv'
DELIMITER ','
CSV HEADER;

--- CLEANING DATA
UPDATE blinkit
SET itemFatContent =
	CASE
		WHEN itemFatContent IN ('LF', 'low fat') THEN 'Low Fat'
		WHEN itemFatContent = 'reg' THEN 'Regular'
		ELSE itemFatContent
	END 
	
SELECT DISTINCT itemFatContent FROM blinkit;	

-- BUSINESS REQUIREMENT
-- 1) THE OVERALL REVENUE GENERATED FROM ALL ITEMS SOLD
SELECT * FROM blinkit;

SELECT SUM(totalsales) AS total_sales 
FROM blinkit;

-- USING TO_CHAR FUNCTION
SELECT TO_CHAR(SUM(totalsales) / 100000 , 'FM99,999,99.00') || ' INR LAKH'
AS total_sales 
FROM blinkit;

-- USING CAST FUNCTION
SELECT CAST(SUM(totalsales) /100000 AS DECIMAL(10, 2)) || ' INR LAKH'
AS total_sales
FROM blinkit;

-- 2) THE AVERAGE REVENUE PER SALE.
SELECT AVG(totalsales) AS avg_revenue
FROM blinkit;

SELECT CAST(AVG(totalsales) AS DECIMAL(10, 2)) AS avg_revenue
FROM blinkit;
-- 3) THE TOTAL COUNT OF DIFFERENT ITEM SOLD.
SELECT COUNT(*) AS total_item_sold
FROM blinkit;

-- 4) THE AVERAGE CUSTOMER RATING FOR ITEMS SOLD.
SELECT CAST(AVG(rating) AS DECIMAL(10, 2)) AS avg_rating
FROM blinkit;

-- GRANULAR REQUIREMENT
-- 1) TOTAL SALES BY FAT CONTENT
-- 1) ANALYZE THE IMPACT OF FAT CONTENT ON TOATL SALES
SELECT itemfatcontent, 
	   CAST(SUM(totalsales) /100000  AS DECIMAL(10, 2)) || ' INR LAKH' 
	   AS total_sales
FROM blinkit
GROUP BY itemfatcontent;

-- 2) HOW OTHER (AVERAGE SALES, NUMBER OF ITEMS, AVAERAGE RATING) VARYING WITH FAT CONTENT iN 2022 YEAR.
SELECT itemfatcontent, 
	   CAST(SUM(totalsales) /1000  AS DECIMAL(10, 2)) || ' INR THOUSANDS' 
	   AS total_sales,
	   CAST(AVG(totalsales) AS DECIMAL(10, 2)) AS avg_total_sales,
	   COUNT(*) AS no_of_sales,
	   CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
FROM blinkit
WHERE outletestablishyear = 2022
GROUP BY itemfatcontent;

-- 2) TOTAL SALES BY ITEM TYPE
-- 1) THE PERFORMANCE OF DIFFERENT ITEM TYPES IN TERMS OF TOTAL SALES.
SELECT itemtype , 
	   CAST(SUM(totalsales) /1000 AS DECIMAL(10, 2)) || ' INR THOUSANDS' 
	   AS total_sales
FROM blinkit
GROUP BY itemtype;

-- 2) HOW OTHER (AVERAGE SALES, NUMBER OF ITEMS, AVAERAGE RATING) VARYING WITH ITEM TYPE TOP 5.
SELECT itemtype, 
	   CAST(SUM(totalsales) /1000  AS DECIMAL(10, 2)) || ' INR THOUSANDS' 
	   AS total_sales,
	   CAST(AVG(totalsales) AS DECIMAL(10, 2)) AS avg_total_sales,
	   COUNT(*) AS no_of_sales,
	   CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
FROM blinkit
WHERE outletestablishyear = 2020
GROUP BY itemtype
LIMIT 5;

SELECT * FROM blinkit;

-- 3) FAT CONTENT BY OUTLET FOR TOTAL SALES
-- 1) COMPARE TOTAL SALES ACROSS DIFFERENT OUTLETS SEGMENTED BY FAT CONTENT.
SELECT outletlocationtype, itemfatcontent,
	   CAST(SUM(totalsales) AS DECIMAL(10, 2)) 
	   AS total_sales
FROM blinkit
GROUP BY outletlocationtype, itemfatcontent
ORDER BY total_sales;

-- USING COALESCE FUNCTION
SELECT
    outletlocationtype,
    COALESCE(SUM(CASE WHEN itemfatcontent = 'Low Fat' THEN totalsales END), 0) AS Low_Fat,
    COALESCE(SUM(CASE WHEN itemfatcontent = 'Regular' THEN totalsales END), 0) AS Regular
FROM blinkit
GROUP BY outletlocationtype
ORDER BY outletlocationtype;


-- 2) HOW OTHER (AVERAGE SALES, NUMBER OF ITEMS, AVAERAGE RATING) VARYING WITH OUTLET LOCATION TYPE ORDER BY ASC.
SELECT
    outletlocationtype,
    COALESCE(SUM(CASE WHEN itemfatcontent = 'Low Fat' THEN totalsales END), 0) AS Low_Fat,
    COALESCE(SUM(CASE WHEN itemfatcontent = 'Regular' THEN totalsales END), 0) AS Regular,
	CAST(AVG(totalsales) AS DECIMAL(10, 2)) AS avg_total_sales,
	COUNT(*) AS no_of_sales,
	CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
FROM blinkit
GROUP BY outletlocationtype
ORDER BY outletlocationtype;

-- 4) TOTAL SALES BY OUTLET ESTABLISHMENT
-- 1) EVALUATE HOW THE AGE OR TYPE OF OUTLET ESTABLISHMENT INFLUENCES TOTAL SALES.
SELECT outletestablishyear,
	   CAST(SUM(totalsales) / 100000 AS DECIMAL(10, 2)) || ' INR LAKH'
	   AS total_sales
FROM blinkit
GROUP BY outletestablishyear
ORDER BY outletestablishyear;

-- 2) HOW OTHER (AVERAGE SALES, NUMBER OF ITEMS, AVAERAGE RATING) VARYING WITH OUTLET ESTABLISHMENT YEAR.
SELECT outletestablishyear, 
	   CAST(SUM(totalsales) /100000  AS DECIMAL(10, 2)) || ' INR LAKH' 
	   AS total_sales,
	   CAST(AVG(totalsales) AS DECIMAL(10, 2)) AS avg_total_sales,
	   COUNT(*) AS no_of_sales,
	   CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
FROM blinkit
GROUP BY outletestablishyear
ORDER BY total_sales; 

-- 5) PERCENTAGE OF SALES BY OUTLET SIZE
-- 1) ANALYZE THE CORRELATION BETWEEN OUTLET SIZE AND TOTAL SALES.
SELECT outletsize,
	   CAST(SUM(totalsales) AS DECIMAL(10, 2)) AS total_sales,
	   CAST(SUM(totalsales) * 100 / SUM(SUM(totalsales)) OVER() AS DECIMAL(10, 2)) || ' %'
	   AS sales_percentage
FROM blinkit
GROUP BY outletsize
ORDER BY total_sales DESC;

-- 6) SALES BY OUTLET LOCATION
-- 1) ACCESS THE GEOGRAPHIC DRISTRIBUTION OF SALES ACROSS DIFFERENT LOCATIONS IN 2022.
SELECT outletlocationtype, 
	   CAST(SUM(totalsales) /100000  AS DECIMAL(10, 2)) || ' INR LAKH' 
	   AS total_sales,
	   CAST(SUM(totalsales) * 100 / SUM(SUM(totalsales)) OVER() AS DECIMAL(10, 2)) || ' %'
	   AS sales_percentage,
	   CAST(AVG(totalsales) AS DECIMAL(10, 2)) AS avg_total_sales,
	   COUNT(*) AS no_of_sales,
	   CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
FROM blinkit
WHERE outletestablishyear = 2022
GROUP BY outletlocationtype
ORDER BY total_sales;


-- 7) ALL METRICS BY OUTLET TYPE
-- 1) VIEW OF ALL KEY METRICS ( TOTAL SALES, AVERAGE SALES, NUMBER OF ITEMS, AVERAGE RATING) BROKEN DOWN BY DIFFERNT OUTLET TYPES.
SELECT outlettype, 
	   CAST(SUM(totalsales) /100000  AS DECIMAL(10, 2)) || ' INR LAKH' 
	   AS total_sales,
	   CAST(SUM(totalsales) * 100 / SUM(SUM(totalsales)) OVER() AS DECIMAL(10, 2)) || ' %'
	   AS sales_percentage,
	   CAST(AVG(totalsales) AS DECIMAL(10, 2)) AS avg_total_sales,
	   COUNT(*) AS no_of_sales,
	   CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
FROM blinkit
GROUP BY outlettype
ORDER BY total_sales;
-- ZEPTO PROJECT ANALYST FOR BUSINESS INSIGHT

DROP TABLE IF EXISTS zepto;

CREATE Table zepto(
       Sku_id SERIAL PRIMARY KEY,
       Category VARCHAR(120),
	   name VARCHAR(150) NOT NULL, 
	   mrp NUMERIC(8,2), 
	   discountPercent NUMERIC(5,2),
	   availableQuantity INTEGER, 
	   discountedSellingPrice NUMERIC(8,2),
	   weightInGms INTEGER,
	   outOfStock BOOLEAN, 
	   quantity INTEGER
);

SELECT * FROM zepto;


-- Lets do data exploration

SELECT COUNT(*) FROM zepto;

-- Sample data

SELECT * FROM zepto
LIMIT 10;

-- check NULL Values

SELECT * FROM zepto
WHERE name IS NULL 
OR 
category IS NULL 
OR 
mrp IS NULL 
OR 
discountpercent IS NULL 
OR 
availablequantity IS NULL 
OR 
discountedsellingprice IS NULL 
OR 
weightingms IS NULL 
OR 
outofstock IS NULL 
OR 
Quantity IS NULL;

-- Check Different product category

SELECT DISTINCT category FROM zepto
ORDER BY category;

-- Check stock product or Instock product

SELECT outofstock, COUNT(sku_id) FROM zepto
GROUP BY outofstock;

-- Check product name present multiple times

SELECT name, COUNT(sku_id) as "Number of SKUs"
FROM zepto 
GROUP BY name
HAVING count(sku_id)>1
ORDER BY count(Sku_id) DESC;

-- Data cleaning

SELECT * FROM zepto
WHERE mrp = 0 OR discountedsellingprice = 0;

DELETE FROM zepto
WHERE mrp = 0;

-- Update paisa into rupees

UPDATE zepto
SET mrp = mrp/100,
discountedsellingprice = discountedsellingprice/100;
SELECT * FROM zepto

--data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.

SELECT DISTINCT name, mrp, discountpercent FROM zepto
ORDER BY discountpercent DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock

SELECT DISTINCT name,mrp,outofstock FROM zepto
WHERE outofstock = TRUE and mrp>300
ORDER by mrp DESC;

--Q3.Calculate Estimated Revenue for each category

SELECT category,
SUM(discountedsellingprice*availablequantity) AS total_revenue
FROM zepto
GROUP by category
ORDER BY total_revenue

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT DISTINCT mrp, discountpercent FROM zepto
WHERE mrp>500 and discountpercent < 10
ORDER BY mrp DESC, discountpercent DESC;


-- Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;


-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name, weightingms, discountedsellingprice,
ROUND(discountedsellingprice/weightingms) AS price_per_gram
FROM zepto
WHERE weightingms >= 100
ORDER BY price_per_gram DESC; 

--Q7.Group the products into categories like Low, Medium, Bulk based by weightingms.

SELECT DISTINCT name, weightingms,
CASE WHEN weightingms < 1000 THEN 'LOW'
     WHEN weightingms < 5000 THEN 'HIGH'
	 ELSE 'BULK'
     END AS weight_category

FROM zepto;	 

--Q8.What is the Total Inventory Weight Per Category 


SELECT category,
SUM(weightingms * availablequantity) AS Total_weight
FROM zepto
GROUP BY category
ORDER BY Total_weight;







	 
    








































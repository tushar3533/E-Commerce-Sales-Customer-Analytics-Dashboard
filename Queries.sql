-- ===========================================
-- E-Commerce Sales & Customer Analytics
-- SQL Business Analysis Queries
-- Author : Tushar Sathe
-- ===========================================

-------------------------------------------------
-- BASIC ANALYSIS
-------------------------------------------------

-- 1. Total Sales
SELECT SUM(sales_per_order) AS Total_Sales
FROM ecommerce_data;

-- 2. Total Profit
SELECT SUM(profit_per_order) AS Total_Profit
FROM ecommerce_data;

-- 3. Total Orders
SELECT COUNT(order_id) AS Total_Orders
FROM ecommerce_data;

-- 4. Total Customers
SELECT COUNT(DISTINCT customer_id) AS Total_Customers
FROM ecommerce_data;

-- 5. Average Order Value
SELECT AVG(sales_per_order) AS Average_Order_Value
FROM ecommerce_data;

-------------------------------------------------
-- PRODUCT ANALYSIS
-------------------------------------------------

-- 6. Top 10 Products by Sales
SELECT product_name,
SUM(sales_per_order) AS Total_Sales
FROM ecommerce_data
GROUP BY product_name
ORDER BY Total_Sales DESC
LIMIT 10;

-- 7. Top 10 Products by Profit
SELECT product_name,
SUM(profit_per_order) AS Total_Profit
FROM ecommerce_data
GROUP BY product_name
ORDER BY Total_Profit DESC
LIMIT 10;

-- 8. Bottom 10 Products by Profit
SELECT product_name,
SUM(profit_per_order) AS Total_Profit
FROM ecommerce_data
GROUP BY product_name
ORDER BY Total_Profit ASC
LIMIT 10;

-------------------------------------------------
-- CATEGORY ANALYSIS
-------------------------------------------------

-- 9. Sales by Category
SELECT category_name,
SUM(sales_per_order) AS Sales
FROM ecommerce_data
GROUP BY category_name
ORDER BY Sales DESC;

-- 10. Profit by Category
SELECT category_name,
SUM(profit_per_order) AS Profit
FROM ecommerce_data
GROUP BY category_name
ORDER BY Profit DESC;

-------------------------------------------------
-- CUSTOMER ANALYSIS
-------------------------------------------------

-- 11. Sales by Customer Segment
SELECT customer_segment,
SUM(sales_per_order) AS Sales
FROM ecommerce_data
GROUP BY customer_segment;

-- 12. Profit by Customer Segment
SELECT customer_segment,
SUM(profit_per_order) AS Profit
FROM ecommerce_data
GROUP BY customer_segment;

-- 13. Top 10 Customers by Revenue
SELECT customer_name,
SUM(sales_per_order) AS Revenue
FROM ecommerce_data
GROUP BY customer_name
ORDER BY Revenue DESC
LIMIT 10;

-------------------------------------------------
-- REGION ANALYSIS
-------------------------------------------------

-- 14. Sales by Region
SELECT customer_region,
SUM(sales_per_order) AS Sales
FROM ecommerce_data
GROUP BY customer_region;

-- 15. Profit by Region
SELECT customer_region,
SUM(profit_per_order) AS Profit
FROM ecommerce_data
GROUP BY customer_region
ORDER BY Profit DESC;

-- 16. Sales by State
SELECT customer_state,
SUM(sales_per_order) AS Sales
FROM ecommerce_data
GROUP BY customer_state
ORDER BY Sales DESC;

-------------------------------------------------
-- SHIPPING ANALYSIS
-------------------------------------------------

-- 17. Orders by Shipping Type
SELECT shipping_type,
COUNT(*) AS Orders
FROM ecommerce_data
GROUP BY shipping_type;

-- 18. Sales by Shipping Type
SELECT shipping_type,
SUM(sales_per_order) AS Sales
FROM ecommerce_data
GROUP BY shipping_type;

-------------------------------------------------
-- DELIVERY ANALYSIS
-------------------------------------------------

-- 19. Delivery Status Distribution
SELECT delivery_status,
COUNT(*) AS Orders
FROM ecommerce_data
GROUP BY delivery_status;

-- 20. Profit by Delivery Status
SELECT delivery_status,
SUM(profit_per_order) AS Profit
FROM ecommerce_data
GROUP BY delivery_status;

-------------------------------------------------
-- TIME ANALYSIS
-------------------------------------------------

-- 21. Monthly Sales Trend
SELECT MONTH(order_date) AS Month,
SUM(sales_per_order) AS Sales
FROM ecommerce_data
GROUP BY Month
ORDER BY Month;

-- 22. Monthly Profit Trend
SELECT MONTH(order_date) AS Month,
SUM(profit_per_order) AS Profit
FROM ecommerce_data
GROUP BY Month
ORDER BY Month;

-------------------------------------------------
-- DISCOUNT ANALYSIS
-------------------------------------------------

-- 23. Average Discount
SELECT AVG(order_item_discount) AS Avg_Discount
FROM ecommerce_data;

-- 24. Discount by Category
SELECT category_name,
AVG(order_item_discount) AS Avg_Discount
FROM ecommerce_data
GROUP BY category_name;

-------------------------------------------------
-- QUANTITY ANALYSIS
-------------------------------------------------

-- 25. Quantity Sold by Product
SELECT product_name,
SUM(order_quantity) AS Quantity
FROM ecommerce_data
GROUP BY product_name
ORDER BY Quantity DESC;

-------------------------------------------------
-- ADVANCED BUSINESS QUERIES
-------------------------------------------------

-- 26. Most Profitable Category
SELECT category_name,
SUM(profit_per_order) Profit
FROM ecommerce_data
GROUP BY category_name
ORDER BY Profit DESC
LIMIT 1;

-- 27. Highest Revenue Region
SELECT customer_region,
SUM(sales_per_order) Revenue
FROM ecommerce_data
GROUP BY customer_region
ORDER BY Revenue DESC
LIMIT 1;

-- 28. Highest Revenue Customer Segment
SELECT customer_segment,
SUM(sales_per_order) Revenue
FROM ecommerce_data
GROUP BY customer_segment
ORDER BY Revenue DESC;

-- 29. Highest Average Order Value by Segment
SELECT customer_segment,
AVG(sales_per_order) Avg_Order_Value
FROM ecommerce_data
GROUP BY customer_segment;

-- 30. Total Profit Margin
SELECT
ROUND(
SUM(profit_per_order)*100/
SUM(sales_per_order),2)
AS Profit_Margin;

-------------------------------------------------
-- WINDOW FUNCTIONS
-------------------------------------------------

-- 31. Rank Products by Sales
SELECT
product_name,
SUM(sales_per_order) Sales,
RANK() OVER(
ORDER BY SUM(sales_per_order) DESC
) Sales_Rank
FROM ecommerce_data
GROUP BY product_name;

-- 32. Dense Rank Categories
SELECT
category_name,
SUM(sales_per_order) Sales,
DENSE_RANK() OVER(
ORDER BY SUM(sales_per_order) DESC
) Ranking
FROM ecommerce_data
GROUP BY category_name;

-------------------------------------------------
-- CASE STATEMENTS
-------------------------------------------------

-- 33. Profit Status
SELECT
product_name,
profit_per_order,
CASE
WHEN profit_per_order>100 THEN 'High Profit'
WHEN profit_per_order>50 THEN 'Medium Profit'
ELSE 'Low Profit'
END Profit_Status
FROM ecommerce_data;

-------------------------------------------------
-- HAVING CLAUSE
-------------------------------------------------

-- 34. Products Selling More than 5000
SELECT product_name,
SUM(sales_per_order) Sales
FROM ecommerce_data
GROUP BY product_name
HAVING Sales>5000;

-------------------------------------------------
-- SUBQUERY
-------------------------------------------------

-- 35. Customers Above Average Sales
SELECT customer_name,
SUM(sales_per_order) Sales
FROM ecommerce_data
GROUP BY customer_name
HAVING Sales>(
SELECT AVG(sales_per_order)
FROM ecommerce_data);

-------------------------------------------------
-- CTE
-------------------------------------------------

-- 36. Top Categories
WITH CategorySales AS
(
SELECT
category_name,
SUM(sales_per_order) Sales
FROM ecommerce_data
GROUP BY category_name
)

SELECT *
FROM CategorySales
ORDER BY Sales DESC;


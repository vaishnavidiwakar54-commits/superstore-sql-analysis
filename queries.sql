-- Superstore Sales Analysis (SQLite)

-- Q1: Total orders and total sales
SELECT COUNT(DISTINCT "Order ID") AS total_orders,
       ROUND(SUM(Sales), 2) AS total_sales
FROM raw_superstore;
-- Insight: The store handled 4,922 orders worth about 2.26 million in sales.

-- Q2: Top 10 highest sales
SELECT "Order ID", "Customer Name", Sales
FROM raw_superstore
ORDER BY Sales DESC
LIMIT 10;
-- Insight:

-- Q3: All orders from the West region
SELECT "Order ID", "Customer Name", State, Sales
FROM raw_superstore
WHERE Region = 'West';
-- Insight:

-- Q4: Sales by category
SELECT Category,
       ROUND(SUM(Sales), 2) AS total_sales,
       COUNT(DISTINCT "Order ID") AS total_orders
FROM raw_superstore
GROUP BY Category
ORDER BY total_sales DESC;
-- Insight:

-- Q5: Top 10 customers
SELECT "Customer Name", ROUND(SUM(Sales), 2) AS total_spent
FROM raw_superstore
GROUP BY "Customer Name"
ORDER BY total_spent DESC
LIMIT 10;
-- Insight:

-- Q6: Sub-categories with low total sales
SELECT "Sub-Category", ROUND(SUM(Sales), 2) AS total_sales
FROM raw_superstore
GROUP BY "Sub-Category"
HAVING SUM(Sales) < 100000
ORDER BY total_sales;
-- Insight:

-- Q7: Sales by year
SELECT substr("Order Date", -4) AS year,
       ROUND(SUM(Sales), 2) AS total_sales
FROM raw_superstore
GROUP BY year
ORDER BY year;
-- Insight:

-- Q8: Customer segments (High / Medium / Low)
SELECT "Customer Name",
       ROUND(SUM(Sales), 2) AS total_spent,
       CASE
         WHEN SUM(Sales) > 5000 THEN 'High'
         WHEN SUM(Sales) > 2000 THEN 'Medium'
         ELSE 'Low'
       END AS customer_value
FROM raw_superstore
GROUP BY "Customer Name"
ORDER BY total_spent DESC;
-- Insight:

-- Q9: Orders above the average sale (subquery)
SELECT "Order ID", "Customer Name", Sales
FROM raw_superstore
WHERE Sales > (SELECT AVG(Sales) FROM raw_superstore)
ORDER BY Sales DESC;
-- Insight:

-- Q10: JOIN customers table with sales
CREATE TABLE customers AS
SELECT DISTINCT "Customer ID", "Customer Name", Segment
FROM raw_superstore;

SELECT c.Segment, ROUND(SUM(r.Sales), 2) AS total_sales
FROM raw_superstore r
JOIN customers c ON r."Customer ID" = c."Customer ID"
GROUP BY c.Segment;
-- Insight:The highest single sale was [100000] by [vaishnavi]
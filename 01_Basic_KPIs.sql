-- Olist E-Commerce SQL Portfolio
-- 01_Basic_KPIs.sql
-- Database: Olist_Ecommerce
-- SQL Server

-- 1. List available base tables
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;


-- 2. Total orders and unique customers
SELECT
    COUNT(*) AS Total_Orders,
    COUNT(DISTINCT customer_id) AS Unique_Customers
FROM dbo.Orders;


-- 3. Total sales and true Average Order Value (AOV)
-- Order value is calculated first at order level.
WITH OrderTotals AS
(
    SELECT
        order_id,
        SUM(price + freight_value) AS Order_Total
    FROM dbo.items
    GROUP BY order_id
)
SELECT
    SUM(Order_Total) AS Total_Sales,
    AVG(Order_Total) AS Average_Order_Value
FROM OrderTotals;


-- 4. Unique products
SELECT
    COUNT(DISTINCT product_id) AS Unique_Products
FROM dbo.items;

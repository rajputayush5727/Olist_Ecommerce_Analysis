-- Olist E-Commerce SQL Portfolio
-- 03_Advanced_SQL.sql
-- Database: Olist_Ecommerce
-- SQL Server

-- 1. Rank product categories by revenue using a CTE + RANK()
WITH ProductCategoryRevenue AS
(
    SELECT
        p.product_category_name,
        SUM(i.price + i.freight_value) AS Total_Revenue
    FROM dbo.items AS i
    JOIN dbo.products AS p
        ON i.product_id = p.product_id
    GROUP BY p.product_category_name
)
SELECT
    product_category_name,
    Total_Revenue,
    RANK() OVER (ORDER BY Total_Revenue DESC) AS Revenue_Rank
FROM ProductCategoryRevenue
ORDER BY Revenue_Rank;


-- 2. Find orders above the average order value
-- First calculate total value for each order,
-- then compare each order with the average order value.
WITH OrderTotals AS
(
    SELECT
        order_id,
        SUM(price + freight_value) AS Order_Total
    FROM dbo.items
    GROUP BY order_id
)
SELECT
    order_id,
    Order_Total
FROM OrderTotals
WHERE Order_Total > (
    SELECT AVG(Order_Total)
    FROM OrderTotals
)
ORDER BY Order_Total DESC;

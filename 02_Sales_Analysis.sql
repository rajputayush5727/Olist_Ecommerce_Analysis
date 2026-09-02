-- Olist E-Commerce SQL Portfolio
-- 02_Sales_Analysis.sql
-- Database: Olist_Ecommerce
-- SQL Server

-- 1. Top 10 product categories by revenue
SELECT TOP 10
    p.product_category_name,
    SUM(i.price + i.freight_value) AS Total_Revenue
FROM dbo.items AS i
JOIN dbo.products AS p
    ON i.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY Total_Revenue DESC;


-- 2. Monthly revenue trend
SELECT
    YEAR(o.order_purchase_timestamp) AS Year,
    MONTH(o.order_purchase_timestamp) AS Month,
    SUM(i.price + i.freight_value) AS Total_Revenue
FROM dbo.Orders AS o
JOIN dbo.items AS i
    ON o.order_id = i.order_id
GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp)
ORDER BY
    Year,
    Month;


-- 3. Yearly revenue
SELECT
    YEAR(o.order_purchase_timestamp) AS Year,
    SUM(i.price + i.freight_value) AS Total_Revenue
FROM dbo.Orders AS o
JOIN dbo.items AS i
    ON o.order_id = i.order_id
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY Year DESC;


-- 4. Order status distribution
SELECT
    order_status,
    COUNT(*) AS Total_Orders,
    CAST(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS Order_Percentage
FROM dbo.Orders
GROUP BY order_status
ORDER BY Total_Orders DESC;


-- 5. Top 10 customers by spending
SELECT TOP 10
    o.customer_id,
    SUM(i.price + i.freight_value) AS Total_Spending
FROM dbo.Orders AS o
JOIN dbo.items AS i
    ON o.order_id = i.order_id
GROUP BY o.customer_id
ORDER BY Total_Spending DESC;


-- 6. Top 10 categories by items sold
SELECT TOP 10
    p.product_category_name,
    COUNT(DISTINCT i.order_item_id) AS Items_Sold
FROM dbo.items AS i
JOIN dbo.products AS p
    ON i.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY Items_Sold DESC;


-- 7. Average delivery time for delivered orders
SELECT
    AVG(
        DATEDIFF(
            DAY,
            order_purchase_timestamp,
            order_delivered_customer_date
        )
    ) AS Average_Delivery_Time_Days
FROM dbo.Orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;


-- 8. Review score distribution
SELECT
    review_score,
    COUNT(*) AS Review_Count
FROM dbo.reviews
GROUP BY review_score
ORDER BY review_score DESC;

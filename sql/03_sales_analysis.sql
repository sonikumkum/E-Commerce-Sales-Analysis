USE ecommerce_analysis;

-- ==========================================
-- 1. OVERALL SALES PERFORMANCE
-- ==========================================

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(units) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM ecommerce_sales;


-- ==========================================
-- 2. MONTHLY REVENUE TREND
-- ==========================================

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(units) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;


-- ==========================================
-- 3. TOP REVENUE MONTH
-- ==========================================

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY revenue DESC
LIMIT 1;


-- ==========================================
-- 4. PRODUCT PERFORMANCE
-- ==========================================

SELECT
    product,
    category,
    SUM(units) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY product, category
ORDER BY revenue DESC;


-- ==========================================
-- 5. TOP 5 PRODUCTS
-- ==========================================

SELECT
    product,
    SUM(units) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY product
ORDER BY revenue DESC
LIMIT 5;


-- ==========================================
-- 6. CATEGORY PERFORMANCE
-- ==========================================

SELECT
    category,
    COUNT(DISTINCT order_id) AS orders,
    SUM(units) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY category
ORDER BY revenue DESC;


-- ==========================================
-- 7. CITY-WISE SALES
-- ==========================================

SELECT
    customer_city,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers,
    SUM(units) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY customer_city
ORDER BY revenue DESC;


-- ==========================================
-- 8. TOP 3 CUSTOMER CITIES
-- ==========================================

SELECT
    customer_city,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY customer_city
ORDER BY revenue DESC
LIMIT 3;


-- ==========================================
-- 9. PAYMENT MODE ANALYSIS
-- ==========================================

SELECT
    payment_mode,
    COUNT(DISTINCT order_id) AS orders,
    SUM(units) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY payment_mode
ORDER BY revenue DESC;


-- ==========================================
-- 10. CUSTOMER SEGMENT ANALYSIS
-- ==========================================

SELECT
    customer_segment,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS orders,
    SUM(units) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY customer_segment
ORDER BY revenue DESC;


-- ==========================================
-- 11. PREMIUM PRODUCT ANALYSIS
-- ==========================================

SELECT
    product,
    COUNT(DISTINCT order_id) AS orders,
    SUM(units) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(
        SUM(units) / COUNT(DISTINCT order_id),
        2
    ) AS avg_units_per_order
FROM ecommerce_sales
WHERE product = 'Premium Laptop'
GROUP BY product;


-- ==========================================
-- 12. CITY + PRODUCT ANALYSIS
-- ==========================================

SELECT
    customer_city,
    product,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY customer_city, product
ORDER BY revenue DESC;


-- ==========================================
-- 13. MONTHLY CATEGORY PERFORMANCE
-- ==========================================

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    category,
    ROUND(SUM(revenue), 2) AS revenue
FROM ecommerce_sales
GROUP BY
    DATE_FORMAT(order_date, '%Y-%m'),
    category
ORDER BY month, revenue DESC;


-- ==========================================
-- 14. REVENUE CONTRIBUTION BY CATEGORY
-- ==========================================

SELECT
    category,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(
        SUM(revenue) * 100 /
        (SELECT SUM(revenue)
         FROM ecommerce_sales),
        2
    ) AS revenue_percentage
FROM ecommerce_sales
GROUP BY category
ORDER BY revenue DESC;


-- ==========================================
-- 15. REPEAT CUSTOMER ANALYSIS
-- ==========================================

SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM ecommerce_sales
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) > 1
ORDER BY total_revenue DESC;
USE ecommerce_analysis;

-- ==========================================
-- 1. CHECK TOTAL RECORDS
-- ==========================================

SELECT COUNT(*) AS total_records
FROM ecommerce_sales;


-- ==========================================
-- 2. CHECK DUPLICATE ORDER IDs
-- ==========================================

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM ecommerce_sales
GROUP BY order_id
HAVING COUNT(*) > 1;


-- ==========================================
-- 3. CHECK NULL VALUES
-- ==========================================

SELECT
    SUM(order_id IS NULL) AS null_order_id,
    SUM(order_date IS NULL) AS null_order_date,
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(customer_city IS NULL) AS null_city,
    SUM(category IS NULL) AS null_category,
    SUM(product IS NULL) AS null_product,
    SUM(units IS NULL) AS null_units,
    SUM(unit_price IS NULL) AS null_unit_price,
    SUM(revenue IS NULL) AS null_revenue,
    SUM(payment_mode IS NULL) AS null_payment_mode,
    SUM(customer_segment IS NULL) AS null_customer_segment
FROM ecommerce_sales;


-- ==========================================
-- 4. CHECK INVALID QUANTITIES
-- ==========================================

SELECT *
FROM ecommerce_sales
WHERE units <= 0;


-- ==========================================
-- 5. CHECK INVALID PRICES
-- ==========================================

SELECT *
FROM ecommerce_sales
WHERE unit_price <= 0;


-- ==========================================
-- 6. CHECK INVALID REVENUE
-- ==========================================

SELECT *
FROM ecommerce_sales
WHERE revenue <= 0;


-- ==========================================
-- 7. VERIFY REVENUE CALCULATION
-- ==========================================

SELECT
    order_id,
    units,
    unit_price,
    revenue
FROM ecommerce_sales
WHERE revenue <> (units * unit_price)
LIMIT 20;


-- ==========================================
-- 8. CHECK DATE RANGE
-- ==========================================

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM ecommerce_sales;


-- ==========================================
-- 9. CHECK AVAILABLE CITIES
-- ==========================================

SELECT DISTINCT customer_city
FROM ecommerce_sales
ORDER BY customer_city;


-- ==========================================
-- 10. CHECK AVAILABLE CATEGORIES
-- ==========================================

SELECT DISTINCT category
FROM ecommerce_sales
ORDER BY category;


-- ==========================================
-- 11. CHECK PAYMENT MODES
-- ==========================================

SELECT DISTINCT payment_mode
FROM ecommerce_sales
ORDER BY payment_mode;


-- ==========================================
-- 12. CHECK CUSTOMER SEGMENTS
-- ==========================================

SELECT DISTINCT customer_segment
FROM ecommerce_sales
ORDER BY customer_segment;
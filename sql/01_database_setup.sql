-- ==========================================
-- E-COMMERCE SALES ANALYSIS
-- DATABASE SETUP
-- ==========================================

CREATE DATABASE IF NOT EXISTS ecommerce_analysis;

USE ecommerce_analysis;

-- Remove old table if it already exists
DROP TABLE IF EXISTS ecommerce_sales;

-- Create sales table
CREATE TABLE ecommerce_sales (

    order_id VARCHAR(20) PRIMARY KEY,

    order_date DATE,

    customer_id VARCHAR(20),

    customer_city VARCHAR(50),

    category VARCHAR(50),

    product VARCHAR(100),

    units INT,

    unit_price DECIMAL(12,2),

    revenue DECIMAL(14,2),

    payment_mode VARCHAR(30),

    customer_segment VARCHAR(20)

);

-- Check table structure
DESCRIBE ecommerce_sales;
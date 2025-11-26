-- View 1: Daily revenue by product
CREATE OR REPLACE VIEW retail_fact.vw_daily_revenue_by_product AS
SELECT
    f.order_date,
    p.product_name,
    SUM(f.total_revenue_usd) AS total_revenue_usd,
    SUM(f.total_quantity) AS total_units_sold
FROM retail_fact.fact_orders_daily f
JOIN retail_dim.dim_product p
    ON f.product_id = p.product_id
GROUP BY f.order_date, p.product_name;

-- View 2: Region performance
CREATE OR REPLACE VIEW retail_fact.vw_region_performance AS
SELECT
    f.order_date,
    r.region_code,
    SUM(f.total_revenue_usd) AS total_revenue_usd,
    SUM(f.total_quantity) AS total_units_sold,
    SUM(f.unique_customers) AS total_unique_customers
FROM retail_fact.fact_orders_daily f
JOIN retail_dim.dim_region r
    ON f.region_id = r.region_id
GROUP BY f.order_date, r.region_code;

-- View 3: Top products by revenue
CREATE OR REPLACE VIEW retail_fact.vw_top_products_by_revenue AS
SELECT
    p.product_name,
    SUM(f.total_revenue_usd) AS total_revenue_usd
FROM retail_fact.fact_orders_daily f
JOIN retail_dim.dim_product p
    ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue_usd DESC;

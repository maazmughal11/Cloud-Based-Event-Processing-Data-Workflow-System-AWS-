CREATE SCHEMA IF NOT EXISTS retail_dim;
CREATE SCHEMA IF NOT EXISTS retail_fact;

CREATE TABLE IF NOT EXISTS retail_dim.dim_product (
    product_id      INTEGER PRIMARY KEY,
    product_name    VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS retail_dim.dim_region (
    region_id       INTEGER IDENTITY(1,1) PRIMARY KEY,
    region_code     VARCHAR(10) UNIQUE
);

CREATE TABLE IF NOT EXISTS retail_fact.fact_orders_daily (
    order_date          DATE,
    product_id          INTEGER REFERENCES retail_dim.dim_product(product_id),
    region_id           INTEGER REFERENCES retail_dim.dim_region(region_id),
    total_quantity      INTEGER,
    total_revenue_usd   DECIMAL(18,2),
    avg_order_value_usd DECIMAL(18,2),
    unique_customers    INTEGER
);

-- Staging table for loading from S3 silver layer
CREATE TABLE IF NOT EXISTS retail_fact.stage_orders_silver (
    order_date          DATE,
    product_id          INTEGER,
    product_name        VARCHAR(255),
    region              VARCHAR(10),
    total_amount_usd    DECIMAL(18,2),
    quantity            INTEGER,
    customer_id         INTEGER
);

-- COPY from S3 silver path (replace placeholders)
COPY retail_fact.stage_orders_silver
FROM 's3://retail-pipeline-silver/'
IAM_ROLE 'arn:aws:iam::YOUR_ACCOUNT_ID:role/RedshiftCopyRole'
FORMAT AS PARQUET;

-- Upsert into dimensions and fact table

-- Upsert products
INSERT INTO retail_dim.dim_product (product_id, product_name)
SELECT DISTINCT product_id, product_name
FROM retail_fact.stage_orders_silver s
WHERE NOT EXISTS (
    SELECT 1 FROM retail_dim.dim_product p
    WHERE p.product_id = s.product_id
);

-- Upsert regions
INSERT INTO retail_dim.dim_region (region_code)
SELECT DISTINCT region
FROM retail_fact.stage_orders_silver s
WHERE NOT EXISTS (
    SELECT 1 FROM retail_dim.dim_region r
    WHERE r.region_code = s.region
);

-- Insert into fact table
INSERT INTO retail_fact.fact_orders_daily (
    order_date,
    product_id,
    region_id,
    total_quantity,
    total_revenue_usd,
    avg_order_value_usd,
    unique_customers
)
SELECT
    s.order_date,
    s.product_id,
    r.region_id,
    SUM(s.quantity) AS total_quantity,
    SUM(s.total_amount_usd) AS total_revenue_usd,
    AVG(s.total_amount_usd) AS avg_order_value_usd,
    COUNT(DISTINCT s.customer_id) AS unique_customers
FROM retail_fact.stage_orders_silver s
JOIN retail_dim.dim_region r
    ON r.region_code = s.region
GROUP BY s.order_date, s.product_id, r.region_id;

-- Optional: clear staging table
TRUNCATE TABLE retail_fact.stage_orders_silver;

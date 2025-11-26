from pyspark.sql import SparkSession
from etl.transformations.enrich_orders import enrich_orders

spark = SparkSession.builder.master("local[1]").appName("test").getOrCreate()

def test_enrich_orders_adds_total_amount():
    input_data = [
        (1, 10.0, 2, "2025-01-01T10:00:00"),
    ]
    df = spark.createDataFrame(
        input_data,
        ["order_id", "price_usd", "quantity", "order_ts_utc"],
    )
    result = enrich_orders(df).collect()[0]
    assert float(result["total_amount_usd"]) == 20.0

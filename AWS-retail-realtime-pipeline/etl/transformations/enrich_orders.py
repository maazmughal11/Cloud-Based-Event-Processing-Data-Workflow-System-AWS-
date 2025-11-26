from pyspark.sql import DataFrame
from pyspark.sql.functions import col, round as spark_round, to_timestamp

def enrich_orders(df: DataFrame) -> DataFrame:
    return (
        df.withColumn("order_ts", to_timestamp("order_ts_utc"))
          .withColumn("total_amount_usd",
                      spark_round(col("price_usd") * col("quantity"), 2))
          .withColumn("order_date", col("order_ts").cast("date"))
    )

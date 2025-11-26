import sys
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from pyspark.sql.functions import sum as spark_sum, avg, countDistinct

args = getResolvedOptions(sys.argv, ["JOB_NAME", "SILVER_PATH", "GOLD_PATH"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

silver_path = args["SILVER_PATH"]
gold_path = args["GOLD_PATH"]

df = spark.read.parquet(silver_path)

fact_daily = (
    df.groupBy("order_date", "region", "product_id", "product_name")
      .agg(
          spark_sum("quantity").alias("total_quantity"),
          spark_sum("total_amount_usd").alias("total_revenue_usd"),
          avg("total_amount_usd").alias("avg_order_value_usd"),
          countDistinct("customer_id").alias("unique_customers"),
      )
)

(
    fact_daily
    .repartition("order_date", "region")
    .write
    .mode("overwrite")
    .partitionBy("order_date", "region")
    .parquet(gold_path)
)

job.commit()

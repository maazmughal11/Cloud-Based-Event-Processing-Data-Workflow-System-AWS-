import sys
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from transformations.enrich_orders import enrich_orders

args = getResolvedOptions(sys.argv, ["JOB_NAME", "BRONZE_PATH", "SILVER_PATH"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

bronze_path = args["BRONZE_PATH"]
silver_path = args["SILVER_PATH"]

df_raw = spark.read.json(bronze_path)
df_silver = enrich_orders(df_raw)

(
    df_silver
    .repartition("order_date", "region")
    .write
    .mode("overwrite")
    .partitionBy("order_date", "region")
    .parquet(silver_path)
)

job.commit()

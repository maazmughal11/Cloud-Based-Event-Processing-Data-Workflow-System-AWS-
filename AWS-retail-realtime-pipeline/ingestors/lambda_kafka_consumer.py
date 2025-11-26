import json
import os
import uuid
from datetime import datetime
import boto3

s3 = boto3.client("s3")
BRONZE_BUCKET = os.environ.get("BRONZE_BUCKET", "retail-bronze-bucket")

def lambda_handler(event, context):
    # event shape depends on MSK trigger; this is a simplified example
    for record in event["records"]["orders-0"]:
        payload = json.loads(record["value"])
        order_date = payload["order_ts_utc"].split("T")[0]
        key = f"dt={order_date}/order_{uuid.uuid4()}.json"
        s3.put_object(
            Bucket=BRONZE_BUCKET,
            Key=key,
            Body=json.dumps(payload),
        )
    return {"statusCode": 200, "body": "ok"}

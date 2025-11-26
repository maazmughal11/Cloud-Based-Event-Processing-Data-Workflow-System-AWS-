import json
import random
import time
from datetime import datetime
from kafka import KafkaProducer

producer = KafkaProducer(
    bootstrap_servers="localhost:9092",
    value_serializer=lambda v: json.dumps(v).encode("utf-8"),
)

PRODUCTS = [
    {"product_id": 1, "name": "Laptop"},
    {"product_id": 2, "name": "Headphones"},
    {"product_id": 3, "name": "Smartwatch"},
    {"product_id": 4, "name": "Phone"},
]

REGIONS = ["US", "EU", "APAC"]

def generate_event():
    product = random.choice(PRODUCTS)
    return {
        "order_id": random.randint(10_000, 99_999),
        "customer_id": random.randint(1_000, 9_999),
        "product_id": product["product_id"],
        "product_name": product["name"],
        "quantity": random.randint(1, 5),
        "price_usd": round(random.uniform(20, 2000), 2),
        "region": random.choice(REGIONS),
        "order_ts_utc": datetime.utcnow().isoformat(),
    }

if __name__ == "__main__":
    while True:
        evt = generate_event()
        producer.send("orders", evt)
        print("Sent:", evt)
        time.sleep(1)

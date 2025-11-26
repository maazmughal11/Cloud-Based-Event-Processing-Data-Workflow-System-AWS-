

# 🚀 AWS Real-Time Retail Analytics Pipeline

**Author:** **Maaz Mughal**
**Keywords:** Data Engineering • AWS • Real-Time Streaming • ETL • Analytics • Infrastructure-as-Code

---

## 📌 Summary

This project simulates a real-time retail store and processes event-based order data through a modern cloud data stack.
Orders are streamed into Kafka → captured by AWS Lambda → stored raw in an S3 Bronze layer → cleaned and enriched with AWS Glue → aggregated to Gold → loaded into a dimensional Redshift warehouse → consumed by BI tools.

This architecture is directly inspired by real enterprise pipelines used in fintech, e-commerce, IoT, and logistics data platforms.

---

## 🧠 Why This Exists

**Most beginners show notebooks.
Data engineers show pipelines.**

This repo demonstrates:

* Real-time ingestion 👇
* Durable cloud storage 👇
* Scalable PySpark transformations 👇
* Warehouse modeling 👇
* Infrastructure-as-code 👇
* Testable transformations 👇

It proves I understand systems — not just Python scripts.

---

# 🏗️ Architecture (Medallion)

```
Kafka Producer → Lambda Kafka Consumer → S3 (Bronze)
       ↓
AWS Glue (Bronze → Silver) → S3 (Silver)
       ↓
AWS Glue (Silver → Gold) → S3 (Gold)
       ↓
Redshift (Dimensions + Facts + Views)
       ↓
BI Dashboards (QuickSight / Power BI)
```

### 🔥 Layers explained

* **Bronze** — raw, immutable ingestion
* **Silver** — cleaned & normalized tables
* **Gold** — business ready KPIs & aggregates
* **Redshift** — curated analytics warehouse

This is the **industry standard** for cloud data engineering.

---

# 💡 Key Capabilities

✔ **Kafka streaming ingestion** (simulated retail orders)
✔ **AWS Lambda consumer** → lands raw JSON in S3
✔ **AWS Glue ETL (PySpark)** for cleaning + enrichment
✔ **Silver → Gold metrics** (daily revenue, units, unique customers)
✔ **Redshift data warehouse** (dimensional modeling)
✔ **Terraform IaC** to deploy infrastructure
✔ **Docker Kafka local dev**
✔ **Unit tests** for transformations + schemas

---

# 🧰 Tech Stack

| Area      | Tools              |
| --------- | ------------------ |
| Streaming | Kafka              |
| Compute   | AWS Lambda         |
| ETL       | AWS Glue (PySpark) |
| Storage   | Amazon S3          |
| Warehouse | Amazon Redshift    |
| Infra     | Terraform (HCL)    |
| Local Dev | Docker             |
| Testing   | PyTest             |

---

# 📂 Project Structure

```
aws-retail-realtime-pipeline/
│
├── ingestors/                # Kafka ingestion
│   ├── kafka_producer.py
│   ├── lambda_kafka_consumer.py
│   └── sample_events.json
│
├── etl/                      # Glue PySpark transformations
│   ├── glue_bronze_to_silver.py
│   ├── glue_silver_to_gold.py
│   └── transformations/
│       └── enrich_orders.py
│
├── warehouse/                # Analytics schemas
│   ├── create_redshift_schemas.sql
│   ├── load_silver_to_redshift.sql
│   └── gold_views.sql
│
├── infra/
│   ├── terraform/            # IaC to deploy AWS stack
│   │   ├── main.tf
│   │   ├── s3.tf
│   │   ├── iam.tf
│   │   ├── lambda.tf
│   │   ├── glue.tf
│   │   ├── redshift.tf
│   │   └── variables.tf
│   └── architecture_diagram.md
│
├── local/                    # Local simulation
│   ├── docker-compose.kafka.yml
│   └── kafka_topics.sh
│
├── tests/                    # Pipeline tests
│   ├── test_enrich_orders.py
│   └── test_schemas.py
│
└── README.md
```

---

# 📦 How To Run (Local Kafka Demo)

1️⃣ Start Kafka

```bash
docker compose -f local/docker-compose.kafka.yml up -d
bash local/kafka_topics.sh
```

2️⃣ Start the producer

```bash
python ingestors/kafka_producer.py
```

3️⃣ Lambda consumer runs in AWS in production
But locally you can simulate processing or view messages in your container.

---

# 🧪 Testing Transformation Logic

```
pytest tests/test_enrich_orders.py
pytest tests/test_schemas.py
```

Tests verify:

* Enrichment creates correct KPI values
* Schema matches Redshift tables
* No invalid data passes through the pipeline

---

# 📊 Analytics / BI

Once Gold data is in Redshift, dashboards can show:

* Revenue by product
* Revenue by region
* Orders per customer segment
* GMV over time
* Top selling SKUs
* Daily active customers

You can power:
➡️ QuickSight
➡️ Power BI
➡️ Tableau

---

# 🌍 Infra-as-Code

**Everything is defined in Terraform.**

No console clicking.
No manual deployment.
Reproducible.
Professional.

It creates:

* S3 Bronze / Silver / Gold buckets
* IAM Roles
* Glue Jobs
* Lambda Function
* Redshift Cluster

---

# 🏢 Real Enterprise Pattern

This exact design is used in:

* e-commerce
* shipping/tracking
* fraud detection
* IoT telemetry
* social media streams
* fintech transactions

Real companies don’t do “CSV upload → Excel → Jupyter.”
They do streaming → storage tiers → ETL → warehouse → dashboards.

That’s why this project exists.

---

# 🙋 About the Author

I'm **Maaz Mughal**, and I built this project to demonstrate how I approach real-world data engineering:

* I design systems end-to-end
* I automate infrastructure
* I test transformation logic
* I optimize for business insights
* I make pipelines production-ready

---

# 🧾 License

Open for educational use and portfolio presentation.
Not licensed for commercial SaaS resale.

---



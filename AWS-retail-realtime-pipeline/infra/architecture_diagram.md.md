# Architecture Diagram – AWS Real-Time Retail Pipeline

```mermaid
flowchart LR
    A[Kafka Producer\nPython] -->|Order Events| B[Kafka Topic: orders]
    B --> C[Lambda Kafka Consumer]
    C -->|Raw JSON| D[S3 Bronze Bucket]

    D --> E[Glue Job: Bronze → Silver]
    E --> F[S3 Silver Bucket]

    F --> G[Glue Job: Silver → Gold]
    G --> H[S3 Gold Bucket]

    H --> I[Redshift\nDim / Fact Tables]
    I --> J[BI Tool\nQuickSight / Power BI]

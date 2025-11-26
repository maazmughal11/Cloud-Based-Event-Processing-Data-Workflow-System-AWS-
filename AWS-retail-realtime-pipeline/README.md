# AWS Real-Time Retail Analytics Pipeline

**Author:** Maaz Mughal  

## Overview

This project implements a real-time retail data pipeline using Kafka, AWS, and Redshift. 
Incoming order events are streamed through Kafka, landed in an S3 bronze layer by AWS Lambda, transformed into silver and gold layers with AWS Glue (PySpark), and loaded into a Redshift star schema for analytics and BI dashboards.

## Architecture

Kafka → AWS Lambda → S3 (Bronze) → AWS Glue (Bronze → Silver → Gold) → Redshift → BI (QuickSight / Power BI)

## Key Features

- Simulated e-commerce event stream using a Python Kafka producer
- Bronze / Silver / Gold medallion data model on S3
- PySpark-based data enrichment and aggregations in AWS Glue
- Redshift dimensional model with product and region dimensions
- Infrastructure-as-Code scaffolding with Terraform
- Local Kafka setup for offline development and testing
- Unit tests for transformation logic using PyTest

## Tech Stack

- **Languages:** Python, SQL, HCL (Terraform)
- **Data & ETL:** Kafka, AWS Lambda, AWS Glue, PySpark, S3
- **Warehouse:** Amazon Redshift
- **Orchestration / Infra:** Terraform, Docker
- **Analytics:** QuickSight / Power BI (for dashboards on top of Redshift/Gold)

## How This Relates to My Experience

I use this project to demonstrate data engineering workflows similar to the ETL, cloud, and analytics work I do for clients: 
designing pipelines, modeling data in warehouses, and enabling real-time and batch analytics.

## Getting Started (Local Kafka Demo)

1. Start Kafka:
   ```bash
   docker compose -f local/docker-compose.kafka.yml up -d
   bash local/kafka_topics.sh

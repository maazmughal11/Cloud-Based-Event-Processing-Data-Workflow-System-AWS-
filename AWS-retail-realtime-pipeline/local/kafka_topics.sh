#!/usr/bin/env bash
docker exec -it $(docker ps --filter "ancestor=bitnami/kafka:latest" -q) \
  kafka-topics.sh --create --topic orders --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1

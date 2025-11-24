# Kafka Connect

## Overview
Connect Kafka cluster with external MySQL database and stream data to Kafka topic via `debezium-connector-mysql` connector plugin.
Sample Connector and SMTs (single message transformation) configs are provided in `cp-all-in-one/connectors_config` folder.

## Presetup
### Init Kafka Cluster with Confluent Platform
```
docker compose -f ./cp-all-in-one/docker-compose.yml up -d
```
### Init MySQL database
```
docker compose -f ./mysql/docker-compose.yml up -d
```

**Note**: Before running above `docker compose`, ensure `MySQL` and `Connect` (aka Kafka Connect) share `mysql-connect-shared-network` to communicate each other, 
since they are configured in separate docker compose project. First, create `mysql-connect-shared-network` as external shared network:
```
docker network create mysql-connect-shared-network
```

After setting up Kafka Cluster with preconfig settings, check if `debezium-connector-mysql` plugin installed successfully.

## List all connector plugins
```
curl -sS -X GET localhost:8083/connector-plugins | jq
```

Output:
```
[
  {
    "class": "io.debezium.connector.mysql.MySqlConnector",
    "type": "source",
    "version": "3.1.2.Final"
  },
  ...
]
```

## Create MySQL Source Connector
With `debezium-connector-mysql` plugin installed above, create a new MySQL Source Connector.
First, create internal Kafka Topic called `db_schema_changes` based on `connector1.json` config JSON file, where the connector will store the database schema history.
```
kafka-topics \
  --bootstrap-server broker:9092 \
  --create \
  --topic db_schema_changes \
  --partitions 4 \
  --replication-factor 1
```

Start Connector1:
```
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ --data-binary @./cp-all-in-one/connectors_config/connector1.json
```

## List all connectors
```
curl -X GET http://localhost:8083/connectors | jq
```

## Check status of connector
```
curl -X GET http://localhost:8083/connectors/connector1/status | jq
```

## Get the connector configuration, tasks, and type of connector
```
curl -X GET http://localhost:8083/connectors/connector1 | jq
```

## Delete connector
```
curl -X DELETE http://localhost:8083/connectors/connector1
```

More on how to monitor connectors using REST APIs: https://docs.confluent.io/platform/current/connect/monitoring.html
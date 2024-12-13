# **Kafka-PostgreSQL Real-Time Data Pipeline**

This project demonstrates a real-time data streaming pipeline using Kafka for message streaming and PostgreSQL for data persistence. The setup ingests synthetic data, streams it through Kafka producers, and consumes it with Kafka consumers for storage in a relational database.

## **Key Features**
* **Producer**: Reads synthetic data from a Parquet file and streams messages to a Kafka topic.
* **Consumer**: Subscribes to the Kafka topic, processes messages, and stores them in PostgreSQL tables.
* **Database Schema**: Includes tables for raw and summarized stock price and sales trend data.
* **Dockerized Setup**: Orchestrated services (Kafka, Zookeeper, PostgreSQL, producer, consumer) using Docker Compose.

## **Build and Run Instructions**
1. **Start the Docker Containers:** Build and start all services in detached mode:
```bash
docker-compose up -d --build
```
2. **Check Logs (Optional):** To ensure all services are running smoothly, check logs for Kafka, producer, or consumer:
```bash
(venv) /path/to/your/project-folder>docker-compose logs producer
producer  | {"timestamp": "2024-01-24 02:40:00", "stock_price": 521.04, "sales_trend": 222.01} sent to partition 0.
producer  | {"timestamp": "2024-01-24 02:41:00", "stock_price": 521.29, "sales_trend": 217.43} sent to partition 0.
producer  | {"timestamp": "2024-01-24 02:42:00", "stock_price": 524.74, "sales_trend": 217.87} sent to partition 0.
producer  | {"timestamp": "2024-01-24 02:43:00", "stock_price": 522.84, "sales_trend": 223.37} sent to partition 0.
producer  | {"timestamp": "2024-01-24 02:44:00", "stock_price": 523.96, "sales_trend": 220.26} sent to partition 0.
...

(venv) /path/to/your/project-folder>
```

```bash
(venv) /path/to/your/project-folder>docker-compose logs consumer
consumer  | {"timestamp": "2024-01-24 02:40:00", "stock_price": 521.04, "sales_trend": 222.01} sent to partition 0.
consumer  | {"timestamp": "2024-01-24 02:41:00", "stock_price": 521.29, "sales_trend": 217.43} sent to partition 0.
consumer  | {"timestamp": "2024-01-24 02:42:00", "stock_price": 524.74, "sales_trend": 217.87} sent to partition 0.
consumer  | {"timestamp": "2024-01-24 02:43:00", "stock_price": 522.84, "sales_trend": 223.37} sent to partition 0.
consumer  | {"timestamp": "2024-01-24 02:44:00", "stock_price": 523.96, "sales_trend": 220.26} sent to partition 0.
...

(venv) /path/to/your/project-folder>
```


3. **Access PostgreSQL Database:** Connect to the PostgreSQL container:
```bash
docker exec -it <postgres_container_name> psql -U <user_name> -d <db_name>
```
4. **Run SQL commands** to inspect the data:
```psql
# list all the tables in the current schema
\dt
```

```sql
<db_name>=# SELECT * FROM synthetic_data LIMIT 5;

 id |      timestamp      | stock_price | sales_trend 
----+---------------------+-------------+-------------
  1 | 2024-01-01 00:00:00 |      101.41 |      197.74
  2 | 2024-01-01 00:01:00 |      101.16 |      204.87
  3 | 2024-01-01 00:02:00 |      104.33 |      203.78
  4 | 2024-01-01 00:03:00 |      108.48 |      198.31
  5 | 2024-01-01 00:04:00 |      110.44 |      198.77
(5 rows)

<db_name>=# 
```

5. **Stop and Remove Containers:** Stop the running containers and remove volumes to clean up data:
```bash
docker-compose down -v
```
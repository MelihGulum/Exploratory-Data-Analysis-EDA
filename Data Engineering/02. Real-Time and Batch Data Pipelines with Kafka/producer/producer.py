from confluent_kafka import Producer
import time
import pandas as pd
import json


def delivery_report(err, msg):
    """Callback for delivery reports."""
    if err:
        print(f'Produce to topic {msg.topic()} failed for event: {msg.key()}')
    else:
        val = msg.value().decode('utf8')
        print(f'{val} sent to partition {msg.partition()}.')


df = pd.read_parquet(r"data/synthetic_data.parquet", engine='pyarrow')
df['timestamp'] = df['timestamp'].astype('str')

def main():
    # Configure the producer
    conf = {
        'bootstrap.servers': 'kafka:29092',  # Kafka broker inside the container network
        'client.id': 'python-producer'
    }

    producer = Producer(conf)
    topic = "test_topic"

    print("Producing messages to Kafka...")
    for _, row in df.iterrows():
        message = {
            "timestamp": row['timestamp'],
            "stock_price": row['stock_price'],
            "sales_trend": row['sales_trend']
        }
        serialized_message = json.dumps(message).encode('utf-8')

        producer.produce(topic, value=serialized_message, callback=delivery_report)
        producer.flush()
        # time.sleep(1)

    print("Finished producing messages.")


if __name__ == "__main__":
    main()

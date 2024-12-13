from confluent_kafka import Consumer, KafkaException, KafkaError
import json
from database import database


def main():
    try:
        # Consumer configuration
        conf = {
            'bootstrap.servers': 'kafka:29092',  # Kafka broker inside the container network
            'group.id': 'python-consumer',
            'auto.offset.reset': 'earliest'  # Set to 'earliest' to read from the beginning
        }

        # Initialize the Kafka Consumer
        consumer = Consumer(conf)
        topic = "test_topic"

        conn, cursor = database.get_db_connection()  # Create and reuse the connection

        consumer.subscribe([topic])  # Subscribe to the topic
        print(f"Subscribed to topic: {topic}")
        print("Consumer started. Waiting for messages...")

        while True:
            # Poll for messages
            msg = consumer.poll(1.0)  # Poll with a timeout of 1 second

            if msg is None:
                print('No message received. Polling...')
                continue

            if msg.error():
                if msg.error().code() == KafkaError._PARTITION_EOF:
                    # End of partition event
                    print(f"End of partition reached {msg.partition()} at offset {msg.offset()}")
                else:
                    # Log any other error
                    print(f"Kafka error: {msg.error()}")
                    raise KafkaException(msg.error())
            else:
                # Successfully received a message
                message = msg.value().decode('utf-8')
                # print(f"Received message: {message}")

                try:
                    message_data = json.loads(message)

                    timestamp = message_data['timestamp']
                    stock_price = message_data['stock_price']
                    sales_trend = message_data['sales_trend']

                    database.insert_into_db(cursor, timestamp, stock_price, sales_trend)

                except ValueError as e:
                    print(f"Error parsing message: {e}")

    except Exception as e:
        print("Error occurred:", e)

    finally:
        # Clean up resources if consumer was initialized
        print("Finished consuming messages.")
        if cursor:
            cursor.close()
        if conn:
            conn.close()
        consumer.close()


if __name__ == "__main__":
    main()
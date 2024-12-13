from confluent_kafka import Consumer, KafkaException, KafkaError

def main():
    # Configure the consumer
    conf = {
        'bootstrap.servers': '127.0.0.1:9092',
        'group.id': 'test_group',
        'auto.offset.reset': 'earliest'
    }
    consumer = Consumer(conf)

    topic = "test_topic"

    try:
        consumer.subscribe([topic])
        print(f"Subscribed to topic: {topic}")

        while True:
            msg = consumer.poll(timeout=1.0)
            if msg is None:
                continue
            if msg.error():
                if msg.error().code() == KafkaError._PARTITION_EOF:
                    continue  # End of partition event
                else:
                    raise KafkaException(msg.error())
            print(f"Received message: {msg.value().decode('utf-8')}")

    except KeyboardInterrupt:
        print("Shutting down consumer.")
    finally:
        consumer.close()

if __name__ == "__main__":
    main()

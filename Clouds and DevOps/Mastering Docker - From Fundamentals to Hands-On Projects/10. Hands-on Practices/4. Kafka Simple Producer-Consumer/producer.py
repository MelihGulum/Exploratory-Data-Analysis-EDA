from confluent_kafka import Producer
import time

def delivery_report(err, msg):
    """Callback for delivery reports."""
    if err:
        print(f'Produce to topic {msg.topic()} failed for event: {msg.key()}')
    else:
        val = msg.value().decode('utf8')
        print(f'{val} sent to partition {msg.partition()}.')

def main():
    # Configure the producer
    conf = {'bootstrap.servers': '127.0.0.1:9092'}
    producer = Producer(conf)

    topic = "test_topic"

    print("Producing messages to Kafka...")
    for i in range(10):
        message = f"Message {i}"
        producer.produce(topic, value=message, callback=delivery_report)
        producer.flush()  # Ensure message is delivered
        time.sleep(1)  # Simulate a delay between messages

    print("Finished producing messages.")

if __name__ == "__main__":
    main()

# **Kafka Simple Producer-Consumer**
This project demonstrates a basic Kafka producer and consumer setup using Python. It sends messages from the producer to a Kafka topic, and the consumer retrieves and processes those messages. The project uses Confluent Kafka Python client and Docker Compose to set up the necessary Kafka and Zookeeper services.

## **Steps to Run the Project:**
1. **Build and Start the Docker Containers:** First, use Docker Compose to set up Kafka and Zookeeper.
```bash
docker-compose up -d --build
```
This will start Zookeeper and Kafka containers. Zookeeper is needed by Kafka for managing brokers and topics.

2. **Install Python Dependencies:** Install the required Python libraries in your environment by running:
```bash
pip install -r requirements.txt
```
Ensure that confluent-kafka is installed, as it is required for Kafka producer and consumer functionality.

3. **Navigate to the Project Folder:** Ensure your terminal is in the directory where the producer.py and consumer.py scripts are located. You can use the cd command to navigate to the folder:

3. **Run the Producer:** In one terminal, run the producer script:
```bash
python producer.py
```
This will produce 10 messages to the Kafka topic test_topic. You will see a message confirming that each message has been sent to a partition.
```
(venv) /path/to/your/project-folder>python producer.py
Producing messages to Kafka...
Message 0 sent to partition 0.
Message 1 sent to partition 0.
Message 2 sent to partition 0.
Message 3 sent to partition 0.
Message 4 sent to partition 0.
Message 5 sent to partition 0.
Message 6 sent to partition 0.
Message 7 sent to partition 0.
Message 8 sent to partition 0.
Message 9 sent to partition 0.
Finished producing messages.

(venv) /path/to/your/project-folder>
```
4. **Run the Consumer:** In another terminal, run the consumer script:
```bash
python consumer.py
```
This will start consuming messages from the test_topic. You will see the consumer print each received message.
```
(venv) /path/to/your/project-folder>python consumer.py
Subscribed to topic: test_topic
Received message: Message 0
Received message: Message 1
Received message: Message 2
Received message: Message 3
Received message: Message 4
Received message: Message 5
Received message: Message 6
Received message: Message 7
Received message: Message 8
Received message: Message 9

```

5. **Streaming Messages:** Once both producer and consumer are running in separate terminals, you should see streaming of messages. The producer will send a message every second, and the consumer will process them and print each message.

6. **Stopping the Services:** To stop the Docker containers:
```bash
docker-compose down -v
```
This will stop and remove the Kafka and Zookeeper containers.
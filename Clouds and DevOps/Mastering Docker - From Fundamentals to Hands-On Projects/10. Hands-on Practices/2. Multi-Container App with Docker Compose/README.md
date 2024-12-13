# **Multi-Container App with Docker Compose**

This project demonstrates deploying a multi-container application using Docker Compose. The application consists of a Flask web server and a Redis database service. The Flask app increments and displays a counter stored in Redis each time the homepage is visited.

<div align="center"> 
  <figure>
    <img src="https://github.com/user-attachments/assets/6a97849f-2171-43cd-8eaf-0c5d2cd4ca44" alt="Multi-Container App" width="100%" height="70%">
    <figcaption>Multi-Container App</figcaption>
  </figure>
</div>
<br>

## **Steps to Build and Run the Application**
1. **Build and Start Services:** Run the following command to build and start the containers:
```bash
docker-compose up -d --build
```
2. **Access the Application**: Open your browser and navigate to:
```
http://localhost:5000
```
You will see a message like:
```
Welcome! This page has been viewed 1 times.
```
Refreshing the page (F5) will increment the count and display an updated message, such as:
```
Welcome! This page has been viewed 2 times.
```

3. **Stop the Containers:** When finished, stop the services using:
```
docker-compose down -v
```
# **Deploying a Python Flask Web App**

This project demonstrates how to deploy a simple Python Flask web application using Docker. The app serves as an introduction to containerization for Flask applications, enabling easy deployment and scalability.

<div align="center"> 
  <figure>
    <img src="https://github.com/user-attachments/assets/7bbfcd1d-9e46-4ab5-8428-eb18533043b9" alt="flask-docker-app" width="100%" height="50%">
    <figcaption>flask-docker-app</figcaption>
  </figure>
</div>
<br>

## **Build and Run the Docker Image**
1. **Build the Docker image:**
```bash
docker build -t flask-app .
```
2. **Run the container:**
```bash
docker run -p 5000:5000 flask-app
```
3. **Visit http://localhost:5000** in your browser to see the app running.
4. Flask will stop gracefully on SIGINT (Ctrl-C).
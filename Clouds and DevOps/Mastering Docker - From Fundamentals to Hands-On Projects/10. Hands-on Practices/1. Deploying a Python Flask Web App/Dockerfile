# Use an official Python runtime as the base image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Install any necessary dependencies
RUN pip install -r requirements.txt

# Expose port 5000 to the outside world
EXPOSE 5000

# Define the command to run the app
CMD ["python", "app.py"]

# Use Python as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev gcc \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the requirements file to the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set the PYTHONPATH to include the project root
ENV PYTHONPATH=/app

# Copy the application code (all subdirectories)
COPY consumer /app/consumer
COPY producer /app/producer
COPY database /app/database
COPY etl /app/etl
COPY data /app/data

# Copy any additional project files
COPY init.sql /app/init.sql

# Default command
CMD ["bash"]

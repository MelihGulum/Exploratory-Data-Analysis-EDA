# **PostgreSQL Database in Docker**

This project demonstrates setting up a PostgreSQL database with Docker Compose and connecting to it using a Python script. The PostgreSQL database is initialized with a table and sample data using an init.sql file. The Python script (db.py) connects to the database and retrieves the version of PostgreSQL to ensure a successful connection.

The project consists of the following components:
* **Docker Compose (docker-compose.yml)**: Defines the PostgreSQL service and configuration.
* **Python Script (db.py)**: Connects to the PostgreSQL database and executes a simple query to fetch the PostgreSQL version.
* **SQL Initialization Script (init.sql)**: Initializes the PostgreSQL database with a users table and some sample data.
* **Dockerfile**: Defines how to build a Docker image for the Python application

## **Steps to Build and Run the Application**

1. **Build and Start Services**: Run the following command to build and start the containers:
```bash
docker-compose up --build
```
2. **Connect to the PostgreSQL Database to Verify Initialization:**:
```bash
docker exec -it <container_name> psql -U <POSTGRES_USER> -d <POSTGRES_DB>
````
3. **Check the users Table:** After connecting to PostgreSQL, run the following query to check the users table:
```sql
SELECT * FROM users;
```

```sql
# Example:
my_database=# SELECT * FROM users;
 id |    name    |         email          |        created_at         
----+------------+------------------------+---------------------------
  1 | John Doe   | john.doe@example.com   | 2024-11-22 11:36:21.45736
  2 | Jane Smith | jane.smith@example.com | 2024-11-22 11:36:21.45736
(2 rows)
```

3. **Stop the Containers:** When finished, stop the services using:
```bash
docker-compose down
```
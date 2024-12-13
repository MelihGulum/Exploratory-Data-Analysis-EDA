import psycopg2


def connect_to_postgres():
    try:
        # Connect to the PostgreSQL database
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host="localhost",
            port="5432"
        )
        print("Connection successful!")

        # Create a cursor
        cursor = conn.cursor()

        # Execute a query
        cursor.execute("SELECT version();")
        db_version = cursor.fetchone()
        print(f"PostgreSQL version: {db_version}")

        # Close the connection
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"An error occurred: {e}")


if __name__ == "__main__":
    connect_to_postgres()

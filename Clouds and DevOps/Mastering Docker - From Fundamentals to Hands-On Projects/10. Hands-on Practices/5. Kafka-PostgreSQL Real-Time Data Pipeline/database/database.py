import psycopg2


def get_db_connection():
    try:
        # Create a new connection and cursor only once
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host="postgres",
            port=5432
        )
        cursor = conn.cursor()
        print("Database connection established.")
        return conn, cursor
    except Exception as e:
        print(f"Error connecting to database: {e}")
        return None, None


# Function to insert data into the 'sensor_data' table
def insert_into_db(cursor, timestamp, stock_price, sales_trend):
    try:
        cursor.execute(
            "INSERT INTO synthetic_data (timestamp, stock_price, sales_trend) VALUES (%s, %s, %s)",
            (timestamp, stock_price, sales_trend)
        )
        cursor.connection.commit()  # Commit the transaction using the connection
        print(f"Inserted into DB: Timestamp={timestamp}, stock_price={stock_price}, sales_trend={sales_trend}")
    except Exception as e:
        print(f"Error inserting into DB: {e}")
import pandas as pd
from sqlalchemy import create_engine
from database import database
import warnings
warnings.filterwarnings('ignore')


# Function to perform ETL operation (Extract, Transform, Load)
def run_etl_process():
    print("The ETL process has been scheduled to run at 5-minute intervals.")

    # 1. Establish database connection
    print("Establishing connection to the database...")
    conn, cursor = database.get_db_connection()

    if not conn:
        print("Failed to connect to the database. Exiting ETL process.")
        return

    try:
        print("Extracting data from 'synthetic_data' table...")
        query = "SELECT * FROM synthetic_data"
        df = pd.read_sql(query, conn)
        print(f"Extracted {len(df)} rows from the database.")

        if df.empty:
            print("No data found in 'sensor_data'. Exiting ETL process.")
            return

        print("Transforming data for summaries...")

        print("Converting 'timestamp' column to datetime...")
        df['timestamp'] = pd.to_datetime(df['timestamp'])

        print(f"Total Missing Values: {df.isnull().sum().sum()}")

        print('Dropping unique "id" column.' )
        df.drop(columns=["id"], inplace=True)

        print(f'Total duplicated: {sum(df.duplicated())}')
        if sum(df.duplicated()) > 0:
            print(f"{sum(df.duplicated())} duplicated values were dropped.")
            df.drop_duplicates(inplace=True)


        print("Calculating 10-minute summary for stock_price data...")
        stock_price_summary = (
            df
            .assign(interval_start=df['timestamp'].dt.floor('10min'))
            .groupby('interval_start')['stock_price']
            .mean()
            .reset_index()
            .rename(columns={'stock_price': 'avg_stock_price'})
        )

        print("Calculating 20-minute summary for sales_trend data...")
        sales_trend_summary = (
            df
            .assign(interval_start=df['timestamp'].dt.floor('20min'))
            .groupby('interval_start')['sales_trend']
            .mean()
            .reset_index()
            .rename(columns={'sales_trend': 'avg_sales_trend'})
        )

        print("Transformation complete. Summaries generated.")
        print("Loading transformed data into PostgreSQL...")

        engine = create_engine('postgresql://admin:admin123@postgres:5432/kafka_data')

        print("Inserting stock_price summary data...")
        stock_price_summary.to_sql('stock_price_summary', engine, if_exists='replace', index=False)
        print(f"Inserted {len(stock_price_summary)} rows into 'stock_price_summary' table.")

        print("Inserting sales_trend summary data...")
        sales_trend_summary.to_sql('sales_trend_summary', engine, if_exists='replace', index=False)
        print(f"Inserted {len(sales_trend_summary)} rows into 'sales_trend_summary' table.")

        print("ETL Process Completed Successfully!")

    except Exception as e:
        print(f"Error during ETL process: {e}")

    finally:
        print("Closing database connection.")
        cursor.close()
        conn.close()


if __name__ == "__main__":
    run_etl_process()

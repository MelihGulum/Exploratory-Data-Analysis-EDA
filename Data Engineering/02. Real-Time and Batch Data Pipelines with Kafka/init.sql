-- Create the sensor_data table
CREATE TABLE IF NOT EXISTS synthetic_data (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP,
    stock_price FLOAT,
    sales_trend FLOAT
);

-- Create the temperature_summary table
CREATE TABLE IF NOT EXISTS stock_price_summary (
    timestamp TIMESTAMP PRIMARY KEY,
    stock_price_avg FLOAT
);

-- Create the humidity_summary table
CREATE TABLE IF NOT EXISTS sales_trend_summary (
    timestamp TIMESTAMP PRIMARY KEY,
    sales_trend_avg FLOAT
);

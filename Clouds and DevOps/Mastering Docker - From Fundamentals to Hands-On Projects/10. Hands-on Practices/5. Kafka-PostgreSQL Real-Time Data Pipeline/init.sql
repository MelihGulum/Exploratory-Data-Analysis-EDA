-- Create the synthetic_data table
CREATE TABLE IF NOT EXISTS synthetic_data (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP,
    stock_price FLOAT,
    sales_trend FLOAT
);

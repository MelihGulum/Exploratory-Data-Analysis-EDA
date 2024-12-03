-- Q1. What is the unique count and total amount for each transaction type?
SELECT txn_type,
       COUNT(customer_id) AS unique_count,
       FORMAT(SUM(txn_amount), 'N0') AS total_amount
FROM customer_transactions
GROUP BY txn_type;


-- Q2. What is the average total historical deposit counts and amounts for all customers?
WITH customer_deposit AS (SELECT customer_id,
                                 COUNT(customer_id) AS txn_count,
                                 AVG(txn_amount) AS avg_amount
                          FROM customer_transactions
                          WHERE txn_type = 'deposit'
                          GROUP BY customer_id
                          )

SELECT AVG(txn_count) AS avg_txn_count,
       AVG(avg_amount) AS avg_amount
FROM customer_deposit;


-- Q3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
WITH cte_transaction AS (SELECT customer_id,
                                MONTH(txn_date) AS txn_month,
                                SUM(CASE WHEN txn_type = 'deposit' THEN 1 ELSE 0 END) AS deposit_count,
                                SUM(CASE WHEN txn_type = 'purchase' THEN 1 ELSE 0 END) AS purchase_count,
                                SUM(CASE WHEN txn_type = 'withdrawal' THEN 1 ELSE 0 END) AS withdrawal_count
                         FROM customer_transactions
                         GROUP BY customer_id, 
                                  MONTH(txn_date)
                         )

SELECT txn_month,
       COUNT(customer_id) AS total_customer
FROM cte_transaction
WHERE deposit_count > 1 
    AND (purchase_count = 1 OR withdrawal_count = 1)
GROUP BY txn_month


-- Q4. What is the closing balance for each customer at the end of the month?

-- End date in the month of the max date of our dataset
DECLARE @maxDate DATE;
SET @maxDate = (SELECT EOMONTH(MAX(txn_date))
                FROM customer_transactions);


-- CTE 1 - monthly_transactions: Monthly transactions of each customer
-- CTE 2 - recursive_dates     : Increment last days of each month till they are equal to @maxDate 

WITH monthly_transactions AS (SELECT customer_id,
                                     EOMONTH(txn_date) AS end_date,
                                     SUM(CASE 
                                             WHEN txn_type IN ('withdrawal', 'purchase') THEN -txn_amount
                                             ELSE txn_amount END) AS transactions
                              FROM customer_transactions
                              GROUP BY customer_id,
                                       EOMONTH(txn_date)
                              ),

     recursive_dates AS (SELECT DISTINCT customer_id,
                                CAST('2020-01-31' AS DATE) AS end_date
                         FROM customer_transactions
                         UNION ALL
                         SELECT customer_id,
                                EOMONTH(DATEADD(MONTH, 1, end_date)) AS end_date
                         FROM recursive_dates
                         WHERE EOMONTH(DATEADD(MONTH, 1, end_date)) <= @maxDate
                         )

SELECT r.customer_id,
       r.end_date,
       COALESCE(m.transactions, 0) AS transactions,
       SUM(m.transactions) OVER (PARTITION BY r.customer_id ORDER BY r.end_date 
                                 ROWS UNBOUNDED PRECEDING) AS closing_balance
FROM recursive_dates AS r
LEFT JOIN monthly_transactions AS m
    ON r.customer_id = m.customer_id
        AND r.end_date = m.end_date;


-- Q5. What is the percentage of customers who increase their closing balance by more than 5%?

-- CTE 1 - monthly_transactions: Monthly transactions of each customer
-- CTE 2 - recursive_dates     : Increment last days of each month till they are equal to @maxDate 
-- CTE 3: Closing balance of each customer by monthly (Q4)
-- CTE 4: CTE 3 & next_balance
-- CTE 5: Calculate the increase percentage of closing balance for each customer

DECLARE @maxDate DATE;
SET @maxDate = (SELECT EOMONTH(MAX(txn_date))
                FROM customer_transactions);


WITH monthly_transactions AS (SELECT customer_id,
                                     EOMONTH(txn_date) AS end_date,
                                     SUM(CASE 
                                             WHEN txn_type IN ('withdrawal', 'purchase') THEN -txn_amount
                                             ELSE txn_amount END) AS transactions
                              FROM customer_transactions
                              GROUP BY customer_id,
                                       EOMONTH(txn_date)
                              ),

     recursive_dates AS (SELECT DISTINCT customer_id,
                                CAST('2020-01-31' AS DATE) AS end_date
                         FROM customer_transactions
                         UNION ALL
                         SELECT customer_id,
                                EOMONTH(DATEADD(MONTH, 1, end_date)) AS end_date
                         FROM recursive_dates
                         WHERE EOMONTH(DATEADD(MONTH, 1, end_date)) <= @maxDate
                         ),

     customers_balance AS (SELECT r.customer_id,
                                  r.end_date,
                                  COALESCE(m.transactions, 0) AS transactions,
                                  SUM(m.transactions) OVER (PARTITION BY r.customer_id ORDER BY r.end_date 
                                                            ROWS UNBOUNDED PRECEDING) AS closing_balance
                           FROM recursive_dates r
                               LEFT JOIN  monthly_transactions m
                                   ON r.customer_id = m.customer_id
                                       AND r.end_date = m.end_date
                           ),

     customers_next_balance AS (SELECT *,
                                       LEAD(closing_balance) OVER(PARTITION BY customer_id ORDER BY end_date) AS next_balance
                                FROM customers_balance
                                ),

     pct_increase AS (SELECT *,
                            100.0 * (next_balance - closing_balance) / closing_balance AS pct
                      FROM customers_next_balance
                      WHERE closing_balance ! = 0 
                          AND next_balance IS NOT NULL
                      )

--Create a temporary table because of the error: Null value is eliminated by an aggregate or other SET operation
SELECT *
INTO #temp
FROM pct_increase;

--Calculate the percentage of customers whose closing balance increasing 5% compared to the previous month
SELECT CAST(100.0 * COUNT(DISTINCT customer_id) AS FLOAT)
            / (SELECT COUNT(DISTINCT customer_id) 
               FROM customer_transactions) AS pct_customers
FROM #temp
WHERE pct > 5;

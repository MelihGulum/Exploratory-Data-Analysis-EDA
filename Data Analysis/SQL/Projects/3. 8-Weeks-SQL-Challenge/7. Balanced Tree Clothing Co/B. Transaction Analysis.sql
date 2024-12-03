-- Q1. How many unique transactions were there?
SELECT COUNT(DISTINCT txn_id) AS unique_transactions
FROM sales


-- Q2. What is the average unique products purchased in each transaction?
SELECT AVG(product_count) AS avg_product_count
FROM (SELECT txn_id,
             SUM(qty) AS product_count
      FROM sales
      GROUP BY txn_id
      ) AS a;


-- Q3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
WITH transaction_revenue AS (SELECT txn_id, 
                                    SUM(qty * price) AS revenue
                             FROM sales
                             GROUP BY txn_id
                             )
SELECT DISTINCT
       PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) OVER() AS median_25th,
       PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY revenue) OVER() AS median_50th,
       PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) OVER() AS median_75th
FROM transaction_revenue;


-- Q4. What is the average discount value per transaction?
SELECT CAST(AVG(discount_amount) AS DECIMAL(5, 2)) AS avg_discount_amount
FROM (SELECT txn_id,
             SUM(qty * price * discount / 100.0) AS discount_amount
      FROM sales
      GROUP BY txn_id
      ) AS a;


-- Q5. What is the percentage split of all transactions for members vs non-members?
WITH transactions_cte AS (SELECT member,
                                 COUNT(DISTINCT txn_id) AS unique_txn
                          FROM sales
                          GROUP BY member
                          )
SELECT *,
       CAST(100.0 * unique_txn / (SELECT SUM(unique_txn) FROM transactions_cte) AS FLOAT) AS pct_member_txn
FROM transactions_cte;


-- Q6. What is the average revenue for member transactions and non-member transactions?
WITH revenue_cte AS (SELECT member,
                            txn_id,
                            SUM(qty * price * 1.0) AS revenue
                     FROM sales
                     GROUP BY member,
                              txn_id
                     )
SELECT member,
       CAST(AVG(revenue) AS DECIMAL(5, 2)) AS avg_revenue
FROM revenue_cte
GROUP BY member;
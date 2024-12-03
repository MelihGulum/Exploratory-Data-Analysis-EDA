-- running customer balance column that includes the impact each transaction
WITH amount_cte AS (SELECT customer_id,
                           txn_date,
                           CASE 
                               WHEN txn_type = 'deposit' THEN txn_amount 
                               ELSE -txn_amount 
                           END AS balance
                    FROM customer_transactions
                    )

SELECT customer_id,
       txn_date,
       SUM(balance) OVER(PARTITION BY customer_id ORDER BY txn_date 
                         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM amount_cte
GROUP BY customer_id, 
         txn_date, 
         balance
ORDER BY customer_id;


-- customer balance at the end of each month
WITH amount_cte AS (SELECT customer_id,
                           MONTH(txn_date) AS txn_month,
                           SUM(CASE
                                   WHEN txn_type = 'deposit' THEN txn_amount
                                   ELSE -txn_amount 
                           END) AS amount
                    FROM customer_transactions
                    GROUP BY customer_id, 
                             MONTH(txn_date)
                    )
SELECT customer_id,
       txn_month,
       SUM(amount) OVER(PARTITION  BY customer_id, txn_month ORDER BY txn_month 
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_balance
FROM amount_cte
GROUP BY customer_id, 
         txn_month, 
         amount;


-- minimum, average and maximum values of the running balance for each customer
WITH running_total_cte AS(SELECT customer_id,
                                 txn_date,
                                 SUM(CASE 
                                         WHEN txn_type = 'deposit' THEN txn_amount 
                                         WHEN txn_type = 'purchase' THEN -txn_amount 
                                         WHEN txn_type = 'withdrawal' THEN -txn_amount 
                                         ELSE 0 
                                     END) OVER(PARTITION BY customer_id ORDER BY txn_date 
                                               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
                            FROM customer_transactions
                            )
SELECT customer_id, 
       MIN(running_total) AS min_running_total,
       AVG(running_total) AS avg_running_total,
       MAX(running_total) AS max_running_total
FROM running_total_cte
GROUP BY customer_id; 


-- Option 1: data is allocated based off the amount of money at the end of the previous month
WITH amount_cte AS (SELECT customer_id,
                           MONTH(txn_date) AS txn_month,
                           CASE
                               WHEN txn_type = 'deposit' THEN txn_amount
                               WHEN txn_type = 'purchase' THEN -txn_amount
                               WHEN txn_type = 'withdrawal' THEN -txn_amount 
                           END as amount
                    FROM customer_transactions
                    ),
     running_balance_cte AS (SELECT *,
                                    SUM(amount) OVER (PARTITION BY customer_id, txn_month ORDER BY customer_id, txn_month
                                                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_balance
                             FROM amount_cte
                             ),
     monthly_allocation_cte AS(SELECT *,
                                      LAG(running_balance, 1) OVER(PARTITION BY customer_id ORDER BY customer_id, txn_month) AS monthly_allocation
                               FROM running_balance_cte
                               )
SELECT txn_month,
       SUM(monthly_allocation) AS total_allocation
FROM monthly_allocation_cte
GROUP BY txn_month
ORDER BY txn_month;


-- Option 2: data is allocated on the average amount of money kept in the account in the previous 30 days
WITH amount_cte AS (SELECT customer_id,
   	                       MONTH(txn_date) AS txn_month,
                           SUM(CASE
                                   WHEN txn_type = 'deposit' THEN txn_amount
                                   WHEN txn_type = 'purchase' THEN -txn_amount
                                   WHEN txn_type = 'withdrawal' THEN -txn_amount 
                               END) as net_amount
                    FROM customer_transactions
                    GROUP BY customer_id,
                             MONTH(txn_date)
                    ),
     running_balance_cte AS (SELECT *,
                                    SUM(net_amount) OVER (PARTITION BY customer_id ORDER BY txn_month
                                                          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_balance
                             FROM amount_cte
                             ),
     avg_running_balance AS(SELECT customer_id, 
                                   txn_month,
                                   AVG(running_balance) OVER(PARTITION BY customer_id) AS avg_balance
                            FROM running_balance_cte
                            GROUP BY customer_id, 
                                     txn_month, 
                                     running_balance
                            )
SELECT txn_month,
       SUM(CASE
               WHEN avg_balance < 0 THEN 0 ELSE avg_balance 
           END) AS data_needed_per_month
FROM avg_running_balance
GROUP BY txn_month
ORDER BY txn_month;


-- Option 3: data is updated real-time
WITH amount_cte AS (SELECT customer_id,
                           MONTH(txn_date) AS txn_month,
                           SUM(CASE 
                                   WHEN txn_type = 'deposit' THEN txn_amount 
                                   ELSE -txn_amount 
                               END) AS balance
                    FROM customer_transactions
                    GROUP BY customer_id, 
                             MONTH(txn_date)
                    ),
     running_balance_cte AS (SELECT customer_id,
                                    txn_month,
                                    SUM(balance) OVER(PARTITION BY customer_id ORDER BY txn_month 
                                                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
                             FROM amount_cte
                             GROUP BY customer_id,
                                      txn_month, 
                                      balance
                             )
SELECT txn_month, 
       SUM(CASE 
               WHEN running_total < 0 THEN 0 ELSE running_total 
           END) Data_required
FROM running_balance_cte
GROUP BY txn_month
ORDER BY txn_month;

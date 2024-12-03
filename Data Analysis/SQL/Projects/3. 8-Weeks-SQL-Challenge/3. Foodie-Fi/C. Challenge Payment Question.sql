/* Q1. The Foodie-Fi team wants to create a new payments table for the year 2020 
       that includes amounts paid by each customer in the subscriptions table with the following requirements:
           monthly payments always occur on the same day of month as the original start_date of any monthly paid plan
           upgrades from basic to monthly or pro plans are reduced by the current paid amount in that month and start immediately
           upgrades from pro monthly to pro annual are paid at the end of the current billing period and also starts at the end of the month period
           once a customer churns they will no longer make payments

       Example outputs for this table might look like the following:

           | customer_id | plan_id | plan_name     | payment_date | amount | payment_order |
           | ----------- | ------- | ------------- | ------------ | ------ | ------------- |
           | 1           | 1       | basic monthly | 2020-08-08   | 9.90   | 1             |
           | 1           | 1       | basic monthly | 2020-09-08   | 9.90   | 2             |
           | 1           | 1       | basic monthly | 2020-10-08   | 9.90   | 3             |
           | 1           | 1       | basic monthly | 2020-11-08   | 9.90   | 4             |
           | 1           | 1       | basic monthly | 2020-12-08   | 9.90   | 5             |
           | 2           | 3       | pro annual    | 2020-09-27   | 199.00 | 1             |
           | …           | …       | …             | …            | …      | …             |
           | 19          | 2       | pro monthly   | 2020-06-29   | 19.90  | 1             |
           | 19          | 2       | pro monthly   | 2020-07-29   | 19.90  | 2             |
           | 19          | 3       | pro annual    | 2020-08-29   | 199.00 | 3             |
           | 20          | 1       | basic monthly | 2020-04-15   | 9.90   | 1             |
           | 20          | 1       | basic monthly | 2020-05-15   | 9.90   | 2             |
           | 20          | 3       | pro annual    | 2020-06-05   | 199.00 | 3             |
           | …           | …       | …             | …            | …      | …             |
           | 1000        | 2       | pro monthly   | 2020-03-26   | 19.90  | 1             |
           | 1000        | 2       | pro monthly   | 2020-04-26   | 19.90  | 2             |
           | 1000        | 2       | pro monthly   | 2020-05-26   | 19.90  | 3             |

*/

--Use a recursive CTE to increment rows for all monthly paid plans until customers changing the plan, except 'pro annual'
DROP TABLE IF EXISTS payments_2020;

WITH dateRecursion AS (SELECT s.customer_id,
                              s.plan_id,
                              p.plan_name,
                              s.start_date AS payment_date,
                              CASE 
                                  WHEN LEAD(s.start_date) OVER(PARTITION BY s.customer_id ORDER BY s.start_date) IS NULL THEN '2020-12-31'
                                  ELSE DATEADD(MONTH, DATEDIFF(MONTH, start_date, LEAD(s.start_date) OVER(PARTITION BY s.customer_id ORDER BY s.start_date)),
		                     start_date) 
                              END AS last_date,
                              p.price AS amount
                       FROM subscriptions AS s
                           JOIN plans AS p 
                               ON s.plan_id = p.plan_id
                       WHERE p.plan_name NOT IN ('trial')
                           AND YEAR(start_date) = 2020

                       UNION ALL
                       SELECT customer_id,
                              plan_id,
                              plan_name,
                              DATEADD(MONTH, 1, payment_date) AS payment_date,
                              last_date,
                              amount
                       FROM dateRecursion
                       WHERE DATEADD(MONTH, 1, payment_date) <= last_date
                           AND plan_name != 'pro annual'
                       )

SELECT customer_id,
       plan_id,
       plan_name,
       payment_date,
       amount,
       ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY payment_date) AS payment_order
INTO payments_2020
FROM dateRecursion
WHERE amount IS NOT NULL
ORDER BY customer_id
OPTION (MAXRECURSION 365);


SELECT * 
FROM payments_2020;
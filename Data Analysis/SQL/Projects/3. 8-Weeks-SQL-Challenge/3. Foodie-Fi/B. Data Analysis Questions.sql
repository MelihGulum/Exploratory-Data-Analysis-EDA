-- Q1. How many customers has Foodie-Fi ever had?
SELECT COUNT(DISTINCT(customer_id)) AS total_customers
FROM subscriptions


-- Q2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
SELECT DATEPART(MONTH, s.start_date) AS start_month,
       DATENAME(MONTH, s.start_date) AS start_month_name,
       COUNT(*) AS trial_subscriptions
FROM subscriptions AS s
    JOIN plans AS p
        ON s.plan_id = p.plan_id
WHERE p.plan_name = 'trial'
GROUP BY DATEPART(MONTH, s.start_date),
         DATENAME(MONTH, s.start_date)
ORDER BY 1;


-- Q3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
WITH plan_2021 AS (SELECT p.plan_id, 
                          p.plan_name,
                          COUNT(*) AS total_2021
                   FROM subscriptions AS s
                       JOIN plans AS p
                           ON s.plan_id = p.plan_id
                   WHERE YEAR(start_date) > 2020
                   GROUP BY p.plan_name,
                            p.plan_id
                   ),
     plan_2020 AS (SELECT p.plan_id, 
                          p.plan_name,
                          COUNT(*) AS total_2020
                   FROM subscriptions AS s
                       JOIN plans AS p
                           ON s.plan_id = p.plan_id
                   WHERE YEAR(s.start_date) = 2020
                   GROUP BY p.plan_name,
                            p.plan_id
                   )
SELECT a.*,
       b.total_2021      
FROM plan_2020 AS a
    LEFT JOIN plan_2021 AS b
        ON a.plan_id = b.plan_id
ORDER BY 1;


-- Q4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
SELECT COUNT(DISTINCT s.customer_id) AS total_churn,
       ROUND(100 * CAST(COUNT(DISTINCT s.customer_id) AS FLOAT) / (SELECT COUNT(DISTINCT customer_id)
                                                                   FROM subscriptions), 1) AS churn_percentage
FROM subscriptions AS s
    JOIN plans AS p
        ON s.plan_id = p.plan_id
WHERE p.plan_name = 'churn';


-- Q5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
WITH next_plan AS (SELECT s.customer_id,
                          s.start_date,
                          p.plan_name,
                          LEAD(p.plan_name) OVER(PARTITION BY s.customer_id ORDER BY p.plan_id) AS next_plan
                   FROM subscriptions AS s
                       JOIN plans AS p
                           ON s.plan_id = p.plan_id
                   )
SELECT COUNT(DISTINCT customer_id) AS total_churn,
       100 * COUNT(DISTINCT customer_id) / (SELECT COUNT(DISTINCT customer_id)
                                            FROM subscriptions) AS churn_percentage
FROM next_plan
WHERE plan_name = 'trial'
    AND next_plan = 'churn';


-- Q6. What is the number and percentage of customer plans after their initial free trial?
WITH next_plan AS (SELECT s.customer_id,
                          s.start_date,
                          p.plan_name,
                          LEAD(p.plan_name) OVER(PARTITION BY s.customer_id ORDER BY p.plan_id) AS next_plan
                   FROM subscriptions AS s
                       JOIN plans AS p
                           ON s.plan_id = p.plan_id
                   )
SELECT next_plan,
       COUNT(DISTINCT customer_id) AS total_customer_plan,
       100 * CAST(COUNT(DISTINCT customer_id) AS FLOAT) / (SELECT COUNT(DISTINCT customer_id)
                                                           FROM subscriptions) AS percentage
FROM next_plan
WHERE plan_name = 'trial'
    AND next_plan IS NOT NULL
GROUP BY next_plan;


-- Q7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
WITH next_dates AS (SELECT s.customer_id,
                           s.start_date,
                           p.plan_name,
                           p.plan_id,
                           LEAD(s.start_date) OVER(PARTITION BY s.customer_id ORDER BY p.plan_id) AS next_date
                   FROM subscriptions AS s
                       JOIN plans AS p
                           ON s.plan_id = p.plan_id
                   WHERE s.start_date <= '2021-12-31'
                   )
SELECT plan_id,
       plan_name,
       COUNT(*) AS customers,
       CAST(100 * COUNT(*) AS FLOAT) / (SELECT COUNT(DISTINCT customer_id) 
                                        FROM subscriptions) AS conversion_rate
FROM next_dates
WHERE (next_date IS NOT NULL 
    AND (start_date < '2020-12-31' AND next_date > '2020-12-31'))
    OR (next_date IS NULL AND start_date < '2020-12-31')
GROUP BY plan_id, 
         plan_name
ORDER BY plan_id;


-- Q8. How many customers have upgraded to an annual plan in 2020?
SELECT COUNT(DISTINCT s.customer_id) AS total_customers
FROM subscriptions AS s
    JOIN plans AS p
        ON s.plan_id = p.plan_id
WHERE p.plan_name = 'pro annual'
    AND YEAR(s.start_date) = 2020;


-- Q9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
WITH trial_plan AS (SELECT s.customer_id,
                           s.start_date AS trial_date
                    FROM subscriptions AS s
                        JOIN plans AS p
                            ON s.plan_id = p.plan_id
                    WHERE p.plan_name = 'trial'
                    ),
     annual_plan AS (SELECT s.customer_id,
                            s.start_date AS annual_date
                     FROM subscriptions AS s
                         JOIN plans AS p
                             ON s.plan_id = p.plan_id
                     WHERE p.plan_name = 'pro annual'
                    )
SELECT ROUND(AVG(CAST(DATEDIFF(DAY, tp.trial_date, ap.annual_date) AS FLOAT)), 2) AS avg_days
FROM trial_plan AS tp
    JOIN annual_plan AS ap
        ON tp.customer_id = ap.customer_id;


-- Q10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
WITH trial_plan AS (SELECT s.customer_id,
                           s.start_date AS trial_date
                    FROM subscriptions AS s
                        JOIN plans AS p
                            ON s.plan_id = p.plan_id
                    WHERE p.plan_name = 'trial'
                    ),
     annual_plan AS (SELECT s.customer_id,
                            s.start_date AS annual_date
                     FROM subscriptions AS s
                         JOIN plans AS p
                             ON s.plan_id = p.plan_id
                     WHERE p.plan_name = 'pro annual'
                    ),
     day_diff AS (SELECT DATEDIFF(DAY, tp.trial_date, ap.annual_date) AS diff
                  FROM trial_plan AS tp
                      JOIN annual_plan AS ap
                          ON tp.customer_id = ap.customer_id
                  ),
     bucket AS (SELECT *, 
                       FLOOR(diff / 30) AS bucket
                FROM day_diff)

SELECT CONCAT((bucket * 30) + 1, ' - ', (bucket + 1) * 30, ' days ') days,
       COUNT(diff) total
FROM bucket
GROUP BY bucket;


-- Q11.  How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
WITH next_plan AS (SELECT s.customer_id,
                          s.start_date,
                          p.plan_name,
                          LEAD(p.plan_name) OVER(PARTITION BY s.customer_id ORDER BY p.plan_id) AS next_plan
                   FROM subscriptions AS s
                       JOIN plans AS p
                           ON s.plan_id = p.plan_id
                   )
SELECT COUNT(DISTINCT customer_id) AS pro_to_basic_monthly
FROM next_plan
WHERE plan_name = 'pro monthly'
    AND next_plan = 'basic monthly'
    AND YEAR(start_date) = 2020;

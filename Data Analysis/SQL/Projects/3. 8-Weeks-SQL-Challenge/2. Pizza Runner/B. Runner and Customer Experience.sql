/*  
Note: We are in the same session where all temporary tables are created. Therefore I can use all the local temporary tables listed below.
           #customer_orders_temp, 
           #extras_break, 
           #exclusions_break, 
           #runner_orders_temp, 
           #toppings_break

      You can access temporary table queries in the "Data Cleansing and Transformation" file.
*/ 


-- Q1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT DATEPART(WEEK, registration_date) AS registration_week,
       COUNT(runner_id) AS runner_count
FROM runners
GROUP BY DATEPART(WEEK, registration_date);


-- Q2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
WITH times_taken_cte AS (SELECT c.order_id,
                                r.runner_id,
                                DATEDIFF(MINUTE, c.order_time, r.pickup_time) AS pickup_minutes
                         FROM #customer_orders_temp AS c
                             JOIN #runner_orders_temp AS r
                                 ON c.order_id = r.order_id
                         WHERE r.distance <> 0
                         )

SELECT runner_id,
       AVG(pickup_minutes) AS avg_pickup_minutes
FROM times_taken_cte
GROUP BY runner_id;


-- Q3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
SELECT pizza_count,
       AVG(prep_time) AS avg_prep_time
FROM (SELECT c.order_id,
             c.order_time,
             r.pickup_time,
             COUNT(c.pizza_id) AS pizza_count,
             DATEDIFF(MINUTE, c.order_time, r.pickup_time) AS prep_time
      FROM #customer_orders_temp AS c
          JOIN #runner_orders_temp AS r
              ON c.order_id = r.order_id
      WHERE r.duration <> 0
      GROUP BY c.order_id,
               c.order_time,
               r.pickup_time
     ) a
GROUP BY pizza_count;


-- Q4. What was the average distance travelled for each customer?
SELECT c.customer_id,
       ROUND(AVG(r.distance), 2) AS avg_distance
FROM #customer_orders_temp AS c
    JOIN #runner_orders_temp AS r
        ON c.order_id = r.order_id
WHERE r.duration <> 0
GROUP BY c.customer_id;


-- Q5. What was the difference between the longest and shortest delivery times for all orders?
SELECT MAX(duration) - MIN(duration) AS delivery_time_difference
FROM #runner_orders_temp
WHERE duration <> 0;


-- Q6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT r.runner_id,
       c.order_id,
       r.distance,
       r.duration AS duration_min,
       COUNT(c.order_id) AS pizza_count, 
       ROUND(AVG(r.distance/r.duration*60), 1) AS avg_speed
FROM #runner_orders_temp AS r
    JOIN #customer_orders_temp AS c
        ON r.order_id = c.order_id
WHERE r.duration <> 0
GROUP BY r.runner_id,
         c.order_id, 
         r.distance, 
         r.duration;


-- Q7.	What is the successful delivery percentage for each runner?
SELECT runner_id,
       SUM(CASE
               WHEN distance <> 0 THEN 1 
               ELSE 0  
           END) AS delivered,
       COUNT(order_id) AS total,
       ROUND(100 * SUM(CASE 
                           WHEN distance <> 0 THEN 1 
                           ELSE 0 
                       END)/COUNT(*), 0) AS percentage
FROM #runner_orders_temp
GROUP BY runner_id;
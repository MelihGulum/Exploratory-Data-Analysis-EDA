/*  
Note: We are in the same session where all temporary tables are created. Therefore I can use all the local temporary tables listed below.
           #customer_orders_temp, 
           #extras_break, 
           #exclusions_break, 
           #runner_orders_temp, 
           #toppings_break

      You can access temporary table queries in the "Data Cleansing and Transformation" file.
*/ 


-- Q1. How many pizzas were ordered?
SELECT COUNT(*) AS total_pizza_order
FROM #customer_orders_temp;


-- Q2. How many unique customer orders were made?
SELECT COUNT(DISTINCT order_id) AS unique_order_count
FROM #customer_orders_temp;


-- Q3. How many successful orders were delivered by each runner?
SELECT runner_id,
       COUNT(order_id) AS orders
FROM #runner_orders_temp
WHERE duration <> 0
GROUP BY runner_id;


-- Q4. How many of each type of pizza was delivered?
SELECT p.pizza_name,
       COUNT(c.pizza_id) AS delivered
FROM pizza_names AS p
    JOIN #customer_orders_temp AS c
        ON p.pizza_id = c.pizza_id
    JOIN #runner_orders_temp AS r
        ON c.order_id = r.order_id
WHERE duration != 0
GROUP BY p.pizza_name;


-- Q5. How many Vegetarian and Meatlovers were ordered by each customer?
SELECT c.customer_id,
       p.pizza_name,
       COUNT(c.order_id) AS order_count
FROM #customer_orders_temp AS c
    JOIN pizza_names AS p
        ON c.pizza_id = p.pizza_id
GROUP BY c.customer_id, 
         p.pizza_name
ORDER BY 1;


-- Q6. What was the maximum number of pizzas delivered in a single order?
SELECT MAX(pizza_count) AS max_pizza_count
FROM (SELECT c.order_id,
             COUNT(c.order_id) AS pizza_count
      FROM #customer_orders_temp AS c
          JOIN #runner_orders_temp AS r
              ON c.order_id = r.order_id
      WHERE r.duration <> 0
      GROUP BY c.order_id) AS a


-- Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT c.customer_id,
       SUM(CASE
               WHEN c.exclusions <> '' OR c.extras <> '' THEN 1
               ELSE 0
           END) AS at_least_1_change,
       SUM(CASE
               WHEN c.exclusions = '' AND c.extras = '' THEN 1
               ELSE 0
           END) AS no_change
FROM #customer_orders_temp AS c
    JOIN #runner_orders_temp AS r
        ON c.order_id = r.order_id
WHERE r.distance <> 0
GROUP BY c.customer_id;


-- Q8. How many pizzas were delivered that had both exclusions and extras?
SELECT SUM(CASE
               WHEN c.exclusions <> '' AND c.extras <> '' THEN 1
               ELSE 0
           END) AS pizza_count_w_exclusions_extras
FROM #customer_orders_temp AS c
    JOIN #runner_orders_temp AS r
        ON c.order_id = r.order_id
WHERE r.duration != 0;


-- Q9. What was the total volume of pizzas ordered for each hour of the day?
SELECT DATEPART(HOUR, order_time) AS hour_of_day,
       COUNT(order_id) AS pizza_count 
FROM #customer_orders_temp
GROUP BY DATEPART(HOUR, order_time);


-- Q10. What was the volume of orders for each day of the week?
SET DATEFIRST 1; -- The default setting for us_english is 7 (Sunday) 
                 -- sets Monday to the first day of the week for the current connection.

SELECT DATENAME(weekday, order_time) AS week_day,
       COUNT(order_id) AS order_volume, 
       DATEPART(DW, order_time) AS num_week_day
FROM #customer_orders_temp
GROUP BY DATENAME(weekday, order_time),
         DATEPART(DW, order_time)
ORDER BY DATEPART(DW, order_time);
/*  
Note: We are in the same session where all temporary tables are created. Therefore I can use all the local temporary tables listed below.
           #customer_orders_temp, 
           #extras_break, 
           #exclusions_break, 
           #runner_orders_temp, 
           #toppings_break

      You can access temporary table queries in the "Data Cleansing and Transformation" file.
*/ 


-- Q1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and 
--     there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
SELECT SUM(CASE 
               WHEN n.pizza_name = 'Meatlovers' THEN 12
               ELSE 10 
           END) AS money_earned
FROM #customer_orders_temp AS c
    JOIN pizza_names AS n
        ON c.pizza_id = n.pizza_id
    JOIN #runner_orders_temp AS r
        ON c.order_id = r.order_id
WHERE r.duration <> 0;


--Q2.  What if there was an additional $1 charge for any pizza extras?
--         Add cheese is $1 extra
DECLARE @basecost INT
SET @basecost = 138 

SELECT @basecost + SUM(CASE 
                           WHEN p.topping_name = 'Cheese' THEN 2
                           ELSE 1 
                       END) AS updated_money
FROM #extras_break AS eb
    JOIN pizza_toppings AS p
        ON eb.extra_id = p.topping_id;


-- Q3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, 
--     how would you design an additional table for this new dataset - generate a schema for this new table 
--     and insert your own data for ratings for each successful customer order between 1 to 5.
DROP TABLE IF EXISTS rating_orders;
CREATE TABLE rating_orders (
  order_id INTEGER,
  rating INTEGER,
  review VARCHAR(max)
);

INSERT INTO rating_orders
  (order_id, rating, review)
VALUES
  (1, 1, 'Really bad service'),
  (2, 2, null),
  (3, 4, 'Good service'),
  (4, 2, 'Pizza arrived cold and took long'),
  (5, 3, null),
  (7, 3, null),
  (8, 5, 'It was great, good service and fast'),
  (10, 4, 'Not bad');


-- Q4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
--         customer_id
--         order_id
--         runner_id
--         rating
--         order_time
--         pickup_time
--         Time between order and pickup
--         Delivery duration
--         Average speed
--         Total number of pizzas
SELECT c.customer_id,
       c.order_id,
       r.runner_id,
       c.order_time,
       NULLIF(r.pickup_time, 0),
       NULLIF(GREATEST(DATEDIFF(MINUTE, c.order_time, r.pickup_time), 0), 0) AS mins_difference,
       r.duration,
       ROUND(AVG(r.distance / NULLIF(r.duration*60, 0)), 1) AS avg_speed,
       COUNT(c.order_id) AS pizza_count
FROM #customer_orders_temp AS c
    JOIN #runner_orders_temp AS r 
        ON r.order_id = c.order_id
GROUP BY c.customer_id,
         c.order_id,
         r.runner_id,
         c.order_time,
         r.pickup_time, 
         r.duration;


-- Q5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras 
--     and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?
GO
DECLARE @basecost INT
SET @basecost = 138

SELECT @basecost AS revenue,
       SUM(distance) * 0.3 AS runner_paid,
       @basecost - SUM(distance) * 0.3 AS money_left
FROM #runner_orders_temp;
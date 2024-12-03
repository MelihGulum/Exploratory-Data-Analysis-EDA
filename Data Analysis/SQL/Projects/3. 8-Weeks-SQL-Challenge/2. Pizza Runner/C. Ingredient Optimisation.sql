/*  
Note: We are in the same session where all temporary tables are created. Therefore I can use all the local temporary tables listed below.
           #customer_orders_temp, 
           #extras_break, 
           #exclusions_break, 
           #runner_orders_temp, 
           #toppings_break

      You can access temporary table queries in the "Data Cleansing and Transformation" file.
*/ 


-- Q1. What are the standard ingredients for each pizza?
SELECT p.pizza_name,
      STRING_AGG(t.topping_name, ', ') AS ingredients
FROM #toppings_break t
    JOIN pizza_names p 
        ON t.pizza_id = p.pizza_id
GROUP BY p.pizza_name;


-- Q2. What was the most commonly added extra?
SELECT t.topping_name,
       COUNT(*) AS extra_count
FROM #extras_break AS eb
    JOIN pizza_toppings AS t
        ON eb.extra_id = t.topping_id
GROUP BY t.topping_name;


-- Q3. What was the most common exclusion?
SELECT t.topping_name,
       COUNT(*) AS extra_count
FROM #exclusions_break AS eb
    JOIN pizza_toppings AS t
        ON eb.exclusion_id = t.topping_id
GROUP BY t.topping_name
ORDER BY 2 DESC;

	
-- Q4. Generate an order item for each record in the customers_orders table in the format of one of the following:
--         Meat Lovers
--         Meat Lovers - Exclude Beef
--         Meat Lovers - Extra Bacon
--         Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
WITH extras_agg_cte AS (SELECT row_id,
                               'Extra ' + STRING_AGG(t.topping_name, ', ') AS extra_exclude
                        FROM #extras_break AS eb
                            JOIN pizza_toppings AS t
                                ON eb.extra_id = t.topping_id
                        GROUP BY eb.row_id
                        ),
     exclude_agg_cte AS (SELECT row_id,
                               'Exclude ' + STRING_AGG(t.topping_name, ', ') AS extra_exclude
                        FROM #exclusions_break AS eb
                            JOIN pizza_toppings AS t
                                ON eb.exclusion_id = t.topping_id
                        GROUP BY eb.row_id
                       ),
     union_cte AS (SELECT *
                   FROM extras_agg_cte
                   UNION
                   SELECT *
                   FROM exclude_agg_cte)

SELECT c.row_id,
       c.order_id,
       CONCAT_WS(' - ', n.pizza_name, STRING_AGG(u.extra_exclude, ' - ')) AS pizza_info
FROM #customer_orders_temp AS c
    LEFT JOIN union_cte AS u
        ON u.row_id = c.row_id
    JOIN pizza_names AS n
        ON c.pizza_id = n.pizza_id
GROUP BY c.row_id, 
         c.order_id,
         n.pizza_name
ORDER BY 1;


-- Q5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
--         For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"
WITH ingredients_cte AS (SELECT c.*,
                                tb.topping_name,
                                n.pizza_name,
                                CASE
                                    WHEN tb.topping_id IN (SELECT extra_id
                                                           FROM #extras_break AS eb
                                                           WHERE eb.row_id = c.row_id) THEN '2x' + tb.topping_name
                                    ELSE tb.topping_name
                                END AS topping     
                         FROM #customer_orders_temp AS c
                             JOIN #toppings_break AS tb
                                 ON c.pizza_id = tb.pizza_id
                             JOIN pizza_names AS n
                                 ON c.pizza_id = n.pizza_id
                         WHERE tb.topping_id NOT IN (SELECT exclusion_id 
                                                     FROM #exclusions_break eb 
                                                     WHERE c.row_id = eb.row_id)
                         )

SELECT row_id,
       order_id,
       customer_id,
       CONCAT(pizza_name + ': ', STRING_AGG(topping, ', ')) AS ingredients_list
FROM ingredients_cte
GROUP BY row_id,
         order_id,
         customer_id,
         pizza_name;


-- Q6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
WITH frequent_ingredients_cte AS (SELECT c.row_id,
                                         tb.topping_name,
                                  CASE
                                      WHEN tb.topping_id IN (SELECT extra_id 
                                                             FROM #extras_break AS eb 
                                                             WHERE eb.row_id = c.row_id) THEN 2
                                      WHEN tb.topping_id IN (SELECT exclusion_id 
                                                             FROM #exclusions_break eb 
                                                             WHERE eb.row_id = c.row_id) THEN 0
                                      ELSE 1 
                                  END as times_used
                                  FROM #customer_orders_temp AS c
                                      JOIN #toppings_break AS tb
                                          ON c.pizza_id = tb.pizza_id
                                 )

SELECT topping_name,
       SUM(times_used) AS times_used 
FROM frequent_ingredients_cte
GROUP BY topping_name
ORDER BY times_used DESC;

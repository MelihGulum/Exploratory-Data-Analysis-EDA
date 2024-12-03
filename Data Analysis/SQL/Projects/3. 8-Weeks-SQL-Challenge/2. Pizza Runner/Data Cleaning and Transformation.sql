--------------------------------------------------------------------------------------------------------------------------
-- Perprocessing customer_orders Table 
--------------------------------------------------------------------------------------------------------------------------
-- Create a temporary table from customer_orders
-- Remove null values and blank spaces in exlusions and extras columns.

DROP TABLE IF EXISTS #customer_orders_temp;
SELECT ROW_NUMBER() OVER(order by order_id, pizza_id) row_id,
       order_id,
       customer_id,
       pizza_id,
       CASE
           WHEN exclusions IS NULL OR exclusions = 'null' THEN ''
           ELSE TRIM(exclusions)
       END AS exclusions,
       CASE
           WHEN extras IS NULL OR extras = 'null' THEN ''
           ELSE TRIM(extras)
       END AS extras,
       order_time
INTO #customer_orders_temp
FROM customer_orders;


-- Create a new temporary table extras_break to separate extras into multiple rows
DROP TABLE IF EXISTS #extras_break;
SELECT c.row_id,
       TRIM(a.value) AS extra_id
INTO #extras_break 
FROM #customer_orders_temp c
    CROSS APPLY STRING_SPLIT(extras, ',') AS a;


-- Create a new temporary table exclusions_break to separate into exclusions into multiple rows
DROP TABLE IF EXISTS #exclusions_break;
SELECT c.row_id,
       TRIM(a.value) AS exclusion_id
INTO #exclusions_break 
FROM #customer_orders_temp c
    CROSS APPLY STRING_SPLIT(exclusions, ',') AS a;


--------------------------------------------------------------------------------------------------------------------------
-- Perprocessing runner_orders Table 
--------------------------------------------------------------------------------------------------------------------------
/* Create a temporary table from customer_orders
     1. In pickup_time column, remove nulls and replace with blank space ' '.
     2. In distance column, remove "km" and nulls and replace with blank space ' '.
     3. In duration column, remove "minutes", "minute" and nulls and replace with blank space ' '.
     4. In cancellation column, remove NULL and null and and replace with blank space ' '.
     5. Convert the columns to the correct data types.(CAST or ALTER)
            pickup_time to DATETIME.
            distance to FLOAT.
-           duration to INT.
*/

DROP TABLE IF EXISTS #runner_orders_temp;
SELECT order_id,
       runner_id,
       CAST(CASE
                WHEN pickup_time IS NULL OR pickup_time = 'null' THEN ''
                ELSE TRIM(pickup_time)
            END AS DATETIME) AS pickup_time,
       CAST(CASE
                WHEN distance IS NULL OR distance = 'null' THEN ''
                WHEN distance LIKE '%km' THEN TRIM('km' FROM distance)
                ELSE distance
            END AS FLOAT) AS distance,
       CAST(CASE
                WHEN duration IS NULL OR duration = 'null' THEN ''
                WHEN duration LIKE '%mins' THEN TRIM('mins' FROM duration)
                WHEN duration LIKE '%minute' THEN TRIM('minute' FROM duration)
                WHEN duration LIKE '%minutes' THEN TRIM('minutes' FROM duration)
                ELSE duration
            END AS INT) AS duration,
       CASE
           WHEN cancellation IS NULL OR cancellation = 'null' THEN ''
           ELSE TRIM(cancellation)
       END AS cancellation
INTO #runner_orders_temp
FROM runner_orders;


--------------------------------------------------------------------------------------------------------------------------
-- Perprocessing pizza_toppings Table 
--------------------------------------------------------------------------------------------------------------------------
-- Create a new temporary table #toppingsBreak to separate toppings into multiple rows

DROP TABLE IF EXISTS #toppings_break;
SELECT r.pizza_id,
       TRIM(value) AS topping_id,
       pt.topping_name
INTO #toppings_break
FROM pizza_recipes r
    CROSS APPLY STRING_SPLIT(toppings, ',') AS t
    JOIN pizza_toppings pt
        ON TRIM(t.value) = pt.topping_id;

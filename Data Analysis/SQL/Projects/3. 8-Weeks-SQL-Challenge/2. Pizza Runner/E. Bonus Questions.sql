/*  
Note: We are in the same session where all temporary tables are created. Therefore I can use all the local temporary tables listed below.
           #customer_orders_temp, 
           #extras_break, 
           #exclusions_break, 
           #runner_orders_temp, 
           #toppings_break

      You can access temporary table queries in the "Data Cleansing and Transformation" file.
*/ 

-- If Danny wants to expand his range of pizzas - how would this impact the existing data design? 
-- Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?
INSERT INTO pizza_names (pizza_id, pizza_name)
VALUES (3, 'Supreme');

ALTER TABLE pizza_recipes
ALTER COLUMN toppings VARCHAR(50);

INSERT INTO pizza_recipes (pizza_id, toppings)
VALUES (3, '1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12');
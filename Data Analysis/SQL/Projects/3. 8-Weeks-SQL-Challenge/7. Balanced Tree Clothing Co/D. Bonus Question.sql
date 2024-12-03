/* Use a single SQL query to transform the product_hierarchy and product_prices datasets to the product_details table.
   Hint: you may want to consider using a recursive CTE to solve this problem!
*/

SELECT pp.product_id,
       pp.price,
       CONCAT(ph1.level_text, ' ', ph2.level_text, ' - ', ph3.level_text) AS product_name,
       ph2.parent_id AS category_id,
       ph1.parent_id AS segment_id,
       ph1.id AS style_id,
       ph3.level_text AS category_name,
       ph2.level_text AS segment_name,
       ph1.level_text AS style_name
FROM product_hierarchy AS ph1
    JOIN product_hierarchy AS ph2 
        ON ph1.parent_id = ph2.id
    JOIN product_hierarchy AS ph3 
        ON ph3.id = ph2.parent_id
    JOIN product_prices AS pp 
        ON ph1.id = pp.id;
-- Q1. What are the top 3 products by total revenue before discount?
SELECT TOP 3 pd.product_name, 
             SUM(s.qty * s.price) AS revenue
FROM sales AS s
    JOIN product_details AS pd
        ON s.prod_id = pd.product_id
GROUP BY pd.product_name
ORDER BY revenue DESC;


-- Q2. What is the total quantity, revenue and discount for each segment?
SELECT pd.segment_name,
       SUM(s.qty) AS total_quantity,
       SUM(s.qty * s.price) AS total_revenue,
       SUM(s.qty * s.price * s.discount / 100) total_discount
FROM sales AS s
    JOIN product_details AS pd
        ON s.prod_id = pd.product_id
GROUP BY pd.segment_name;


-- Q3. What is the top selling product for each segment?
WITH top_selling_cte AS (SELECT pd.segment_name,
                                pd.product_name,
                                SUM(s.qty) AS total_quantity,
                                DENSE_RANK() OVER (PARTITION BY pd.segment_name ORDER BY SUM(s.qty) DESC) AS rnk
                         FROM sales AS s
                             JOIN product_details AS pd
                                 ON s.prod_id = pd.product_id
                         GROUP BY pd.product_name,
                                  pd.segment_name
                         )
SELECT segment_name,
       product_name,
       total_quantity
FROM top_selling_cte
WHERE rnk = 1;


-- Q4. What is the total quantity, revenue and discount for each category?
SELECT pd.category_name,
       SUM(s.qty) AS total_quantity,
       SUM(s.qty * s.price) AS total_revenue,
       SUM(s.qty * s.price * s.discount / 100) total_discount
FROM sales AS s
    JOIN product_details AS pd
        ON s.prod_id = pd.product_id
GROUP BY pd.category_name;


-- Q5. What is the top selling product for each category?
WITH top_selling_cte AS (SELECT pd.category_name,
                                pd.product_name,
                                SUM(s.qty) AS total_quantity,
                                DENSE_RANK() OVER (PARTITION BY pd.category_name ORDER BY SUM(s.qty) DESC) AS rnk
                         FROM sales AS s
                             JOIN product_details AS pd
                                 ON s.prod_id = pd.product_id
                         GROUP BY pd.product_name,
                                  pd.category_name
                         )
SELECT category_name,
       product_name,
       total_quantity
FROM top_selling_cte
WHERE rnk = 1;


-- Q6. What is the percentage split of revenue by product for each segment?
WITH segment_prod_rev_cte AS (SELECT pd.segment_name,
                                     pd.product_name,
                                     SUM(s.qty * s.price) AS prod_revenue 
                              FROM sales AS s
                                  JOIN product_details AS pd
                                      ON s.prod_id = pd.product_id
                              GROUP BY pd.segment_name,
                                       pd.product_name
                              )
SELECT segment_name,
       product_name,
       CAST(100.0 * prod_revenue / SUM(prod_revenue) OVER (PARTITION BY segment_name) AS DECIMAL(5, 2)) AS pct_segment_prod
FROM segment_prod_rev_cte;


-- Q7. What is the percentage split of revenue by segment for each category?
WITH segment_category_rev_cte AS (SELECT pd.segment_name,
                                         pd.category_name,
                                         SUM(s.qty * s.price) AS category_revenue 
                                  FROM sales AS s
                                      JOIN product_details AS pd
                                          ON s.prod_id = pd.product_id
                                  GROUP BY pd.segment_name,
                                           pd.category_name
                                  )
SELECT segment_name,
       category_name,
       CAST(100.0 * category_revenue / SUM(category_revenue) OVER (PARTITION BY category_name) AS DECIMAL(5, 2)) AS pct_segment_prod
FROM segment_category_rev_cte;


-- Q8. What is the percentage split of total revenue by category?
WITH category_revenue_cte AS (SELECT pd.category_name,
                                    SUM(s.qty * s.price) AS revenue
                              FROM sales AS s
                                  JOIN product_details AS pd 
                                      ON s.prod_id = pd.product_id
                              GROUP BY pd.category_name
                              )
SELECT category_name,
  CAST(100.0 * revenue / SUM(revenue) OVER () AS decimal (5, 2)) AS pct_category
FROM category_revenue_cte;


-- Q9. What is the total transaction “penetration” for each product? 
--    (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
WITH prod_txn_cte AS (SELECT DISTINCT s.prod_id, 
                                      pd.product_name,
                                      COUNT(DISTINCT s.txn_id) AS product_txn,
                                      (SELECT COUNT(DISTINCT txn_id) FROM sales) AS total_txn
                      FROM sales AS s
                          JOIN product_details AS pd 
                              ON s.prod_id = pd.product_id
                      GROUP BY prod_id, pd.product_name
                      )

SELECT *,
       CAST(100.0 * product_txn / total_txn AS decimal(5, 2)) AS pct_penetration
FROM prod_txn_cte;


-- Q10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?
WITH prods_per_txn_cte AS (SELECT s.txn_id,
                                  pd.product_id,
                                  pd.product_name,
                                  s.qty,
                                  COUNT(pd.product_id) OVER (PARTITION BY txn_id) AS cnt
                           FROM sales AS s
                               JOIN product_details AS pd 
                                   ON s.prod_id = pd.product_id
                           ),

     combinations_cte AS (SELECT STRING_AGG(product_id, ', ') WITHIN GROUP (ORDER BY product_id)  AS product_ids,
                                 STRING_AGG(product_name, ', ') WITHIN GROUP (ORDER BY product_id) AS product_names
                          FROM prods_per_txn_cte
                          WHERE cnt = 3
                          GROUP BY txn_id
                          ),

     combination_count_cte AS (SELECT product_ids,
                                      product_names,
                                      COUNT (*) AS common_combinations
                               FROM combinations_cte
                               GROUP BY product_ids, 
                                        product_names
                               )

SELECT product_ids,
       product_names
FROM combination_count_cte
WHERE common_combinations = (SELECT MAX(common_combinations) 
                             FROM combination_count_cte);

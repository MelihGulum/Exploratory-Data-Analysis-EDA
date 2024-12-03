/* Using a single SQL query - create a new output table which has the following details:

       - How many times was each product viewed?
       - How many times was each product added to cart?
       - How many times was each product added to a cart but not purchased (abandoned)?
       - How many times was each product purchased?

   Additionally, create another table which further aggregates the data for the above points 
   but this time for each product category instead of individual products.
  
   Use your 2 new output tables - answer the following questions:

       Q1. Which product had the most views, cart adds and purchases?
       Q2. Which product was most likely to be abandoned?
       Q3. Which product had the highest view to purchase percentage?
       Q4. What is the average conversion rate from view to cart add?
       Q5. What is the average conversion rate from cart add to purchase?
*/

WITH product_info AS (SELECT ph.product_id,
                             ph.page_name AS product_name,
                             ph.product_category,
                             SUM(CASE WHEN ei.event_name = 'Page View' THEN 1 ELSE 0 END) AS views,
                             SUM(CASE WHEN ei.event_name = 'Add To Cart' THEN 1 ELSE 0 END) AS cart_adds
                      FROM events AS e
                          JOIN event_identifier AS ei
                              ON e.event_type = ei.event_type
                          JOIN page_hierarchy AS ph
                              ON e.page_id = ph.page_id
                      WHERE ph.product_category IS NOT NULL
                      GROUP BY ph.product_id,
                               ph.page_name,
                               ph.product_category
                      ),
    product_abandoned AS (SELECT ph.product_id,
                                 ph.page_name AS product_name,
                                 ph.product_category,
                                 COUNT(*) AS abandoned
                          FROM events AS e
                              JOIN event_identifier AS ei 
                                  ON e.event_type = ei.event_type
                              JOIN page_hierarchy AS ph 
                                  ON e.page_id = ph.page_id
                          WHERE ei.event_name = 'Add to cart'
                              AND e.visit_id NOT IN (SELECT e.visit_id
                                                     FROM events AS e
                                                         JOIN event_identifier AS ei 
                                                             ON e.event_type = ei.event_type
                                                     WHERE ei.event_name = 'Purchase'
                                                     )
                          GROUP BY ph.product_id, 
                                   ph.page_name, 
                                   ph.product_category
                          ),
    product_purchased AS (SELECT ph.product_id,
                                 ph.page_name AS product_name,
                                 ph.product_category,
                                 COUNT(*) AS purchases
                          FROM events AS e
                              JOIN event_identifier AS ei 
                                  ON e.event_type = ei.event_type
                              JOIN page_hierarchy AS ph 
                                  ON e.page_id = ph.page_id
                          WHERE ei.event_name = 'Add to cart'
                              AND e.visit_id IN (SELECT e.visit_id
                                                 FROM events AS e
                                                     JOIN event_identifier AS ei 
                                                         ON e.event_type = ei.event_type
                                                 WHERE ei.event_name = 'Purchase'
                                                 )
                          GROUP BY ph.product_id, ph.page_name, ph.product_category
	                  )

SELECT pi.*,
       pa.abandoned,
       pp.purchases
INTO #product_summary
FROM product_info AS pi
    JOIN product_abandoned AS pa 
        ON pi.product_id = pa.product_id
    JOIN product_purchased AS pp 
        ON pi.product_id = pp.product_id;


SELECT *
FROM #product_summary;


-- Q1. Which product had the most views, cart adds and purchases?
SELECT TOP 1 * 
FROM #product_summary
ORDER BY views DESC;

SELECT TOP 1 * 
FROM #product_summary
ORDER BY cart_adds DESC;

SELECT TOP 1 * 
FROM #product_summary
ORDER BY purchases DESC;


-- Q2. Which product was most likely to be abandoned?
SELECT TOP 1 * 
FROM #product_summary
ORDER BY abandoned DESC;


-- Q3. Which product had the highest view to purchase percentage?
SELECT TOP 1 *,
       CAST(100.0 * purchases / views AS DECIMAL(5, 2)) AS pct_purchase_per_view
FROM #product_summary
ORDER BY pct_purchase_per_view DESC;


-- Q4. What is the average conversion rate from view to cart add?
SELECT CAST(AVG(100.0 * cart_adds / views) AS DECIMAL(5, 2)) AS avg_view_to_cart
FROM #product_summary;

-- Q5. What is the average conversion rate from cart add to purchase?
SELECT CAST(AVG(100.0 * purchases / cart_adds) AS DECIMAL(5, 2)) AS avg_cart_to_purchase
FROM #product_summary;
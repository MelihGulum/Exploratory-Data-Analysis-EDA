-- Q1. How many users are there?
SELECT COUNT(DISTINCT [user_id]) AS user_count 
FROM users;


-- Q2. How many cookies does each user have on average?
SELECT CAST(AVG(cookie_count) AS FLOAT)
FROM (SELECT [user_id],
             1.0 * COUNT(cookie_id) AS cookie_count
      FROM users
      GROUP BY [user_id]
      ) AS a


-- Q3. What is the unique number of visits by all users per month?
SELECT MONTH(event_time) AS month_number,
       COUNT(DISTINCT visit_id) AS visit_count
FROM events
GROUP BY MONTH(event_time)
ORDER BY month_number;


-- Q4. What is the number of events for each event type?
SELECT e.event_type,
       ei.event_name,
       COUNT(*) AS event_count
FROM events AS e
    JOIN event_identifier AS ei
        ON e.event_type = ei.event_type
GROUP BY e.event_type,
         ei.event_name
ORDER BY e.event_type;


-- Q5. What is the percentage of visits which have a purchase event?
SELECT CAST(100.0 * COUNT(DISTINCT e.visit_id) 
            / (SELECT COUNT(DISTINCT visit_id) FROM events) AS DECIMAL(5, 2)) AS purchase_pct
FROM events AS e
    JOIN event_identifier AS ei
        ON e.event_type = ei.event_type
WHERE ei.event_name = 'Purchase';


-- Q6. What is the percentage of visits which view the checkout page but do not have a purchase event?
WITH view_checkout AS (SELECT COUNT(e.visit_id) AS visit_count
                       FROM events AS e
                           JOIN event_identifier AS ei
                               ON e.event_type = ei.event_type
                           JOIN page_hierarchy AS ph
                               ON e.page_id = ph.page_id
                       WHERE ei.event_name = 'Page View'
                           AND ph.page_name = 'Checkout'
                       )
SELECT CAST(100 - (100.0 * COUNT(DISTINCT e.visit_id) 
                   / (SELECT visit_count FROM view_checkout)) AS decimal(10, 2)) AS pct_view_checkout
FROM events AS e
    JOIN event_identifier AS ei 
        ON e.event_type = ei.event_type
WHERE ei.event_name = 'Purchase';


-- Q7. What are the top 3 pages by number of views?
SELECT TOP 3 ph.page_name,
             COUNT(*) AS view_count
FROM events AS e
    JOIN page_hierarchy AS ph
        ON e.page_id = ph.page_id
    JOIN event_identifier AS ei
        ON e.event_type = ei.event_type
WHERE ei.event_name = 'Page View'
GROUP BY ph.page_id,
         ph.page_name
ORDER BY view_count DESC;


-- Q8. What is the number of views and cart adds for each product category?
SELECT ph.product_category,
       SUM(CASE WHEN e.event_type = 1 THEN 1 ELSE 0 END) AS page_views,
       SUM(CASE WHEN e.event_type = 2 THEN 1 ELSE 0 END) AS card_adds
FROM events AS e
    JOIN page_hierarchy AS ph
        ON e.page_id = ph.page_id
WHERE ph.product_category IS NOT NULL
GROUP BY ph.product_category
ORDER BY page_views DESC;


-- Q9. What are the top 3 products by purchases?
SELECT TOP 3 ph.product_id,
             ph.page_name,
             ph.product_category,
             COUNT(*) AS purchase_count
FROM events AS e
    JOIN page_hierarchy AS ph
        ON e.page_id = ph.page_id
    JOIN event_identifier AS ei
        ON e.event_type = ei.event_type
WHERE ei.event_name = 'Add to Cart'
    AND e.visit_id IN (SELECT e.visit_id
                       FROM events AS e
                           JOIN event_identifier AS ei 
                               ON e.event_type = ei.event_type
                       WHERE ei.event_name = 'Purchase')
GROUP BY ph.product_id,	
         ph.page_name, 
         ph.product_category
ORDER BY purchase_count DESC;
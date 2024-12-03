/* Generate a table that has 1 single row for every unique visit_id record and has the following columns:
      - user_id
      - visit_id
      - visit_start_time: the earliest event_time for each visit
      - page_views: count of page views for each visit
      - cart_adds: count of product cart add events for each visit
      - purchase: 1/0 flag if a purchase event exists for each visit
      - campaign_name: map the visit to a campaign if the visit_start_time falls between the start_date and end_date
      - impression: count of ad impressions for each visit
      - click: count of ad clicks for each visit
      - (Optional column) cart_products: a comma separated text value with products added to the cart sorted 
            by the order they were added to the cart (hint: use the sequence_number)

   Use the subsequent dataset to generate at least 5 insights for the Clique Bait team - bonus: prepare a single A4 infographic 
       that the team can use for their management reporting sessions, be sure to emphasise the most important points from your findings.
   
   Some ideas you might want to investigate further include:
      - Identifying users who have received impressions during each campaign period and comparing each metric with other users 
            who did not have an impression event
      - Does clicking on an impression lead to higher purchase rates?
      - What is the uplift in purchase rate when comparing users who click on a campaign impression versus users who do not receive an impression? 
            What if we compare them with users who just an impression but do not click?
      - What metrics can you use to quantify the success or failure of each campaign compared to eachother?
*/

SELECT u.user_id,
       e.visit_id,
       MIN(e.event_time) AS visit_start_time,
       SUM(CASE WHEN ei.event_name = 'Page View' THEN 1 ELSE 0 END) AS page_views,
       SUM(CASE WHEN ei.event_name = 'Add to Cart' THEN 1 ELSE 0 END) AS cart_adds,
       SUM(CASE WHEN ei.event_name = 'Purchase' THEN 1 ELSE 0 END) AS purchase,
       c.campaign_name,
       SUM(CASE WHEN ei.event_name = 'Ad Impression' THEN 1 ELSE 0 END) AS impression,
       SUM(CASE WHEN ei.event_name = 'Ad Click' THEN 1 ELSE 0 END) AS click,
       STRING_AGG(CASE WHEN ei.event_name = 'Add to Cart' THEN ph.page_name END, ', ') 
                  WITHIN GROUP (ORDER BY e.sequence_number) AS cart_products
INTO #campaign_summary
FROM events AS e
    JOIN event_identifier AS ei
        ON e.event_type = ei.event_type
    JOIN users AS u
        ON e.cookie_id = u.cookie_id
    JOIN page_hierarchy AS ph
        ON e.page_id = ph.page_id
    LEFT JOIN campaign_identifier AS c
        ON e.event_time BETWEEN c.start_date AND c.end_date
GROUP BY u.user_id,
         e.visit_id,
         c.campaign_name;



/* Identifying users who have received impressions during each campaign period and comparing each metric with other users who did not have an impression event
   Does clicking on an impression lead to higher purchase rates?
   What is the uplift in purchase rate when comparing users who click on a campaign impression versus 
       users who do not receive an impression? What if we compare them with users who have just an impression but do not click?
   What metrics can you use to quantify the success or failure of each campaign compared to each other?
*/


--1. Calculate the number of users in each group

--Number of users who received impressions during campaign periods = 417
SELECT COUNT(DISTINCT user_id) AS received_impressions
FROM #campaign_summary
WHERE impression > 0
AND campaign_name IS NOT NULL;


--Number of users who received impressions but didn't click on ads = 127
SELECT COUNT(DISTINCT user_id) AS received_impressions_not_clicked
FROM #campaign_summary
WHERE impression > 0
    AND click = 0
    AND campaign_name IS NOT NULL;


--Number of users who didn't receive impressions during campaign periods = 56
SELECT COUNT(DISTINCT user_id) AS received_impressions
FROM #campaign_summary
WHERE campaign_name IS NOT NULL
    AND user_id NOT IN (SELECT user_id
                        FROM #campaign_summary
                        WHERE impression > 0
                        )


--2. Calculate the average clicks, average views, average cart adds, and average purchases of each group

--For users who received impressions
DECLARE @received int 
SET @received = 417

SELECT CAST(1.0 * SUM(page_views) / @received AS decimal(10, 1)) AS avg_view,
       CAST(1.0 * SUM(cart_adds) / @received AS decimal(10, 1)) AS avg_cart_adds,
       CAST(1.0 * SUM(purchase) / @received AS decimal(10, 1)) AS avg_purchase
FROM #campaign_summary
WHERE impression > 0
    AND campaign_name IS NOT NULL;


--For users who received impressions but didn't click on ads
DECLARE @received_not_clicked int 
SET @received_not_clicked = 127

SELECT CAST(1.0 * SUM(page_views) / @received_not_clicked AS decimal(10, 1)) AS avg_view,
       CAST(1.0 * SUM(cart_adds) / @received_not_clicked AS decimal(10, 1)) AS avg_cart_adds,
       CAST(1.0 * SUM(purchase) / @received_not_clicked AS decimal(10, 1)) AS avg_purchase
FROM #campaign_summary
WHERE impression > 0
    AND click = 0
    AND campaign_name IS NOT NULL;


--For users who didn't receive impressions 
DECLARE @not_received int 
SET @not_received = 56

SELECT CAST(1.0 * SUM(page_views) / @not_received AS decimal(10, 1)) AS avg_view,
       CAST(1.0 * SUM(cart_adds) / @not_received AS decimal(10, 1)) AS avg_cart_adds,
       CAST(1.0 * SUM(purchase) / @not_received AS decimal(10, 1)) AS avg_purchase
FROM #campaign_summary
WHERE campaign_name IS NOT NULL
    AND user_id NOT IN (SELECT user_id
                        FROM #campaign_summary
                        WHERE impression > 0
                        );

/* 3. Compare the average views, average cart adds and average purchases of users received impressions and not received impressions
   Combine table
        |                             | avg_view | avg_cart_adds | avg_purchase  |
        |-----------------------------|----------|---------------|---------------|
        | Received impressions        | 15.3     | 9             | 1.5           |
        | Not received impressions    | 19.4     | 5.8           | 1.2           |
        | Increase by campaigns       |  No      | Yes           | Yes           |
*/


/* 4. Compare the average purchases of users received impressions and received impressions but not clicked to ads
   Combine table
        |                                      | avg_purchase  |
        |--------------------------------------|---------------|
        | Received impressions                 | 1.5           |
        | Received impressions but not clicked | 0.8           |
        | Increase by clicking to the ads      | Yes           |
*/
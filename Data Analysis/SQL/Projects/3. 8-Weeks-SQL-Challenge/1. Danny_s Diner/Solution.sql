-- Q1. What is the total amount each customer spent at the restaurant?
SELECT customer_id, 
       SUM(price) AS total_price
FROM sales AS s
    JOIN menu AS m
        ON m.product_id = s.product_id
GROUP BY s.customer_id
ORDER BY 2 ASC;


-- Q2. How many days has each customer visited the restaurant?
SELECT customer_id,
       COUNT(DISTINCT order_date) AS total_visit
FROM sales
GROUP BY customer_id;


-- Q3. What was the first item from the menu purchased by each customer?
WITH OrderRank AS (SELECT s.customer_id,
                          s.order_date,
                          m.product_name,
                          DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS rank
                       FROM sales AS s
                           INNER JOIN menu AS m
                               ON s.product_id = m.product_id
                   )

SELECT customer_id,
       product_name
FROM OrderRank
WHERE rank = 1
GROUP BY customer_id, 
         product_name;


-- Q4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT TOP 1 m.product_name,
             COUNT(m.product_name) AS order_count
FROM sales AS s
    JOIN menu AS m
        ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY 2 DESC;


-- Q5. Which item was the most popular for each customer?
SELECT customer_id,
       product_name,
       order_count
FROM (SELECT customer_id,
             product_name,
             COUNT(m.product_name) AS order_count,
             DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(customer_id) DESC) AS rank
      FROM sales AS s
          JOIN menu AS m
              ON s.product_id = m.product_id
      GROUP BY s.customer_id,
               m.product_name
     ) AS a
WHERE rank = 1;


-- Q6. Which item was purchased first by the customer after they became a member?
SELECT TOP 1 WITH TIES m.customer_id,
                       mn.product_name
FROM members AS m
    JOIN sales AS s
        ON m.customer_id = s.customer_id
    JOIN menu AS mn
        ON s.product_id = mn.product_id
WHERE m.join_date < s.order_date
ORDER BY ROW_NUMBER() OVER (PARTITION BY m.customer_id ORDER BY s.order_date);


-- Q7. Which item was purchased just before the customer became a member?
SELECT customer_id, 
       product_name
FROM (SELECT m.customer_id,
             mn.product_name,
             ROW_NUMBER() OVER (PARTITION BY m.customer_id ORDER BY s.order_date DESC) AS rank
      FROM members AS m
          JOIN sales AS s
              ON m.customer_id = s.customer_id
          JOIN menu AS mn
              ON s.product_id = mn.product_id
      WHERE m.join_date > s.order_date
     ) AS a
WHERE rank = 1;


-- Q8. What is the total items and amount spent for each member before they became a member?
SELECT m.customer_id,
       COUNT(m.customer_id) AS total_item,
       SUM(mn.price) AS total_price
FROM members AS m
    JOIN sales AS s
        ON m.customer_id = s.customer_id
    JOIN menu AS mn
        ON mn.product_id = s.product_id
WHERE m.join_date > s.order_date
GROUP BY m.customer_id;


-- Q9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT customer_id, 
       SUM(points) AS total_points
FROM (SELECT s.customer_id,
             CASE 
                 WHEN mn.product_name = 'sushi' THEN (mn.price * 20)
                 ELSE (mn.price * 10)
             END AS points
      FROM sales AS s
          JOIN menu AS mn
              ON s.product_id = mn.product_id
     ) AS a
GROUP BY customer_id;


-- Q10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, 
--      not just sushi - how many points do customer A and B have at the end of January?
SELECT customer_id,
       SUM(points)
FROM (SELECT m.customer_id,
             CASE
                 WHEN mn.product_name = 'sushi' THEN mn.price * 20
                 WHEN s.order_date BETWEEN m.join_date AND DATEADD(DAY, 6, m.join_date) THEN mn.price * 20
                 ELSE (mn.price * 10)
             END AS points
      FROM members AS m
          JOIN sales AS s
              ON m.customer_id = s.customer_id
          JOIN menu AS mn
              ON mn.product_id = s.product_id
      WHERE s.order_date < EOMONTH('2021-01-01')) AS a
GROUP BY customer_id;


-- BONUS Q1: Join All The Things
--           The following questions are related creating basic data tables 
--               that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.
--           Recreate the table with: customer_id, order_date, product_name, price, member (Y/N)
SELECT s.customer_id,
       s.order_date,
       mn.product_name,
       mn.price,
       CASE
           WHEN s.order_date >= m.join_date THEN 'Y'
           ELSE 'N'
       END AS member
FROM sales AS s
    LEFT JOIN members AS m
        ON m.customer_id = s.customer_id
    JOIN menu AS mn
        ON mn.product_id = s.product_id;


-- BONUS Q2: Rank All The Things
--           Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases 
--               so he expects null ranking values for the records when customers are not yet part of the loyalty program.
WITH customer_data AS (SELECT s.customer_id,
                              s.order_date,
                              mn.product_name,
                              mn.price,
                              CASE
                                  WHEN s.order_date >= m.join_date THEN 'Y'
                                  ELSE 'N'
                              END AS member
                       FROM sales AS s
                           LEFT JOIN members AS m
                               ON m.customer_id = s.customer_id
                           JOIN menu AS mn
                               ON mn.product_id = s.product_id
                      )

SELECT *,
       CASE
           WHEN member = 'N' THEN NULL
           ELSE RANK() OVER (PARTITION BY customer_id, member ORDER BY order_date)
       END AS ranking
FROM customer_data;
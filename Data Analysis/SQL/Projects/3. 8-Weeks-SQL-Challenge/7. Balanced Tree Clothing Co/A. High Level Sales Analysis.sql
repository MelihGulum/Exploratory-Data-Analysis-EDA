-- Q1. What was the total quantity sold for all products?
SELECT pd.product_name,
       SUM(s.qty) AS total_quantity
FROM sales AS s
    JOIN product_details AS pd
        ON s.prod_id = pd.product_id
GROUP BY pd.product_name
ORDER BY total_quantity DESC;
       

-- Q2. What is the total generated revenue for all products before discounts?
SELECT pd.product_name,
       SUM(s.qty * s.price) AS total_revenue
FROM sales AS s
    JOIN product_details AS pd
        ON s.prod_id = pd.product_id
GROUP BY pd.product_name
ORDER BY total_revenue DESC;


-- Q3. What was the total discount amount for all products?
SELECT pd.product_name,
       SUM(s.qty * s.price * s.discount / 100) AS total_discount
FROM sales AS s
    JOIN product_details AS pd
        ON s.prod_id = pd.product_id
GROUP BY pd.product_name
ORDER BY total_discount DESC;
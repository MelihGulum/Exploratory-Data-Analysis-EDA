-- Q1. How many unique nodes are there on the Data Bank system?
SELECT COUNT(DISTINCT node_id) AS unique_nodes
FROM customer_nodes;


-- Q2. What is the number of nodes per region?
SELECT r.region_id,
       r.region_name,
       COUNT(DISTINCT node_id) AS unique_nodes,
       COUNT(cn.node_id) AS total_nodes
FROM customer_nodes AS cn
    JOIN regions AS r
        ON r.region_id = cn.region_id
GROUP BY r.region_id,
         r.region_name
ORDER BY 1;


-- Q3. How many customers are allocated to each region?
SELECT r.region_id,
       r.region_name,
       COUNT(DISTINCT cn.customer_id) AS total_customers
FROM customer_nodes AS cn
    JOIN regions AS r
        ON r.region_id = cn.region_id
GROUP BY r.region_id,
         r.region_name
ORDER BY 1;


-- Q4. How many days on average are customers reallocated to a different node?
WITH customer_first_date AS(SELECT customer_id,
                                   node_id,
                                   region_id,
                                   SUM(DATEDIFF(DAY, start_date, end_date)) AS days_in_node
                            FROM customer_nodes
                            WHERE end_date <> '9999-12-31'
                            GROUP BY customer_id,
                                     node_id,
                                     region_id
                            )

SELECT AVG(days_in_node) AS avg_days_in_node
FROM customer_first_date;


-- Q5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?
WITH customer_first_date AS(SELECT customer_id,
                                   node_id,
                                   region_id,
                                   SUM(DATEDIFF(DAY, start_date, end_date)) AS days_in_node
                            FROM customer_nodes
                            WHERE end_date <> '9999-12-31'
                            GROUP BY customer_id,
                                     node_id,
                                     region_id
                            )

SELECT DISTINCT r.region_id,
                rg.region_name,
                PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY r.days_in_node) OVER(PARTITION BY r.region_id) AS median,
                PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY r.days_in_node) OVER(PARTITION BY r.region_id) AS percentile_80,
                PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY r.days_in_node) OVER(PARTITION BY r.region_id) AS percentile_95
FROM customer_first_date AS r
    JOIN regions AS rg 
        ON r.region_id = rg.region_id
WHERE days_in_node IS NOT NULL;

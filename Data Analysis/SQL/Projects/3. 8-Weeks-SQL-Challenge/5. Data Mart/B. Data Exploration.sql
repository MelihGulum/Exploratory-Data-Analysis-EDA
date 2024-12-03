-- Q1. What day of the week is used for each week_date value?
SELECT DISTINCT(DATENAME(WEEKDAY, week_date)) AS week_date_value
FROM clean_weekly_sales;


-- Q2. What range of week numbers are missing from the dataset?
WITH week_no_cte AS (SELECT top 52 
                            ROW_NUMBER() OVER(ORDER BY region) week_no 
                     FROM clean_weekly_sales
                     )

SELECT week_no AS missing_week_numbers
FROM week_no_cte AS w
    LEFT JOIN clean_weekly_sales AS c
        ON w.week_no = c.week_number
WHERE c. week_number IS NULL
ORDER BY week_no;


-- Q3. How many total transactions were there for each year in the dataset?
SELECT calendar_year,
       FORMAT(SUM(transactions), 'N0') total_transactions
FROM clean_weekly_sales
GROUP BY calendar_year
ORDER BY calendar_year;


-- Q4. What is the total sales for each region for each month?
SELECT region,
       month_number,
       SUM(sales) AS total_sales
FROM clean_weekly_sales
GROUP BY region,
         month_number
ORDER BY region, 
         month_number;


-- Q5. What is the total count of transactions for each platform?
SELECT [platform],
       SUM(transactions) AS total_transactions
FROM clean_weekly_sales
GROUP BY [platform];


-- Q6. What is the percentage of sales for Retail vs Shopify for each month?
WITH sales_cte AS (SELECT [platform],
                          month_number,
                          calendar_year,
                          SUM(sales) AS total_sales
                   FROM clean_weekly_sales
                   GROUP BY [platform],
                            month_number,
                            calendar_year
                   )
SELECT calendar_year,
       month_number,
       CAST(100.0 * MAX(CASE 
                            WHEN platform = 'Retail' THEN total_sales 
                            ELSE NULL END)
	        / SUM(total_sales) AS decimal(5, 2)) AS pct_retail,
       CAST(100.0 * MAX(CASE 
                            WHEN platform = 'Shopify' THEN total_sales 
                            ELSE NULL END)
	        / SUM(total_sales) AS decimal(5, 2)) AS pct_shopify
FROM sales_cte
GROUP BY calendar_year,
         month_number
ORDER BY calendar_year,
         month_number;


-- Q7. What is the percentage of sales by demographic for each year in the dataset?
WITH sales_by_demographic AS (SELECT calendar_year,
                                     demographic,
                                     CAST(SUM(sales) AS FLOAT) AS total_sales
                              FROM clean_weekly_sales
                              GROUP BY calendar_year,
                                       demographic
                              )
SELECT calendar_year, 
       CAST(100 * MAX (CASE 
                           WHEN demographic = 'Couples' THEN total_sales 
                           ELSE NULL END)
            / SUM(total_sales) AS DECIMAL(5 , 2)) AS couples_percentage,
       CAST(100 * MAX (CASE 
                           WHEN demographic = 'Families' THEN total_sales 
                           ELSE NULL END)
            / SUM(total_sales) AS DECIMAL(5, 2)) AS families_percentage,
       CAST(100 * MAX (CASE 
                           WHEN demographic = 'unknown' THEN total_sales 
                           ELSE NULL END)
            / SUM(total_sales) AS DECIMAL(5,2)) AS unknown_percentage
FROM sales_by_demographic
GROUP BY calendar_year;


-- Q8. Which age_band and demographic values contribute the most to Retail sales?
SELECT age_band,
       demographic, 
       SUM(sales) AS total_sales,
       ROUND(100 * CAST(SUM(sales) AS FLOAT) / SUM(SUM(sales)) OVER(), 2) AS contribute_percent
FROM clean_weekly_sales
WHERE [platform] = 'Retail'
GROUP BY age_band,
         demographic
ORDER BY contribute_percent DESC;


-- Q9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? 
--     If not - how would you calculate it instead?
SELECT calendar_year,
       [platform],
       ROUND(AVG(avg_transaction), 0) AS avg_transaction_row,
       SUM(sales) / SUM(transactions) AS avg_transcastion_group
FROM clean_weekly_sales
GROUP BY [platform],
         calendar_year
ORDER BY calendar_year,
         [platform];

/* What's the difference between avg_transaction_row and avg_transaction_group?

       - avg_transaction_row is the average transaction of each individual row in the dataset
       - avg_transaction_group is the average transaction of each platform in each calendar_year

   The average transaction size for each year by platform is actually avg_transaction_group.
*/
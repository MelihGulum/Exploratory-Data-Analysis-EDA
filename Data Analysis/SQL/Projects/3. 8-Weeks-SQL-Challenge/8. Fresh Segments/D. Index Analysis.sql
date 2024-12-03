-- The index_value is a measure which can be used to reverse calculate the average composition for Fresh Segments’ clients.
-- Average composition can be calculated by dividing the composition column by the index_value column rounded to 2 decimal places.


-- Q1. What is the top 10 interests by the average composition for each month?
WITH cte_avg_composition_rank AS (SELECT metrics.interest_id,
                                         map.interest_name,
                                         metrics.month_year,
                                         ROUND(metrics.composition / metrics.index_value, 2) AS avg_composition,
                                         DENSE_RANK() OVER(PARTITION BY metrics.month_year ORDER BY metrics.composition / metrics.index_value DESC) AS rnk
                                  FROM interest_metrics AS  metrics
                                      JOIN interest_map AS map 
                                          ON metrics.interest_id = map.id
                                  WHERE metrics.month_year IS NOT NULL
                                  ) 
SELECT *
FROM cte_avg_composition_rank
WHERE rnk <= 10; 

-- Q2. For all of these top 10 interests - which interest appears the most often?
WITH cte_avg_composition_rank AS (SELECT metrics.interest_id,
                                         map.interest_name,
                                         metrics.month_year,
                                         ROUND(metrics.composition / metrics.index_value, 2) AS avg_composition,
                                         DENSE_RANK() OVER(PARTITION BY metrics.month_year ORDER BY metrics.composition / metrics.index_value DESC) AS rnk
                                  FROM interest_metrics AS  metrics
                                      JOIN interest_map AS map 
                                          ON metrics.interest_id = map.id
                                  WHERE metrics.month_year IS NOT NULL
                                  ),
    cte_frequent_interests AS (SELECT interest_id,
                                      interest_name,
                                      COUNT(*) AS freq
                               FROM cte_avg_composition_rank
                               WHERE rnk <= 10	
                               GROUP BY interest_id, interest_name
                               )

SELECT * 
FROM cte_frequent_interests
WHERE freq IN (SELECT MAX(freq) 
               FROM cte_frequent_interests);

-- Q3. What is the average of the average composition for the top 10 interests for each month?
WITH cte_avg_composition_rank AS (SELECT metrics.interest_id,
                                         map.interest_name,
                                         metrics.month_year,
                                         ROUND(metrics.composition / metrics.index_value, 2) AS avg_composition,
                                         DENSE_RANK() OVER(PARTITION BY metrics.month_year ORDER BY metrics.composition / metrics.index_value DESC) AS rnk
                                  FROM interest_metrics AS  metrics
                                      JOIN interest_map AS map 
                                          ON metrics.interest_id = map.id
                                  WHERE metrics.month_year IS NOT NULL
                                  ) 
SELECT month_year,
      AVG(avg_composition) AS avg_of_avg_composition
FROM cte_avg_composition_rank
WHERE rnk <= 10 
GROUP BY month_year;


-- Q4. What is the 3 month rolling average of the max average composition value 
--     from September 2018 to August 2019 and include the previous top ranking interests in the same output shown below.

/* Required output for question 4:

   | month_year | interest_name                 | max_index_composition | 3_month_moving_avg | 1_month_ago                       | 2_months_ago                       |
   |------------|-------------------------------|-----------------------|--------------------|-----------------------------------|------------------------------------|
   | 2018-09-01 | Work Comes First Travelers    | 8.26                  | 7.61               | Las Vegas Trip Planners: 7.21     | Las Vegas Trip Planners: 7.36      |
   | 2018-10-01 | Work Comes First Travelers    | 9.14                  | 8.20               | Work Comes First Travelers: 8.26  | Las Vegas Trip Planners: 7.21      |
   | 2018-11-01 | Work Comes First Travelers    | 8.28                  | 8.56               | Work Comes First Travelers: 9.14  | Work Comes First Travelers: 8.26   |
   | 2018-12-01 | Work Comes First Travelers    | 8.31                  | 8.58               | Work Comes First Travelers: 8.28  | Work Comes First Travelers: 9.14   |
   | 2019-01-01 | Work Comes First Travelers    | 7.66                  | 8.08               | Work Comes First Travelers: 8.31  | Work Comes First Travelers: 8.28   |
   | 2019-02-01 | Work Comes First Travelers    | 7.66                  | 7.88               | Work Comes First Travelers: 7.66  | Work Comes First Travelers: 8.31   |
   | 2019-03-01 | Alabama Trip Planners         | 6.54                  | 7.29               | Work Comes First Travelers: 7.66  | Work Comes First Travelers: 7.66   |
   | 2019-04-01 | Solar Energy Researchers      | 6.28                  | 6.83               | Alabama Trip Planners: 6.54       | Work Comes First Travelers: 7.66   |
   | 2019-05-01 | Readers of Honduran Content   | 4.41                  | 5.74               | Solar Energy Researchers: 6.28    | Alabama Trip Planners: 6.54        |
   | 2019-06-01 | Las Vegas Trip Planners       | 2.77                  | 4.49               | Readers of Honduran Content: 4.41 | Solar Energy Researchers: 6.28     |
   | 2019-07-01 | Las Vegas Trip Planners       | 2.82                  | 3.33               | Las Vegas Trip Planners: 2.77     | Readers of Honduran Content: 4.41  |
   | 2019-08-01 | Cosmetics and Beauty Shoppers | 2.73                  | 2.77               | Las Vegas Trip Planners: 2.82     | Las Vegas Trip Planners: 2.77      |
*/
WITH cte_avg_compositions AS (SELECT month_year,
                                     interest_id,
                                     ROUND(composition / index_value, 2) AS avg_comp,
                                     ROUND(MAX(composition / index_value) OVER(PARTITION BY month_year), 2) AS max_avg_comp
                              FROM interest_metrics
                              WHERE month_year IS NOT NULL
                              ),
     cte_max_avg_compositions AS (SELECT *
                                  FROM cte_avg_compositions
                                  WHERE avg_comp = max_avg_comp
                                  ),
     cte_moving_avg_compositions AS (SELECT mac.month_year,
                                            im.interest_name,
                                            mac.max_avg_comp AS max_index_composition,
                                            ROUND(AVG(mac.max_avg_comp) OVER(ORDER BY mac.month_year 
	                                              ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS '3_month_moving_avg',
                                            LAG(im.interest_name) OVER (ORDER BY mac.month_year) + ': ' +
	                                            CAST(LAG(mac.max_avg_comp) OVER (ORDER BY mac.month_year) AS VARCHAR(4)) AS '1_month_ago',
                                            LAG(im.interest_name, 2) OVER (ORDER BY mac.month_year) + ': ' +
	                                            CAST(LAG(mac.max_avg_comp, 2) OVER (ORDER BY mac.month_year) AS VARCHAR(4)) AS '2_month_ago'
                                     FROM cte_max_avg_compositions AS mac 
                                         JOIN interest_map AS im 
                                             ON mac.interest_id = im.id
                                     )

SELECT *
FROM cte_moving_avg_compositions
WHERE month_year BETWEEN '2018-09-01' AND '2019-08-01';


-- Q5. Provide a possible reason why the max average composition might change from month to month? 
--     Could it signal something is not quite right with the overall business model for Fresh Segments?

/* This means  that Fresh Segments's business heavily relied on travel-related services. 
   Other products and services didn't receive much interest from customers.
*/
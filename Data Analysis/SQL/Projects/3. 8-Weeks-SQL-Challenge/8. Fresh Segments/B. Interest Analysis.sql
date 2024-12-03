-- Q1. Which interests have been present in all month_year dates in our dataset?

-- First take a look how many unique "month_year" in the dataset.
SELECT COUNT(DISTINCT month_year) AS unique_month_year_count, 
       COUNT(DISTINCT interest_id) AS unique_interest_id_count
FROM interest_metrics;


-- There are 14 distinct month_year dates.
-- Filter all interest_id that have the count 14.
SELECT interest_id,
       COUNT(month_year) AS month_year_count
FROM interest_metrics
GROUP BY interest_id
HAVING COUNT(month_year) = 14;


-- Q2. Using this same total_months measure - calculate the cumulative percentage of all records starting at 14 months  
--     - which total_months value passes the 90% cumulative percentage value?
WITH cte_interest_months AS (SELECT interest_id,
                                    COUNT(DISTINCT month_year) AS total_months
                             FROM interest_metrics
                             WHERE interest_id IS NOT NULL
                             GROUP BY interest_id
                             ),
     cte_interest_counts AS (SELECT total_months,
                                    COUNT(DISTINCT interest_id) AS interest_count
                             FROM cte_interest_months
                             GROUP BY total_months
                             )

SELECT total_months,
       interest_count,
       CAST(100.0 * SUM(interest_count) OVER (ORDER BY total_months DESC) 
            / (SUM(interest_count) OVER ()) AS DECIMAL(5, 2)) AS cumulative_percentage
FROM cte_interest_counts;


-- Q3. If we were to remove all interest_id values which are lower than the total_months value we found in the previous question 
--     - how many total data points would we be removing?
WITH cte_interest_months AS (SELECT interest_id,
                                    COUNT(DISTINCT month_year) AS total_months
                             FROM interest_metrics
                             WHERE interest_id IS NOT NULL
                             GROUP BY interest_id
                             )

SELECT COUNT(interest_id) AS interests,
       COUNT(DISTINCT interest_id) AS unique_interests
FROM interest_metrics
WHERE interest_id IN (SELECT interest_id 
                      FROM cte_interest_months
                      WHERE total_months < 6);


-- Q4. Does this decision make sense to remove these data points from a business perspective? 
--     Use an example where there are all 14 months present to a removed interest example for your arguments 
--     - think about what it means to have less months present from a segment perspective.
SELECT MIN(month_year) AS first_date,
       MAX(month_year) AS last_date
FROM interest_metrics;

SELECT month_year,
       COUNT(DISTINCT interest_id) interest_count,
       MIN(ranking) AS highest_rank,
       MAX(composition) AS composition_max,
       MAX(index_value) AS index_max
FROM interest_metrics metrics
WHERE interest_id IN (SELECT interest_id
                      FROM interest_metrics
                      WHERE interest_id IS NOT NULL
                      GROUP BY interest_id
                      HAVING COUNT(DISTINCT month_year) = 14)
GROUP BY month_year
ORDER BY month_year, 
         highest_rank;


--When total_months = 1
SELECT month_year,
       COUNT(DISTINCT interest_id) interest_count,
       MIN(ranking) AS highest_rank,
       MAX(composition) AS composition_max,
       MAX(index_value) AS index_max
FROM interest_metrics metrics
WHERE interest_id IN (SELECT interest_id
                      FROM interest_metrics
                      WHERE interest_id IS NOT NULL
                      GROUP BY interest_id
                      HAVING COUNT(DISTINCT month_year) = 1)
GROUP BY month_year
ORDER BY month_year, highest_rank;


-- Q5. After removing these interests - how many unique interests are there for each month?
SELECT *
INTO #interest_metrics_edited
FROM interest_metrics
WHERE interest_id NOT IN (SELECT interest_id
                          FROM interest_metrics
                          WHERE interest_id IS NOT NULL
                          GROUP BY interest_id
                          HAVING COUNT(DISTINCT month_year) < 6);

SELECT COUNT(interest_id) AS all_interests,
       COUNT(DISTINCT interest_id) AS unique_interests
FROM #interest_metrics_edited;


-- To find the number of unique interests for each month after removing step above:
SELECT month_year,
       COUNT(DISTINCT interest_id) AS unique_interests
FROM #interest_metrics_edited
WHERE month_year IS NOT NULL
GROUP BY month_year
ORDER BY month_year;

-- Q1. Update the fresh_segments.interest_metrics table by modifying the month_year column to be a date data type with the start of the month
UPDATE interest_metrics
SET month_year  = CONVERT(DATE, '01-' + CONVERT(VARCHAR(10), month_year), 105);


-- Q2. What is count of records in the fresh_segments.interest_metrics 
--     for each month_year value sorted in chronological order (earliest to latest) with the null values appearing first?
SELECT month_year,
       COUNT(*) AS count_record
FROM interest_metrics
GROUP BY month_year
ORDER BY month_year;


-- Q3. What do you think we should do with these null values in the fresh_segments.interest_metrics?

-- The NULL values appers in "_month", "_year", "month_year", "interest_id" with the exception of interest_id 21246.
SELECT *
FROM interest_metrics
WHERE month_year IS NULL;

-- Before take any action (drop, fill...), it would be useful to check the percantage of NULL values
SELECT CAST(100.0 * COUNT(*) 
            / (SELECT COUNT(*) FROM interest_metrics) AS DECIMAL(5, 2)) AS pct_null
FROM interest_metrics
WHERE month_year IS NULL;

-- The corresponding values in composition, index_value, ranking, and percentile_ranking 
--     fields are not meaningful without the specific information on interest_id and dates.
-- Let's drop all null values (1193).
DELETE FROM interest_metrics
WHERE interest_id IS NULL;


-- Q4. How many interest_id values exist in the fresh_segments.interest_metrics table but not in the fresh_segments.interest_map table? 
--     What about the other way around?
SELECT COUNT(DISTINCT map.id) AS map_id_count,
       COUNT(DISTINCT metrics.interest_id) AS metrics_id_count,
       SUM(CASE WHEN map.id IS NULL THEN 1 END) AS not_in_metric,
       SUM(CASE WHEN metrics.interest_id is NULL THEN 1 END) AS not_in_map
FROM interest_metrics AS metrics
    FULL JOIN interest_map AS map
        ON metrics.interest_id = map.id;


-- Q5. Summarise the id values in the fresh_segments.interest_map by its total record count in this table
SELECT COUNT(*)
FROM interest_map;


-- Q6. What sort of table join should we perform for our analysis and why? 
--     Check your logic by checking the rows where interest_id = 21246 in your joined output 
--     and include all columns from fresh_segments.interest_metrics and all columns from fresh_segments.interest_map except from the id column.
SELECT *
FROM interest_map AS map
    JOIN interest_metrics AS metrics
        ON map.id = metrics.interest_id
WHERE interest_id = 21246
    AND _year IS NOT NULL;


-- Q7. Are there any records in your joined table where the month_year value is before the created_at value from the fresh_segments.interest_map table? 
--     Do you think these values are valid and why?

-- There are 188 rows where the "month_year" date is before the "created_at" date. 
SELECT COUNT(*) AS cnt
FROM interest_metrics AS metrics
    JOIN interest_map map
        ON metrics.interest_id = map.id
WHERE metrics.month_year < CAST(map.created_at AS DATE);

-- However, it may be the case that those 188 created_at values were created at the same month as month_year values. 
--     The reason is because month_year values were set on the first date of the month by default in Question 1
-- Running another test to see whether date in month_year and created_at are in the same month.
SELECT COUNT(*) AS cnt
FROM interest_metrics AS metrics
    JOIN interest_map AS map
        ON map.id = metrics.interest_id
WHERE metrics.month_year < CAST(DATEADD(DAY, -DAY(map.created_at) + 1, map.created_at) AS DATE);

-- Seems like all the records' dates are in the same month, hence we will consider the records as valid.
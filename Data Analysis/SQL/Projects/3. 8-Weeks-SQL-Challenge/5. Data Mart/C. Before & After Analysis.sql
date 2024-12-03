/* This technique is usually used when we inspect an important event and want to inspect the impact before and after a certain point in time.
   Taking the week_date value of 2020-06-15 as the baseline week where the Data Mart sustainable packaging changes came into effect.
   We would include all week_date values for 2020-06-15 as the start of the period after the change and the previous week_date values would be before
   
   Using this analysis approach - answer the following questions:
       Q1. What is the total sales for the 4 weeks before and after 2020-06-15? 
           What is the growth or reduction rate in actual values and percentage of sales?
       Q2. What about the entire 12 weeks before and after?
       Q3. How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?
*/


-- Q1. What is the total sales for the 4 weeks before and after 2020-06-15? 
--     What is the growth or reduction rate in actual values and percentage of sales?

-- Find the week_number of '2020-06-15' (@intWeekNum = 25)
DECLARE @intWeekNum INT = (SELECT DISTINCT(week_number)
                           FROM clean_weekly_sales
                           WHERE week_date = '2020-06-15');

WITH salesChanges AS (SELECT SUM(CASE WHEN week_number BETWEEN  @intWeekNum - 4 AND @intWeekNum - 1 THEN sales END) before_changes, 
                             SUM(CASE WHEN week_number BETWEEN  @intWeekNum AND @intWeekNum + 3 THEN sales END) after_changes
                      FROM clean_weekly_sales
                      WHERE calendar_year = 2020
                      )
SELECT *,
       (after_changes - before_changes) AS change_variance,
       CAST((100.0 * (after_changes - before_changes) / before_changes) AS DECIMAL(5, 2)) AS pct_change
FROM salesChanges;


-- Q2. What about the entire 12 weeks before and after?
DECLARE @intWeekNum INT = (SELECT DISTINCT(week_number)
                           FROM clean_weekly_sales
                           WHERE week_date = '2020-06-15');

WITH salesChanges AS (SELECT SUM(CASE WHEN week_number BETWEEN  @intWeekNum - 12 AND @intWeekNum - 1 THEN sales END) before_changes, 
                             SUM(CASE WHEN week_number BETWEEN  @intWeekNum AND @intWeekNum + 11 THEN sales END) after_changes
                      FROM clean_weekly_sales
                      WHERE calendar_year = 2020
                      )
SELECT *,
       (after_changes - before_changes) AS change_variance,
       CAST((100.0 * (after_changes - before_changes) / before_changes) AS DECIMAL(5, 2)) AS pct_change
FROM salesChanges;
       
	   
-- Q3. How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

-- Part 1: 4 weeks before and after
DECLARE @intWeekNum INT = (SELECT DISTINCT(week_number)
                           FROM clean_weekly_sales
                           WHERE week_date = '2020-06-15');

WITH salesChanges AS (SELECT calendar_year,
                             SUM(CASE WHEN week_number BETWEEN  @intWeekNum - 3 AND @intWeekNum - 1 THEN sales END) before_changes, 
                             SUM(CASE WHEN week_number BETWEEN  @intWeekNum AND @intWeekNum + 3 THEN sales END) after_changes
                      FROM clean_weekly_sales
                      GROUP BY calendar_year
                      )
SELECT *,
       (after_changes - before_changes) AS change_variance,
       CAST((100.0 * (after_changes - before_changes) / before_changes) AS DECIMAL(5, 2)) AS pct_change
FROM salesChanges;


-- Part 2: 12 weeks before and after
DECLARE @intWeekNum INT = (SELECT DISTINCT(week_number)
                           FROM clean_weekly_sales
                           WHERE week_date = '2020-06-15');

WITH salesChanges AS (SELECT calendar_year,
                             SUM(CASE WHEN week_number BETWEEN  @intWeekNum - 12 AND @intWeekNum - 1 THEN sales END) before_changes, 
                             SUM(CASE WHEN week_number BETWEEN  @intWeekNum AND @intWeekNum + 11 THEN sales END) after_changes
                      FROM clean_weekly_sales
                      GROUP BY calendar_year
                      )
SELECT *,
       (after_changes - before_changes) AS change_variance,
       CAST((100.0 * (after_changes - before_changes) / before_changes) AS DECIMAL(5, 2)) AS pct_change
FROM salesChanges;
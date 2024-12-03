/* Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?
       - region
       - platform
       - age_band
       - demographic
       - customer_type

Do you have any further recommendations for Danny’s team at Data Mart or any interesting insights based off this analysis?
*/

-- Sales changes by region
-- Find the week_number of '2020-06-15' (@intWeekNum = 25)
DECLARE @intWeekNum INT = (SELECT DISTINCT(week_number)
                           FROM clean_weekly_sales
                           WHERE week_date = '2020-06-15'
                           );

WITH regionChanges AS (SELECT region,
                              SUM(CASE WHEN week_number BETWEEN @intWeekNum - 12 AND @intWeekNum - 1 THEN sales END) AS before_changes,
                              SUM(CASE WHEN week_number BETWEEN @intWeekNum AND @intWeekNum + 11 THEN sales END) AS after_changes
                       FROM clean_weekly_sales
                       WHERE calendar_year = 2020
                       GROUP BY region
                       )
SELECT *,
       (after_changes - before_changes) AS change_difference,
       CAST(100.0 * (after_changes - before_changes) / before_changes AS decimal(5, 2)) AS pct_change
FROM regionChanges
ORDER BY pct_change DESC;

/* After the change, sales in all countries except 'Europe' decreased.
   The highest negative impact was in 'Asia' with -3.26%
   Only 'Europe' saw a significant increase of 4.73%.
*/


-- Sales changes by platform
DECLARE @intWeekNum INT = (SELECT DISTINCT(week_number)
                           FROM clean_weekly_sales
                           WHERE week_date = '2020-06-15'
                           );

WITH platformChanges AS (SELECT [platform],
                               SUM(CASE WHEN week_number BETWEEN @intWeekNum - 12 AND @intWeekNum - 1 THEN sales END) AS before_changes,
                               SUM(CASE WHEN week_number BETWEEN @intWeekNum AND @intWeekNum + 11 THEN sales END) AS after_changes
                       FROM clean_weekly_sales
                       WHERE calendar_year = 2020
                       GROUP BY [platform]
                       )
SELECT *,
       (after_changes - before_changes) AS change_difference,
       CAST(100.0 * (after_changes - before_changes) / before_changes AS decimal(5, 2)) AS pct_change
FROM platformChanges
ORDER BY pct_change DESC;

/* 'Shopify' stores saw a 7.18% increase in sales while 'Retail' stores decreased by -2.43%. */


-- Sales changes by age_band
DECLARE @intWeekNum INT = (SELECT DISTINCT(week_number)
                           FROM clean_weekly_sales
                           WHERE week_date = '2020-06-15'
                           );

WITH ageBandChanges AS (SELECT age_band,
                               SUM(CASE WHEN week_number BETWEEN @intWeekNum - 12 AND @intWeekNum - 1 THEN sales END) AS before_changes,
                               SUM(CASE WHEN week_number BETWEEN @intWeekNum AND @intWeekNum + 11 THEN sales END) AS after_changes
                        FROM clean_weekly_sales
                        WHERE calendar_year = 2020
                        GROUP BY age_band
                        )
SELECT *,
       (after_changes - before_changes) AS change_difference,
       CAST(100.0 * (after_changes - before_changes) / before_changes AS decimal(5, 2)) AS pct_change
FROM ageBandChanges
ORDER BY pct_change DESC;

/* Sales decreased across the age band.
   'Middle Aged' band has more negative impact than 'Retirees' band.
*/


-- Sales changes by demographic
DECLARE @intWeekNum INT = (SELECT DISTINCT(week_number)
                           FROM clean_weekly_sales
                           WHERE week_date = '2020-06-15'
                           );

WITH demographicChanges AS (SELECT demographic,
                                   SUM(CASE WHEN week_number BETWEEN @intWeekNum - 12 AND @intWeekNum - 1 THEN sales END) AS before_changes,
                                   SUM(CASE WHEN week_number BETWEEN @intWeekNum AND @intWeekNum + 11 THEN sales END) AS after_changes
                            FROM clean_weekly_sales
                            WHERE calendar_year = 2020
                            GROUP BY demographic
                            )
SELECT *,
       (after_changes - before_changes) AS change_difference,
       CAST(100.0 * (after_changes - before_changes) / before_changes AS decimal(5, 2)) AS pct_change
FROM demographicChanges
ORDER BY pct_change DESC;

/* Sales decreased across the demographics. */


-- Sales changes by customer_type
DECLARE @intWeekNum INT = (SELECT DISTINCT(week_number)
                           FROM clean_weekly_sales
                           WHERE week_date = '2020-06-15'
                           );

WITH demographicChanges AS (SELECT customer_type,
                                   SUM(CASE WHEN week_number BETWEEN @intWeekNum - 12 AND @intWeekNum - 1 THEN sales END) AS before_changes,
                                   SUM(CASE WHEN week_number BETWEEN @intWeekNum AND @intWeekNum + 11 THEN sales END) AS after_changes
                            FROM clean_weekly_sales
                            WHERE calendar_year = 2020
                            GROUP BY customer_type
                            )
SELECT *,
       (after_changes - before_changes) AS change_difference,
       CAST(100.0 * (after_changes - before_changes) / before_changes AS decimal(5, 2)) AS pct_change
FROM demographicChanges
ORDER BY pct_change DESC;

/* The sales for 'Existing' and 'Guest' customers decreased. On the other hand 'New' customers increased.
*/


-- Sales changes by all of the business areas
DECLARE @intWeekNum INT = (SELECT DISTINCT(week_number)
                           FROM clean_weekly_sales
                           WHERE week_date = '2020-06-15'
                           );

WITH demographicChanges AS (SELECT region, 
                                   [platform], 
                                   age_band, 
                                   demographic, 
                                   customer_type,
                                   SUM(CASE WHEN week_number BETWEEN @intWeekNum - 12 AND @intWeekNum - 1 THEN sales END) AS before_changes,
                                   SUM(CASE WHEN week_number BETWEEN @intWeekNum AND @intWeekNum + 11 THEN sales END) AS after_changes
                            FROM clean_weekly_sales
                            WHERE calendar_year = 2020
                            GROUP BY region, 
                                     [platform], 
                                     age_band, 
                                     demographic, 
                                     customer_type
                            )
SELECT *,
       (after_changes - before_changes) AS change_difference,
       CAST(100.0 * (after_changes - before_changes) / before_changes AS decimal(5, 2)) AS pct_change
FROM demographicChanges
ORDER BY pct_change DESC;


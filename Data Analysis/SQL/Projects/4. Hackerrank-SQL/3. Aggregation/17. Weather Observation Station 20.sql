/* The STATION table is described as follows:

		+-------------+------------+
		| Field       |   Type     |
		+-------------+------------+
		| ID          | INTEGER    |
		| CITY        | VARCHAR(21)|
		| STATE       | VARCHAR(2) |
		| LAT_N       | NUMERIC    |
		| LONG_W      | NUMERIC    |
		+-------------+------------+

    A median is defined as a number separating the higher half of a data set from the lower half. 
    Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places. */

SELECT TOP 1 CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY lat_n) OVER() AS DECIMAL(10, 4))
FROM station
ORDER BY lat_n;
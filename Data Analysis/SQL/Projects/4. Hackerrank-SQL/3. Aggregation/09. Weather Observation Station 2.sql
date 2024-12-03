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

    Query the following two values from the STATION table:
    1. The sum of all values in LAT_N rounded to a scale of 2 decimal places.
    2. The sum of all values in LONG_W rounded to a scale of 2 decimal places. */

-- MySQL
SELECT ROUND(SUM(lat_n), 2), 
       ROUND(SUM(long_w), 2)
FROM station;

-- MS SQL Server
SELECT CAST(SUM(lat_n) AS DECIMAL(10, 2)),
       CAST(SUM(long_w) AS DECIMAL(10, 2))
FROM station;
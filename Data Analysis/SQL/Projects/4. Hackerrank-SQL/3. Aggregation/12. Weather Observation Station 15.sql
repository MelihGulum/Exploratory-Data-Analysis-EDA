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

    Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. 
    Round your answer to 4 decimal places. */

-- MySQL
SELECT ROUND(long_w,4)
FROM station
WHERE lat_n = (SELECT MAX(lat_n)
              FROM station
              WHERE lat_n < 137.2345);

-- MS SQL Server
SELECT CAST(long_w AS DECIMAL(10,4))
FROM station
WHERE lat_n = (SELECT MAX(lat_n)
               FROM station
               WHERE lat_n < 137.2345)
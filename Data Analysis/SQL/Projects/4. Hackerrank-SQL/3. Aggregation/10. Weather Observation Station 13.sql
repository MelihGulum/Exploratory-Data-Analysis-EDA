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

    Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. 
    Truncate your answer to 4 decimal places. */

-- MySQL
SELECT TRUNCATE(SUM(lat_n), 4) -- or ROUND(SUM(lat_n),4)
FROM station
WHERE lat_n > 38.7880 
    AND lat_n < 137.2345;

-- MS SQL Server
SELECT CAST(SUM(lat_n) AS DECIMAL(10, 4))
FROM station
WHERE lat_n BETWEEN 38.7880 AND 137.2345
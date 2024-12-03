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

    Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. 
    Truncate your answer to 4 decimal places. */

--My SQL
SELECT TRUNCATE(MAX(lat_n),4)
FROM station
WHERE lat_n < 137.2345;

-- MS SQL Server
SELECT CAST(MAX(lat_n) AS DECIMAL(10, 4))
FROM station
WHERE lat_n < 137.2345
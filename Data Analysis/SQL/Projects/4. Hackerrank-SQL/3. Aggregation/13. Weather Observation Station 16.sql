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

    Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7880. 
    Round your answer to 4 decimal places. */

--MySQL
SELECT ROUND(MIN(lat_n),4)
FROM station
WHERE lat_n > 38.7780;

--MS SQL Server
SELECT CAST(MIN(lat_n) AS DECIMAL(10, 4))
FROM station
WHERE lat_n > 38.7780;
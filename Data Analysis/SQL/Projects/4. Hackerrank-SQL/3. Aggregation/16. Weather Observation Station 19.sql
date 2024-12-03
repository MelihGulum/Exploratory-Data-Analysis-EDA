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

    Consider P1 and P2 to be two points on a 2D plane where (a,b) are the respective minimum and maximum values of Northern Latitude (LAT_N) and 
    (c,d) are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

    Query the Euclidean Distance between points  and  and format your answer to display  decimal digits. */

--MySQL
SELECT ROUND(SQRT(POWER(MAX(lat_n) - MIN(lat_n), 2) + POWER(MAX(long_w) - MIN(long_w), 2)), 4)
FROM station;

--MS SQL Server
SELECT CAST(SQRT(SQUARE(MAX(lat_n)- MIN(lat_n)) + SQUARE(MAX(long_w) - MIN(long_w))) AS DECIMAL(10, 4))
FROM station;
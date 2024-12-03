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

    Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7880. 
    Round your answer to  decimal places. */
	
--MySQL
SELECT ROUND(long_w, 4)
FROM station
WHERE lat_n = (SELECT MIN(lat_n)
               FROM station
               WHERE lat_n > 38.7780);

-- MS SQL Server
SELECT CAST(long_w AS DECIMAL(10, 4))
FROM station
WHERE lat_n = (SELECT MIN(lat_n)
               FROM station
               WHERE lat_n > 38.7780);
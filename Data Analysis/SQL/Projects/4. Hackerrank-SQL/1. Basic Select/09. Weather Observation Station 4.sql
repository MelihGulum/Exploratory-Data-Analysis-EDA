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

Let N be the number of CITY entries in STATION, and let N’ be the number of distinct CITY names in STATION; 
query the value of N - N’ from STATION. In other words, 
find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table. */

SELECT COUNT(city) - COUNT(DISTINCT city)
FROM station;
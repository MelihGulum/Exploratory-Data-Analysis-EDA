/* Query a list of CITY names from STATION with even ID numbers only. You may print the results in any order, but must exclude duplicates from your answer.
Input Format

The STATION table is described as follows:
		+-------------+------------+
		| Field       |   Type     |
		+-------------+------------+
		| ID          | INTEGER    |
		| CITY        | VARCHAR(21)|
		| STATE       | VARCHAR(2) |
		| LAT_N       | NUMERIC    |
		| LONG_W      | NUMERIC    |
		+-------------+------------+

where LAT_N is the northern latitude and LONG_W is the western longitude.

*/
SELECT DISTINCT(city)
FROM station
WHERE (id % 2) = 0;
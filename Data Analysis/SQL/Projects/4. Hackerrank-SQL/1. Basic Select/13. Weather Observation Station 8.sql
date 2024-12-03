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

Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
Your result cannot contain duplicates. */

SELECT DISTINCT(city)
FROM station
WHERE city LIKE '[AEIOU]%'
    AND city LIKE '%[AEIOU]';
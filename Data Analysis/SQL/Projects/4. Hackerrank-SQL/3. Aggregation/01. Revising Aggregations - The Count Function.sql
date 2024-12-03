/* The CITY table is described as follows: 

		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| ID          | int(11)  |
		| Name        | char(35) |
		| CountryCode | char(3)  |
		| District    | char(20) |
		| Population  | int(11)  |
		+-------------+----------+

   Query a count of the number of cities in CITY having a Population larger than 100,000. */

SELECT COUNT(*)
FROM city
WHERE population > 100000;
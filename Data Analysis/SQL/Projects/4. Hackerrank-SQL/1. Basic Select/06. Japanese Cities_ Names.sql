/*The CITY table is described as follows: 

		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| ID          | int(11)  |
		| Name        | char(35) |
		| CountryCode | char(3)  |
		| District    | char(20) |
		| Population  | int(11)  |
		+-------------+----------+

Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.*/

SELECT name
FROM city
WHERE countrycode = 'JPN';
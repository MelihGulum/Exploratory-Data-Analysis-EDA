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

Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN. */

SELECT *
FROM city
WHERE countrycode = 'JPN';
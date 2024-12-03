/* The tables are described as follows: 

    CITY:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| ID          | int(11)  |
		| Name        | char(35) |
		| CountryCode | char(3)  |
		| District    | char(20) |
		| Population  | int(11)  |
		+-------------+----------+

    COUNTRY:
		+----------------+--------------+
		| Field          | Type         |
		+----------------+--------------+
		| Code           | VARCHAR2(3)  |
		| Name           | VARCHAR2(44) |
		| Continent      | VARCHAR2(13) |
		| Region         | VARCHAR2(25) |
		| SurfaceArea    | NUMBER       |
		| Indepyear      | VARCHAR2(5)  |
		| Population     | NUMBER       |
		| LifeExpectancy | VARCHAR2(4)  |
		| Gnp            | NUMBER       |
		| GnpOld         | VARCHAR2(9)  |
		| Localname      | VARCHAR2(44) |
		| GovermentForm  | VARCHAR2(44) |
		| HeadOfState    | VARCHAR2(32) |
		| Capital        | VARCHAR2(4)  |
		| Code2          | VARCHAR2(2)  |
		+----------------+--------------+

  Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

  Note: CITY.CountryCode and COUNTRY.Code are matching key columns. */

SELECT SUM(ci.population)
FROM city AS ci
    JOIN country as co
        ON ci.countrycode = co.code
WHERE co.continent = 'Asia';

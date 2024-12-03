/* The OCCUPATIONS table is described as follows:

		+-------------+------------+
		| Field       |   Type     |
		+-------------+------------+
		| Name        | STRING     |
		| Occupations | STRING     |
		+-------------+------------+ 
   Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. 
   The output column headers should be Doctor, Professor, Singer, and Actor, respectively. 
*/

SELECT MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS Doctor,
       MAX(CASE WHEN occupation = 'Professor' THEN name END) AS Professor,
       MAX(CASE WHEN occupation = 'Singer' THEN name END) AS Singer,
       MAX(CASE WHEN occupation = 'Actor' THEN name END) AS Actor
FROM (SELECT name,
             occupation,
             ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) AS rn
      FROM occupations
      ) AS sub
GROUP BY rn;
/* The tables are described as follows: 

    Wands:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| id          | Integer  |
		| code        | Integer  |
		| coin_needed | Integer  |
		| power       | Integer  |
		+-------------+----------+

    Wands_Property:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| code        | Integer  |
		| age         | Integer  |
		| is_evil     | Integer  |
		+-------------+----------+

   Query a count of the number of cities in CITY having a Population larger than 100,000. */

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
SELECT id, 
       age, 
       m.coins_needed, 
       m.power
FROM (SELECT code, 
             power, 
             MIN(coins_needed) AS coins_needed 
      FROM Wands 
      GROUP BY code, power
      ) AS m
    JOIN Wands AS w 
        ON m.code = w.code 
            AND m.power = w.power 
            AND m.coins_needed = w.coins_needed
    JOIN Wands_Property 
         AS p ON m.code = p.code
WHERE p.is_evil = 0
ORDER BY m.power DESC, 
         age DESC;
    

/* Write a query to print all prime numbers less than or equal to 1000. 
   Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).

   For example, the output for all prime numbers <=10 would be:
       2&3&5&7
*/

WITH cte(num) AS (SELECT 2
                  UNION ALL 
                  SELECT num+1 
                  FROM cte
                  WHERE num+1 < 1000
                  )
  
SELECT STRING_AGG(a.num, '&')                   
FROM cte AS a
WHERE NOT EXISTS (SELECT * 
                  FROM cte b
                  WHERE a.num % b.num = 0                     
                      AND a.num != b.num )
OPTION (MAXRECURSION 1000); 

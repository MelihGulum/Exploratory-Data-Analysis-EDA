/* The table described as follows: 

		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| X           | Integer  |
		| Y           | Integer  |
		+-------------+----------+

   Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
   Write a query to output all such symmetric pairs in ascending order by the value of X. */

SELECT f1.X, 
       f1.Y 
FROM Functions AS f1
WHERE f1.X = f1.Y 
    AND (SELECT COUNT(*) 
         FROM Functions 
         WHERE X = f1.X AND Y = f1.X) > 1
UNION
SELECT f1.X, f1.Y 
FROM Functions AS f1
WHERE EXISTS(SELECT X, Y 
             FROM Functions 
             WHERE f1.X = Y 
                 AND f1.Y = X 
                 AND f1.X < X)
ORDER BY X;

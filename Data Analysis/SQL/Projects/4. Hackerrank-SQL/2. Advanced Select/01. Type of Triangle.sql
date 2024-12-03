/* Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. 

		+-------------+------------+
		| Field       |   Type     |
		+-------------+------------+
		| A           | INTEGER    |
		| B           | INTEGER    |
		| C           | INTEGER    |
		+-------------+------------+

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.

Not A Triangle: The given values of A, B, and C don't form a triangle. */

SELECT
      CASE 
          WHEN A + B <= C or A + C <= B or B + C <= A THEN 'Not A Triangle'
          WHEN A = B and B = C THEN 'Equilateral'
          WHEN A = B or A = C or B = C THEN 'Isosceles'
          WHEN A <> B and B <> C THEN 'Scalene'
      END 
FROM triangles
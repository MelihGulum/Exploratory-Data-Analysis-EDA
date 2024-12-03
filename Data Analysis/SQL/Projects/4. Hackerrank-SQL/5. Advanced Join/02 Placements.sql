/* The tables are described as follows: 

    Students:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| ID          | Integer  |
		| Name        | String   |
		+-------------+----------+

    Friends
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| ID          | Integer  |
		| Friend_ID   | Integer  |
		+-------------+----------+

    Packages:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| ID          | Integer  |
		| Salary      | Float    |
		+-------------+----------+

    Write a query to output the names of those students whose best friends got offered a higher salary than them. 
    Names must be ordered by the salary amount offered to the best friends.
    It is guaranteed that no two students got same salary offer. */

SELECT s.Name 
FROM Students AS s
    JOIN Packages AS sp 
        ON s.ID = sp.ID
    JOIN Friends AS f 
        ON s.ID = f.ID
    JOIN Packages AS fp 
        ON f.Friend_ID = fp.ID
WHERE sp.Salary < fp.Salary
ORDER BY fp.Salary;

/* The EMPLOYEE table is described as follows: 

		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| employee_id | Integer  |
		| name        | String   |
		| month       | Integer  |
		| salary      | Integer  |
		+-------------+----------+

    We define an employee's total earnings to be their monthly  worked, 
	and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
    
    Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. 
    Then print these values as  space-separated integers. */

-- MySQL
SELECT salary*months, 
       COUNT(*)
FROM employee
GROUP BY salary * months
ORDER BY salary * months DESC
LIMIT 1;

-- MS SQL Server
SELECT TOP 1 (months * salary) AS earnings, 
              COUNT(*) 
FROM employee
GROUP BY  (months * salary) 
ORDER BY  (months * salary) DESC;
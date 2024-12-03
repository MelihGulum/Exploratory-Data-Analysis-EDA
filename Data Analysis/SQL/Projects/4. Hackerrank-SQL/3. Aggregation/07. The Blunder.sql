/* The EMPLOYEES table is described as follows: 

		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| ID          | Integer  |
		| Name        | String   |
		| Salary      | Integer  |
		+-------------+----------+

    Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, 
    but did not realize her keyboard's 0 key was broken until after completing the calculation. 
    She wants your help finding the difference between her miscalculation (using salaries with any zeroes removed), 
        and the actual average salary.

    Write a query calculating the amount of error (i.e.:  average monthly salaries), 
       and round it up to the next integer. */

--MySQL
SELECT CEIL(AVG(salary) - AVG(REPLACE(salary,'0','')))
FROM employees;

--MS SQL Server
SELECT CAST(CEILING(
                    (AVG(CAST(salary AS Float)) - AVG(CAST(REPLACE(salary, 0, '') AS Float)))
                    ) AS INT)
FROM employees;
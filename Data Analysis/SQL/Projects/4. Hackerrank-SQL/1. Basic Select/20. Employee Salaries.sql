/* The Employee table containing employee data for a company is described as follows:

		+-------------+----------+
		| Column      | Type     |
		+-------------+----------+
		| employee_id | int(11)  |
		| name        | char(35) |
		| months      | char(35) |
		| salary      | int(11)  |
		+-------------+----------+

Write a query that prints a list of employee names (i.e.: the name attribute) 
for employees in Employee having a salary greater than $2,000 per month who have been employees for less than 10 months. 
Sort your result by ascending employee_id. */

SELECT name
FROM employee
WHERE salary > 2000
    AND months < 10
ORDER BY employee_id;
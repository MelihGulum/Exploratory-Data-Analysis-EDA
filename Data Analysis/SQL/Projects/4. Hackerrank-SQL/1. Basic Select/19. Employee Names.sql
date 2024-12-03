/* The Employee table containing employee data for a company is described as follows:

		+-------------+----------+
		| Column      | Type     |
		+-------------+----------+
		| employee_id | int(11)  |
		| name        | char(35) |
		| months      | char(35) |
		| salary      | int(11)  |
		+-------------+----------+

Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order. */

SELECT name
FROM employee
ORDER BY name;
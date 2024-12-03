/*
	CTE (Common Table Expression)
*/

-- A common table expression, or CTE, is a temporary named result set created from a simple SELECT statement that can be used in a subsequent SELECT statement. 
-- Each SQL CTE is like a named query, whose result is stored in a virtual table (a CTE) to be referenced later in the main query.

WITH CTE_Employee AS (
	SELECT FirstName, LastName, Gender, Salary,
		   COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
		   AVG(Salary) OVER (PARTITION BY Gender) AS AVGSalary
	FROM SQLTutorial..EmployeeDemographics AS dem
	JOIN SQLTutorial..EmployeeSalary AS sal
		ON dem.EmployeeID = sal.EmployeeID
	WHERE Salary > '45000'
)
SELECT FirstName, AVGSalary
FROM CTE_Employee

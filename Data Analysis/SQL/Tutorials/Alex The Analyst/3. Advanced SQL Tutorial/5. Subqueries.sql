/*
	Subqueries
*/
-- a subquery is a query that is nested inside another query. 
-- SQL subqueries are also called nested queries or inner queries, while the SQL statement containing the subquery is typically referred to as an outer query.
-- You can use SQL subqueries in SELECT, INSERT, UPDATE, and DELETE statements.

SELECT *
FROM SQLTutorial.dbo.EmployeeSalary


--------------------------------------------------------------------------------------------------------------------------
-- Subquery in Select
SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM SQLTutorial.dbo.EmployeeSalary) AS AVGSalary
FROM SQLTutorial.dbo.EmployeeSalary 


--------------------------------------------------------------------------------------------------------------------------
-- How to do it with Partition By
SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
FROM SQLTutorial.dbo.EmployeeSalary 


--------------------------------------------------------------------------------------------------------------------------
-- Why Group By doesn't work
SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSalary
FROM SQLTutorial.dbo.EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY EmployeeID


--------------------------------------------------------------------------------------------------------------------------
-- Subquery in From
SELECT a.EmployeeID, AllAvgSalary
FROM (
	SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
	FROM SQLTutorial.dbo.EmployeeSalary
	) AS a
ORDER BY a.EmployeeID


--------------------------------------------------------------------------------------------------------------------------
-- Subquery in Where
SELECT EmployeeID, JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeSalary
WHERE EmployeeID in (
	SELECT EmployeeID 
	FROM SQLTutorial.dbo.EmployeeDemographics
	WHERE Age > 30
	)
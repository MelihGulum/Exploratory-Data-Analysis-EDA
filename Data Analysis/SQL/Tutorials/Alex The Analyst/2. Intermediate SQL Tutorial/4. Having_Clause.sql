/*
	Having Clause
*/

-- The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.
-- The SQL HAVING clause is used if we need to filter the result set based on aggregate functions such as MIN() and MAX(), SUM() and AVG(), and COUNT().


--------------------------------------------------------------------------------------------------------------------------
-- The following sql statement shows that we cannot use aggregate functions with the Where statement.
SELECT JobTitle, COUNT(JobTitle)
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE COUNT(JobTitle) > 1
GROUP BY JobTitle


--------------------------------------------------------------------------------------------------------------------------
-- Having, on the other hand, allows us to do this.
SELECT JobTitle, COUNT(JobTitle)
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1


SELECT JobTitle, AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)

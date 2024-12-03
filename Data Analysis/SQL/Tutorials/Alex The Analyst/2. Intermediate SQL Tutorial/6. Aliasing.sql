/*
	Aliasing
*/

-- SQL aliases are used to give a table, or a column in a table, a temporary name.
-- Aliases are often used to make column names more readable.
-- An alias only exists for the duration of that query.
-- An alias is created with the AS keyword.

SELECT FirstName AS FName
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT FirstName FName
FROM SQLTutorial.dbo.EmployeeDemographics


--------------------------------------------------------------------------------------------------------------------------
-- Concatenate Columns
SELECT FirstName + ' ' + LastName AS FullName
FROM SQLTutorial.dbo.EmployeeDemographics


--------------------------------------------------------------------------------------------------------------------------
-- Aggeragtion Functions
SELECT AVG(Age) AS AvgAge
FROM SQLTutorial.dbo.EmployeeDemographics


--------------------------------------------------------------------------------------------------------------------------
-- Aliasing Table Names
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo

SELECT Demo.EmployeeID
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID

	
SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, 
	   Sal.JobTitle, Ware.Age
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
LEFT JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID 
LEFT JOIN SQLTutorial.dbo.WareHouseEmployeeDemographics AS Ware
	ON Demo.EmployeeID = Ware.EmployeeID 


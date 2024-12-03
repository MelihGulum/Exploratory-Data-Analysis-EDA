/*
	SELECT Statement
		*, TOP, DISTINCT, COUNT, AS, MAX, MIN, AVG	
*/

-- If we use * the query will return every row and column in the table
-- However, we can select several columns using their names.
SELECT * FROM EmployeeDemographics

SELECT FirstName, LastName
FROM EmployeeDemographics

-- The SELECT TOP clause is used to specify the number of records to return.
-- The SELECT TOP clause is useful on large tables with thousands of records. 
-- Returning a large number of records can impact performance.
SELECT TOP 5 *
FROM EmployeeDemographics


--------------------------------------------------------------------------------------------------------------------------
-- The SELECT DISTINCT statement is used to return only distinct (different) values
SELECT DISTINCT(Gender)
FROM EmployeeDemographics


--------------------------------------------------------------------------------------------------------------------------
-- The COUNT() returns the number of records returned by a query.
SELECT COUNT(LastName)
FROM EmployeeDemographics


--------------------------------------------------------------------------------------------------------------------------
-- SQL aliases are used to give a table, or a column in a table, a temporary name.
-- Aliases are often used to make column names more readable.
-- An alias only exists for the duration of that query.

SELECT COUNT(LastName) AS LastNameCount
FROM EmployeeDemographics


--------------------------------------------------------------------------------------------------------------------------
-- The MIN() function returns the smallest value of the selected column.
-- The MAX() function returns the largest value of the selected column.
-- The AVG() function returns the average value of a numeric column.

SELECT MAX(Salary)
FROM EmployeeSalary

SELECT MIN(Salary)
FROM EmployeeSalary

SELECT AVG(Salary)
FROM EmployeeSalary
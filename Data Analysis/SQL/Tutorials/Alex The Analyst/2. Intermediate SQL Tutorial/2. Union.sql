/*
	Union, Union All
*/

-- The UNION operator is used to combine the result-set of two or more SELECT statements.
--	  Every SELECT statement within UNION must have the same number of columns
--	  The columns must also have similar data types
--    The columns in every SELECT statement must also be in the same order
-- The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL.

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
FULL OUTER JOIN SQLTutorial.dbo.WareHouseEmployeeDemographics
	ON EmployeeDemographics.Age = 
		WareHouseEmployeeDemographics.EmployeeID


--------------------------------------------------------------------------------------------------------------------------
-- These two table basically have same information. That's why Union worked well.
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
UNION
SELECT *
FROM SQLTutorial.dbo.WareHouseEmployeeDemographics

SELECT EmployeeID, FirstName, Age
FROM SQLTutorial.dbo.EmployeeDemographics
UNION
SELECT EmployeeID, FirstName, Age
FROM SQLTutorial.dbo.WareHouseEmployeeDemographics

SELECT EmployeeID, FirstName, Age
FROM SQLTutorial.dbo.EmployeeDemographics
WHERE Age > 30
UNION
SELECT EmployeeID, FirstName, Age
FROM SQLTutorial.dbo.WareHouseEmployeeDemographics
WHERE Age > 30
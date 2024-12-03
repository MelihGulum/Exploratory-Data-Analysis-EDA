/*
	Partition By
*/

-- The SQL PARTITION BY expression is a subclause of the OVER clause, 
--     which is used in almost all invocations of window functions like AVG(), MAX(), and RANK().

SELECT FirstName, LastName, Gender, Salary,
	   COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQLTutorial..EmployeeDemographics AS dem
JOIN SQLTutorial..EmployeeSalary AS sal
	ON dem.EmployeeID = sal.EmployeeID


--------------------------------------------------------------------------------------------------------------------------
-- Partition By vs Group By
--		Partition by is the combination of the following two SQL statements.
SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) 
FROM SQLTutorial..EmployeeDemographics AS dem
JOIN SQLTutorial..EmployeeSalary AS sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary

SELECT Gender, COUNT(Gender) 
FROM SQLTutorial..EmployeeDemographics AS dem
JOIN SQLTutorial..EmployeeSalary AS sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender

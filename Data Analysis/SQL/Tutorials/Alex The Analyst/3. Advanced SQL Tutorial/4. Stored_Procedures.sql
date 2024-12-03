/*
	Stored Procedures

	A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again
	So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.
	You can also pass parameters to a stored procedure, so that the stored procedure can act based on the parameter value(s) that is passed.

	CREATE PROCEDURE procedure_name
	AS
	sql_statement
	GO;
*/

-- Stored procedures are under the programmability folder
CREATE PROCEDURE TEST
AS 
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

-- Execute a Stored Procedure
EXEC TEST

-- Produce, insert and select must have run together
CREATE PROCEDURE Temp_Employee
AS
DROP TABLE IF EXISTS #temp_employee
CREATE TABLE #temp_employee (
	JobTitle varchar(100),
	EmployeesPerJob int ,
	AvgAge int,
	AvgSalary int
)

INSERT INTO #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT * 
FROM #temp_employee

EXEC Temp_Employee



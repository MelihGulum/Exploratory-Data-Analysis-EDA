/*
	Temp Tables
*/
-- SELECT INTO statement is one of the easy ways to create a new table and then copy the source table data into this newly created table. 
-- In other words, the SELECT INTO statement performs a combo task:
--		Creates a clone table of the source table with exactly the same column names and data types
--		Reads data from the source table
--		Inserts data into the newly created table
-- We can use the SELECT INTO TEMP TABLE statement to perform the above tasks in one statement for the temporary tables. 
-- In this way, we can copy the source table data into the temporary tables in a quick manner.

-- Creating temp tables are mostly the same with creating table
CREATE TABLE #temp_employee1 (
	EmployeeID int,
	JobTitle varchar(100),
	Salary int
)

-- Insert data
INSERT INTO #temp_employee1
SELECT * 
FROM SQLTutorial.dbo.EmployeeSalary

SELECT * 
FROM #temp_employee1


-- Creating another temp table
CREATE TABLE #temp_employee2 (
	JobTitle varchar(100),
	EmployeesPerJob int ,
	AvgAge int,
	AvgSalary int
)

INSERT INTO #temp_employee2
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics emp
JOIN SQLTutorial.dbo.EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT * 
FROM #temp_employee2


--------------------------------------------------------------------------------------------------------------------------
-- If you create a new temporary table with the name you used before, it will give an error. To avoid this error, you can:
DROP TABLE IF EXISTS #temp_employee2
CREATE TABLE #temp_employee2 (
	JobTitle varchar(100),
	EmployeesPerJob int ,
	AvgAge int,
	AvgSalary int
)


--------------------------------------------------------------------------------------------------------------------------
-- The advantage of using a "temporary table" is that we can use "temporary table" without needing to run the entire statement.
SELECT JobTitle, EmployeesPerJob * AvgSalary AS TotalJobWage
FROM #temp_employee2
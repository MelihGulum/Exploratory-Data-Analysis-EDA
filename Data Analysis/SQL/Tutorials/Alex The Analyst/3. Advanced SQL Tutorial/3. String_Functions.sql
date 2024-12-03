/*
	String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
*/

-- Create a new table to be able to use string functions.
CREATE TABLE SQLTutorial.dbo.EmployeeErrors (
	EmployeeID varchar(50),
	FirstName varchar(50),
	LastName varchar(50)
)

INSERT INTO SQLTutorial.dbo.EmployeeErrors VALUES 
	('1001  ', 'Jimbo', 'Halbert'),
	('  1002', 'Pamela', 'Beasely'),
	('1005', 'TOby', 'Flenderson - Fired')

SELECT *
FROM SQLTutorial.dbo.EmployeeErrors


--------------------------------------------------------------------------------------------------------------------------
-- Using Trim, LTRIM, RTRIM
-- TRIM([characters FROM ]string)
SELECT EmployeeID, TRIM(EmployeeID) AS IDTrim
FROM SQLTutorial.dbo.EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS IDLTrim
FROM SQLTutorial.dbo.EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) AS IDRTrim
FROM SQLTutorial.dbo.EmployeeErrors


--------------------------------------------------------------------------------------------------------------------------
-- Using Replace
-- REPLACE(string, old_string, new_string)
SELECT LastName, REPLACE(LastName, '- Fired', '') AS LastNameFixed
FROM SQLTutorial.dbo.EmployeeErrors


-- Using Substring
-- SUBSTRING(string, start, length)
SELECT SUBSTRING(FirstName, 1, 3)
FROM SQLTutorial.dbo.EmployeeErrors

SELECT SUBSTRING(FirstName, 3, 3)
FROM SQLTutorial.dbo.EmployeeErrors

-- Fuzzy match
SELECT Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), 
	   Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM SQLTutorial.dbo.EmployeeErrors err
JOIN SQLTutorial.dbo.EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)

-- Using UPPER and LOWER
-- UPPER(text), LOWER(text)
SELECT firstname, LOWER(firstname)
FROM SQLTutorial.dbo.EmployeeErrors

SELECT Firstname, UPPER(FirstName)
FROM SQLTutorial.dbo.EmployeeErrors
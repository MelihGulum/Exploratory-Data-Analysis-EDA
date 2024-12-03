/*
	Updating/Deleting Data
*/

-- The UPDATE statement is used to modify the existing records in a table.
--		Be careful when updating records. If you omit the WHERE clause, ALL records will be updated!

-- Select statement to quickly see the result
SELECT * 
FROM SQLTutorial.dbo.EmployeeDemographics


--------------------------------------------------------------------------------------------------------------------------
-- Updating only one column
UPDATE SQLTutorial.dbo.EmployeeDemographics
SET EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'Flax'


--------------------------------------------------------------------------------------------------------------------------
-- Updating multiple columns
UPDATE SQLTutorial.dbo.EmployeeDemographics
SET Gender = 'Female', Age = 31
WHERE FirstName = 'Holly' AND LastName = 'Flax'


--------------------------------------------------------------------------------------------------------------------------
-- Update mostly done with primary key
UPDATE SQLTutorial.dbo.EmployeeDemographics
SET Gender = 'Female', Age = 31
WHERE EmployeeID = 1012


--------------------------------------------------------------------------------------------------------------------------
-- The DELETE statement is used to delete existing records in a table.
--		Be careful when deleting records. If you omit the WHERE clause, ALL records will be deleted!
SELECT * 
FROM SQLTutorial.dbo.EmployeeDemographics


DELETE FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1005
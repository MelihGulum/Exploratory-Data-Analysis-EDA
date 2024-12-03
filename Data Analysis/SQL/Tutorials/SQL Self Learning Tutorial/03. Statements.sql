/*
	Queries
	   INSERT INTO, SELECT, SELECT DISTINCT, TOP-TOP PERCENT, 
	   SELECT INTO, INSERT INTO SELECT, UPDATE, DELETE
*/

--------------------------------------------------------------------------------------------------------------------------
-- INSERT INTO Statement
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int,
                        FirstName varchar(50),
                        LastName varchar(50),
                        Age int, 
                        Gender varchar(50)
                        );

-- Single Row
INSERT INTO Employees 
VALUES (1001, 'Jim', 'Halpert', 30, 'Male');

-- Multiple Row
INSERT INTO Employees VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male');

-- Insert Data Only in Specified Columns
INSERT INTO Employees (EmployeeID, FirstName, Gender)
VALUES (1010, 'Jan', 'Female');


--------------------------------------------------------------------------------------------------------------------------
-- SELECT Statement
--------------------------------------------------------------------------------------------------------------------------
SELECT FirstName, 
       Age
FROM Employees;

-- Select ALL columns
SELECT * FROM Employees;

-- Aliasing a Column in SELECT Statement
SELECT FirstName + ' ' + LastName AS FullName
FROM Employees;


--------------------------------------------------------------------------------------------------------------------------
--  SELECT DISTINCT
--------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT * 
FROM Employees;

SELECT DISTINCT Gender
FROM Employees;


--------------------------------------------------------------------------------------------------------------------------
--  TOP - TOP PERCENT
--------------------------------------------------------------------------------------------------------------------------
SELECT TOP 3 *
FROM Employees;

SELECT TOP 50 PERCENT *
FROM Employees;


--------------------------------------------------------------------------------------------------------------------------
-- SELECT INTO Statement
-- The SELECT INTO statement copies data from one table into a new table.
--------------------------------------------------------------------------------------------------------------------------
SELECT * INTO EmployeesBackup -- Copy whole table
FROM Employees;

SELECT EmployeeID, -- Copy some columns
       FirstName, 
       LastName 
INTO EmployeesBackup2
FROM Employees;


--------------------------------------------------------------------------------------------------------------------------
-- INSERT INTO ... SELECT
-- Inserting Data into a Table Using Another
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE EmployeesCopy(EmployeeID int,
                           LastName varchar(50),
                           FirstName varchar(50),
                           Age int, 
                           Gender varchar(50)
                           );

INSERT INTO EmployeesCopy 
SELECT * FROM Employees;


--------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-- Be careful when updating records. If you omit the WHERE clause, ALL records will be updated!
--------------------------------------------------------------------------------------------------------------------------
UPDATE Employees
SET LastName = 'Levinson'
WHERE EmployeeID = 1010;

-- Updating Multiple Columns
UPDATE Employees
SET FirstName = 'Janet', 
    Age = 33
WHERE EmployeeID = 1010;


--------------------------------------------------------------------------------------------------------------------------
-- DELETE
-- If you omit the WHERE clause, all records in the table will be deleted!
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Employees
WHERE FirstName = 'Toby';

-- Delete All Records
DELETE FROM Employees;
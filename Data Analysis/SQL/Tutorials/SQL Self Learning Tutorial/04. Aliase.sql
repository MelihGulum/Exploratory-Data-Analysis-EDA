/*
	ALIASE
	   SQL aliases are used to give a table, or a column in a table, a temporary name.
	   Aliases are often used to make column names more readable.
*/

-- First, let's create the tables we will use.
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int,
                        FirstName varchar(50),
                        LastName varchar(50),
                        Age int, 
                        Gender varchar(50)
                        );


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

--------------------------------------------------------------------------------------------------------------------------
-- ALIASE
--------------------------------------------------------------------------------------------------------------------------
SELECT EmployeeID AS ID
FROM Employees

SELECT EmployeeID ID -- without AS
FROM Employees

-- Using Aliases With a Space Character
SELECT EmployeeID AS [PERSON Identification]
FROM Employees

-- Concatenate Columns
SELECT FirstName + ' ' + LastName AS FullName 
FROM Employees

-- Alias for Tables
SELECT E.FirstName
FROM Employees AS E
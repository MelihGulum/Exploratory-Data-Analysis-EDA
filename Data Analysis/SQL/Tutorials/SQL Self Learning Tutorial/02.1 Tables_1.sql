/*
	Table
          Create Table, Clone Table, Show Tables, Drop Table, Alter Table, Truncate Table, Temporary Tables
*/

--------------------------------------------------------------------------------------------------------------------------
-- Create Table
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Employees
CREATE TABLE Employee (EmployeeID int,
                       LastName varchar(50),
                       FirstName varchar(50),
                       Age int, 
                       Gender varchar(50)
                       );

-- Create Table IF NOT EXISTS Equivalent
IF OBJECT_ID(N'Employees', N'U') IS NOT NULL
    PRINT 'Already Created'
ELSE
    CREATE TABLE Employees (EmployeeID int,
                            LastName varchar(50),
                            FirstName varchar(50),
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
-- Creating Table from an Existing Table / Cloning Table
--------------------------------------------------------------------------------------------------------------------------
SELECT * INTO EmployeesCopy 
FROM Employees;


--------------------------------------------------------------------------------------------------------------------------
-- Show Tables
--------------------------------------------------------------------------------------------------------------------------
SELECT * FROM SYS.TABLES;


--------------------------------------------------------------------------------------------------------------------------
-- Describe Table
--------------------------------------------------------------------------------------------------------------------------
EXEC sp_help Employees; -- built-in system stored procedure sp_help 

EXEC sp_columns Employees;  -- sp_columns to show the structure of a SQL Server table

SELECT * FROM INFORMATION_SCHEMA.COLUMNS  -- with query
WHERE table_name = 'Employees';  


--------------------------------------------------------------------------------------------------------------------------
-- Rename Table
--------------------------------------------------------------------------------------------------------------------------
EXEC sp_rename 'EmployeesCopy', 'EmployeesCopyV1'


--------------------------------------------------------------------------------------------------------------------------
-- Drop Table
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS EmployeesCopyV1;


--------------------------------------------------------------------------------------------------------------------------
-- Alter Table
--------------------------------------------------------------------------------------------------------------------------

-- ADD Column
ALTER TABLE Employees
ADD Salary int;     

-- DROP Column
ALTER TABLE Employees
DROP COLUMN Salary; 

-- RENAME Column
EXEC sp_rename 'Employees.Gender',  'Sex', 'COLUMN';

--  MODIFY Datatype
ALTER TABLE Employees 
ALTER COLUMN Age float;


--------------------------------------------------------------------------------------------------------------------------
-- Truncate Table
-- The SQL TRUNCATE TABLE command is used to empty a table
--------------------------------------------------------------------------------------------------------------------------
TRUNCATE TABLE Employees;


--------------------------------------------------------------------------------------------------------------------------
/*
   Temporary Tables
   SQL Server can create two types of temporary tables
  		Local Temporary Tables (#)
 		Global Temporary Tables (##)
   If you create a new temporary table with the name you used before, it will give an error. To avoid this error, you can use 
   DROP IF EXISTS [table_name]
*/
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS #Customers
CREATE TABLE #Customers (ID int,
                         LastName varchar(255),
                         FirstName varchar(255),
                         Age int,
                         Address varchar(255),
                         Salary decimal(18, 2)
                         );


DROP TABLE IF EXISTS ##Buyers
CREATE TABLE ##Buyers (ID int,
                       LastName varchar(255),
                       FirstName varchar(255),
                       Age int,
                       Address varchar(255),
                       Salary decimal(18, 2)
                       );

DROP TABLE #Customers, ##Buyers;

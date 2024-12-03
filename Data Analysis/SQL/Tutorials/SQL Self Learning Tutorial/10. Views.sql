/*
	VIEWS
	    CREATE VIEW, UPDATE VIEW, ALTER VIEW, RENAME VIEW, LIST VIEW, DROP VIEW

	    A view in SQL is a virtual table that is stored in the database with an associated name. It is actually a composition of a table in the form of a predefined SQL query. 
		A view can contain rows from an existing table (all or selected). 
		A view can be created from one or many tables. Unless indexed, a view does not exist in a database.
*/

-- First, let's create the tables we will use.
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int,
                        FirstName varchar(50),
                        LastName varchar(50),
                        Age int, 
                        Gender varchar(50),
                        JobTitle varchar(50),
                        Salary int,
                        OnVacation bit
                        );

INSERT INTO Employees VALUES
(1001, 'Jim', 'Halpert', 30, 'Male', 'Salesman', 45000, 1),
(1002, 'Pam', 'Beasley', 30, 'Female', 'Receptionist', 36000, 1),
(1003, 'Dwight', 'Schrute', 29, 'Male', 'Salesman', 63000, 1),
(1004, 'Angela', 'Martin', 31, 'Female', 'Accountant', 47000, 0),
(1005, 'Toby', 'Flenderson', 32, 'Male', 'HR', 50000, 0),
(1006, 'Michael', 'Scott', 35, 'Male', 'Regional Manager', 65000, 0),
(1007, 'Meredith', 'Palmer', 32, 'Female', 'Supplier Relations', 41000, 0),
(1008, 'Stanley', 'Hudson', 38, 'Male', 'Salesman', 48000, 1),
(1009, 'Kevin', 'Malone', 31, 'Male', 'Accountant', 42000, 0),
(1010, 'Jan', NULL, NULL, 'Female', 'Chief Executive Officer', 70000, 0),
(1011, 'Holy', 'Flax', 32, 'Female', 'Temp HR', 50000, 0),
(1012, 'Ryan', 'Howard', 30, 'Male', 'Temp Receptionist', 36000, 0),
(1013, 'Andy', 'Bernard', 34, 'Male', 'Regional Manager', 65000, 0);


--------------------------------------------------------------------------------------------------------------------------
-- VIEWS
--------------------------------------------------------------------------------------------------------------------------

-- CREATE VIEW
DROP VIEW IF EXISTS EmpSalesman;
GO
CREATE VIEW EmpSalesman 
AS
    SELECT * 
    FROM Employees
    WHERE JobTitle = 'Salesman';
GO


SELECT * -- Verification
FROM EmpSalesman;


-- UPDATE VIEW
UPDATE EmpSalesman
SET OnVacation = 0
WHERE EmployeeID = 1008;


-- ALTER VIEW
GO
ALTER VIEW EmpSalesman
AS 
    SELECT FirstName, 
           LastName, 
           OnVacation
    FROM Employees
    WHERE JobTitle = 'Salesman';
GO


-- RENAME VIEW
EXEC sp_rename EmpSalesman, EmployeeSalesman;


-- LIST VIEWS
SELECT *
FROM INFORMATION_SCHEMA.VIEWS; -- with Information Schema View


EXEC sp_tables  -- with stored procedure
  @table_owner = 'dbo',
  @table_type = "'VIEW'";


-- DROP VIEW
DROP VIEW IF EXISTS EmployeeSalesman;



/*
	STORED PROCEDURE
	Stored Procedure is a group of pre-compiled SQL statements (prepared SQL code) that can be reused by simply calling it whenever needed.
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
-- STORED PROCEDURE
--------------------------------------------------------------------------------------------------------------------------

GO -- There is additional code above our procedure. To get rid of the syntax warning, we need to add GO before SP.
CREATE PROCEDURE GetTitleForFemaleEmployees
AS
    SELECT JobTitle
    FROM Employees
    WHERE GENDER = 'Female'
GO

EXEC GetTitleForFemaleEmployees; -- Execute Procedure


-- with One Parameter
GO
CREATE PROC SelectAllEmployees @Job nvarchar(30) = NULL
AS
    SELECT * 
    FROM Employees 
    WHERE JobTitle = @Job
GO

EXEC SelectAllEmployees @Job = 'Salesman';


-- with Multiple Parameters
GO
CREATE PROC GetAllEmployees @Job nvarchar(30) = NULL,
                            @Salary int = NULL
AS
    SELECT * 
    FROM Employees 
    WHERE JobTitle = @Job
          AND Salary > @Salary
GO

EXEC GetAllEmployees @Job = 'Salesman', @Salary = 50000;


-- Alter Procedure
GO
ALTER PROC GetAllEmployees @Job nvarchar(30) = NULL,
                            @Salary int = NULL
AS
    SELECT FirstName, 
           LastName, 
           JobTitle, 
           Salary
    FROM Employees 
    WHERE JobTitle = @Job
          AND Salary > @Salary
GO

EXEC GetAllEmployees @Job = 'Salesman', @Salary = 50000;


-- Drop Procedure
DROP PROCEDURE GetAllEmployees
GO


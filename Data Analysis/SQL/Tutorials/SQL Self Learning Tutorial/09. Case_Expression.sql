/*
	CASE EXPRESSION
	    The CASE expression works like a simplified IF-THEN-ELSE statement 
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
-- CASE EXPRESSION
--------------------------------------------------------------------------------------------------------------------------
SELECT FirstName, 
       LastName, 
       Age,
       CASE 
           WHEN Age >= 35 THEN 'Old'
           WHEN Age BETWEEN 30 AND 35 THEN 'Young'
           ELSE 'Under 30'
       END
FROM Employees
WHERE Age IS NOT NULL;


SELECT FirstName, 
       LastName, 
       JobTitle, 
       Salary,
       CASE
           WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
           WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
           WHEN JobTitle = 'HR' THEN Salary + (Salary * .00001)
           ELSE Salary + (Salary * .03)
       END AS SalaryAfterRaise
FROM Employees;
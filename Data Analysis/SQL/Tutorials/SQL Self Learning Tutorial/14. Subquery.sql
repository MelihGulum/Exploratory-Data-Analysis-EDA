/*
	Subquery
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

DROP TABLE IF EXISTS EmployeesInfo
CREATE TABLE EmployeesInfo (EmployeeID int,
                            FirstName varchar(50),
                            LastName varchar(50),
                            Aliase varchar(50),
                            JobTitle varchar(50),
                            SeasonCount int
                            );

INSERT INTO EmployeesInfo VALUES
(1001, 'Jim', 'Halpert', 'Big Tuna', 'Salesman',  9),
(1002,  'Pam', 'Beasley', 'Pamcasso', 'Receptionist', 9),
(1003, 'Dwight', 'Schrute', 'D-Money', 'Salesman', 9),
(1004, 'Angela', 'Martin',  'Kitchen Witch', 'Accountant', 9),
(1005, 'Toby', 'Flenderson',  'Evil Snail', 'HR', 9),
(1006, 'Michael', 'Scott',  'Prison Mike', 'Regional Manager', 8),
(1007, 'Meredith', 'Palmer',  'Floozy', 'Supplier Relations', 9) ,
(1008, 'Stanley', 'Hudson',  'Stanley the Manly', 'Salesman', 9),
(1009, 'Kevin', 'Malone', 'Kool-Aid Man', 'Accountant', 9),
(1011, 'Holy', 'Flax', 'DJ Jazzy Flax',  'HR', 4);


--------------------------------------------------------------------------------------------------------------------------
-- Subquery
--------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT(JobTitle), -- How many employees have nicknames in each job?
       (SELECT COUNT(JobTitle)
        FROM EmployeesInfo AS I
        WHERE E.JobTitle = I.JobTitle) AS CountAliases
FROM Employees AS E


SELECT * -- Employees whose salaries are higher than the average salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary)
                FROM Employees);


SELECT DISTINCT(JobTitle) -- Jobs with 9 seasons
FROM Employees
WHERE JobTitle IN (SELECT JobTitle
                   FROM EmployeesInfo
                   WHERE SeasonCount = 9);




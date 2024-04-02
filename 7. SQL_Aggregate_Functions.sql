/*
	Aggregate Functions
	   COUNT(), SUM(), AVG(), MIN(), MAX()
*/

-- First, let's create the tables we will use.
DROP TABLE IF EXISTS Persons
CREATE TABLE Persons (PersonID int,
                      FirstName varchar(50),
					  LastName varchar(50),
					  Age int, 
					  Gender varchar(50),
					  JobTitle varchar(50),
					  Salary int,
					  OnVacation bit
					  );

INSERT INTO Persons VALUES
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
(1011, 'Holy', 'Flax', 32, 'Female', 'HR', 50000, 0),
(1012, 'Ryan', 'Howard', 30, 'Male', 'Receptionist', 36000, 0),
(1013, 'Andy', 'Bernard', 34, 'Male', 'Regional Manager', 65000, 0);


--------------------------------------------------------------------------------------------------------------------------
-- MIN - MAX
--------------------------------------------------------------------------------------------------------------------------
SELECT MAX(Salary) AS MAXSalary
FROM Persons;

-- with GROUP BY
SELECT JobTitle, 
       MIN(Salary) AS MINJobSalary
FROM Persons
GROUP BY JobTitle;


--------------------------------------------------------------------------------------------------------------------------
-- COUNT
--------------------------------------------------------------------------------------------------------------------------
SELECT JobTitle, 
       COUNT(*) AS EmpCount
FROM Persons
GROUP BY JobTitle
ORDER BY EmpCount DESC;


--------------------------------------------------------------------------------------------------------------------------
-- SUM
--------------------------------------------------------------------------------------------------------------------------
SELECT SUM(Salary)
FROM Persons

-- with Where Clause
SELECT SUM(Salary)
FROM Persons
WHERE JobTitle = 'Accountant';

-- with GROUP BY
SELECT JobTitle, SUM(Salary)
FROM Persons
GROUP BY JobTitle;


--------------------------------------------------------------------------------------------------------------------------
-- AVG
--------------------------------------------------------------------------------------------------------------------------
SELECT AVG(Age) AS AVGAge
FROM Persons;

SELECT JobTitle, 
       AVG(Salary) AS AVGJobSalary
FROM Persons
GROUP BY JobTitle;

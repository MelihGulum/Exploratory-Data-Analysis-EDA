/*
	PARTITION BY
	    The 'PARTITION BY' clause in SQL is a subclause of the 'OVER' clause. It's used to split a large table into smaller, more manageable partitions. 
	    Each partition is then processed for the function present in the 'OVER()' clause.
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
-- PARTITION BY
--------------------------------------------------------------------------------------------------------------------------
SELECT JobTitle, 
       Gender,
       COUNT(*) OVER (PARTITION BY JobTitle) AS EmpCount,
       AVG(Salary) OVER (PARTITION BY JobTitle) AS AVGSalary,
       MIN(Salary) OVER (PARTITION BY JobTitle) AS MINSalary,
       MAX(Salary) OVER (PARTITION BY JobTitle) AS MAXSalary,
       AVG(Age) OVER (PARTITION BY JobTitle) AS AVGAge
FROM Employees;


/* 'PARTITION BY' vs 'GROUP BY'
    While both 'PARTITION BY' and 'GROUP BY' can be used to partition data, there's a significant difference. 
   'GROUP BY' reduces the number of rows in the output, returning only a single row for each group. In contrast, 
   'PARTITION BY' keeps the original number of rows, but adds a new column with the aggregated value.
*/

SELECT JobTitle, 
       AVG(Salary) AS AVGSalary
FROM Employees
GROUP BY JobTitle;


SELECT JobTitle, 
       FirstName, 
       LastName, 
       AVG(Salary) OVER (PARTITION BY JobTitle) AS average_make,
       ROW_NUMBER() OVER (PARTITION BY JobTitle ORDER BY JobTitle ASC) AS Row	
FROM Employees;

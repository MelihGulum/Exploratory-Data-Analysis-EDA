/*
	CTE (Common Table Expression)
	    is a temporary named result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement.

	CTE vs Temporary Table
	    Temporary tables are genuine tables that support indexes and constraints. They remain available during the session and can be accessed by multiple users. 
		In contrast, CTEs are transient datasets that exist solely within a specific query and are only accessible during that query's execution.
*/


-- First, let's create the table we will use.
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int,
                        FirstName varchar(50),
                        LastName varchar(50),
                        Age int, 
                        Gender varchar(50),
                        JobTitle varchar(50),
                        Salary int,
                        OnVacation bit,
                        ManagerID INT NULL
                        );

INSERT INTO Employees VALUES
(1001, 'Jim', 'Halpert', 30, 'Male', 'Salesman', 45000, 1, 1006),
(1002, 'Pam', 'Beasley', 30, 'Female', 'Receptionist', 36000, 1, 1006),
(1003, 'Dwight', 'Schrute', 29, 'Male', 'Salesman', 63000, 1, 1006),
(1004, 'Angela', 'Martin', 31, 'Female', 'Accountant', 47000, 0, 1006),
(1005, 'Toby', 'Flenderson', 32, 'Male', 'HR', 50000, 0, 1006),
(1006, 'Michael', 'Scott', 35, 'Male', 'Regional Manager', 65000, 0, 1010),
(1007, 'Meredith', 'Palmer', 32, 'Female', 'Supplier Relations', 41000, 0, 1006),
(1008, 'Stanley', 'Hudson', 38, 'Male', 'Salesman', 48000, 1, 1006),
(1009, 'Kevin', 'Malone', 31, 'Male', 'Accountant', 42000, 0, 1006),
(1010, 'Jan', NULL, NULL, 'Female', 'Chief Executive Officer', 70000, 0, NULL),
(1011, 'Holy', 'Flax', 32, 'Female', 'Temp HR', 50000, 0, 1006),
(1012, 'Ryan', 'Howard', 30, 'Male', 'Temp Receptionist', 36000, 0, 1006),
(1013, 'Andy', 'Bernard', 34, 'Male', 'Regional Manager', 65000, 0, 1006);


--------------------------------------------------------------------------------------------------------------------------
-- CTE
--------------------------------------------------------------------------------------------------------------------------
WITH AVGSalary AS (SELECT JobTitle,
                          AVG(Salary) AS AVGSalary
                   FROM Employees
                   GROUP BY JobTitle)
SELECT *
FROM Employees AS E
    JOIN AVGSalary AS AVGS
        ON E.JobTitle = AVGS.JobTitle;


-- Multiple CTEs in One Query
WITH EmpSalesman AS (SELECT *
                     FROM Employees
                     WHERE JobTitle = 'Salesman'),
     EmpAccountant AS (SELECT *
                       FROM Employees
                       WHERE JobTitle = 'Accountant')
SELECT *
FROM EmpSalesman
UNION
SELECT *
FROM EmpAccountant;


-- Recursive CTE
-- Finding Bosses and Hierarchical Level for All Employees

WITH EmpHierarchy AS (SELECT EmployeeID, -- Anchor member
                             FirstName,
                             LastName,
                             ManagerID,
                             1 AS hierarchy_level
                      FROM Employees
                      WHERE ManagerID IS NULL  
                      UNION ALL
                      SELECT E.EmployeeID, -- Recursive member
                             E.FirstName,
                             E.LastName,
                             E.ManagerID,
                             hierarchy_level + 1
                      FROM Employees AS E
                          JOIN EmpHierarchy AS EH 
                              ON E.ManagerID = EH.EmployeeID -- Terminate condition
                     )
 
SELECT * 
FROM EmpHierarchy;


/*
	JOINS
	   INNER JOIN, LEFT (OUTER) JOIN, RIGHT (OUTER) JOIN, FULL (OUTER) JOIN, SELF JOIN, CROSS JOIN
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
-- INNER JOIN
-- JOIN and INNER JOIN will return the same result.
--------------------------------------------------------------------------------------------------------------------------
SELECT E.EmployeeID, 
       E.FirstName, 
       E.LastName, 
       I.SeasonCount
FROM Employees AS E
    INNER JOIN EmployeesInfo AS I
        ON E.EmployeeID = I.EmployeeID;

-- with WHERE Clause
SELECT E.FirstName, 
       E.LastName,
       E.Age,
       I.SeasonCount
FROM Employees AS E
    INNER JOIN EmployeesInfo AS I
        ON E.EmployeeID = I.EmployeeID
WHERE E.Age BETWEEN 30 AND 35;


--------------------------------------------------------------------------------------------------------------------------
-- LEFT JOIN
--------------------------------------------------------------------------------------------------------------------------
SELECT E.FirstName, 
       I.Aliase 
FROM Employees AS E
    LEFT JOIN EmployeesInfo AS I
        ON E.EmployeeID = I.EmployeeID;


--------------------------------------------------------------------------------------------------------------------------
-- RIGHT JOIN
--------------------------------------------------------------------------------------------------------------------------
SELECT E.EmployeeID, 
       E.FirstName
FROM Employees AS E
    RIGHT JOIN EmployeesInfo AS I
        ON E.EmployeeID = I.EmployeeID;


--------------------------------------------------------------------------------------------------------------------------
-- FULL JOIN
--------------------------------------------------------------------------------------------------------------------------
SELECT E.EmployeeID, 
       E.FirstName
FROM Employees AS E
    FULL JOIN EmployeesInfo AS I
        ON E.EmployeeID = I.EmployeeID;


--------------------------------------------------------------------------------------------------------------------------
-- SELF JOIN
-- The Self Join is used to join a table to itself as if the table were two tables. 
--------------------------------------------------------------------------------------------------------------------------

SELECT A.EmployeeID, --- The result displayed will list anyone who earns less than other.
       B.FirstName AS EarnsHigher,
       B.Salary AS HigherSalary,
       A.FirstName AS EarnsLesser,
       A.Salary AS LesserSalary
FROM Employees AS A, 
     Employees AS B
WHERE A.Salary < B.Salary


--------------------------------------------------------------------------------------------------------------------------
-- CROSS JOIN
-- Cross Join is a basic type of inner join that is used to retrieve the Cartesian product (or cross product) of two individual tables. 
-- That means, this join will combine each row of the first table with each row of second table (i.e. permutations).
--------------------------------------------------------------------------------------------------------------------------
SELECT E.FirstName,
       E.LastName,
       I.Aliase
FROM Employees AS E
CROSS JOIN EmployeesInfo as I
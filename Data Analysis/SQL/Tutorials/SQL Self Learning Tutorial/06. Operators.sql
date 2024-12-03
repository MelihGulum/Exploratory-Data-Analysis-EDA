/*
	Operators
	   Arithmetic Operators: +, - , / , *
	   Bitwise Operators: Bitwise AND, Bitwise OR, Bitwise XOR,
	   BOOLEAN
	   Comparison Operators: =, >, <, >=, <=, <>
	   Logical Operators AND, OR, LIKE, IN, ANY-ALL, NOT, IS NULL, IS NOT NULL, BETWEEN, EXISTS, UNION, INSTERSECT, EXCEPT
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
-- Arithmetic Operators
--------------------------------------------------------------------------------------------------------------------------
SELECT Salary, 
       CAST(Salary + (Salary * .10) AS INT) AS NewSalary
FROM Employees


--------------------------------------------------------------------------------------------------------------------------
-- BOOLEAN
--------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM Employees
WHERE OnVacation ='true';

-- Updating Boolean Values
UPDATE Employees
SET OnVacation = 'false' 
WHERE EmployeeID = 1001;


--------------------------------------------------------------------------------------------------------------------------
-- Comparison Operators
--------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM Employees
WHERE Salary <= 45000;


--------------------------------------------------------------------------------------------------------------------------
-- Logical Operators
--------------------------------------------------------------------------------------------------------------------------

-- AND-OR
SELECT FirstName, 
       LastName
FROM Employees
WHERE OnVacation = 'false' 
      AND (JobTitle = 'Salesman' OR JobTitle = 'Accountant');

/*
LIKE
Wild cards are used with the LIKE operator to search for specific patterns in strings
	% (Percent): Represents zero or more characters.
	_ (Underscore): Represents a single character.
	[] (Square Brackets): Represents any single character within brackets.
	– (Hyphen): Specify a range of characters inside brackets.
*/
SELECT *
FROM Employees
WHERE LastName LIKE 'S%';  -- Match strings that start with ‘S’

SELECT *
FROM Employees
WHERE LastName LIKE '%son%';  --Match strings that contain the substring ‘son’ in them at any position

-- IN
SELECT *
FROM Employees
WHERE JobTitle IN ('Salesman', 'Accountant');

SELECT *
FROM Employees
WHERE JobTitle NOT IN ('HR');  -- NOT IN

SELECT *   -- Subquery with IN Operator
FROM Employees
WHERE FirstName IN (SELECT FirstName 
                    FROM Employees
                    WHERE Salary > 48000);                    

-- ANY-ALL
-- ANY means that the condition will be true if the operation is true for any of the values in the range.
-- ALL means that the condition will be true only if the operation is true for all values in the range. 

SELECT *
FROM Employees
WHERE EmployeeID = ANY(SELECT EmployeeID
                       FROM Employees
                       WHERE Age > 30);

SELECT *
FROM Employees
WHERE EmployeeID <> ALL(SELECT EmployeeID
                        FROM Employees
                        WHERE Salary BETWEEN 40000 AND 50000);


-- NOT
-- The NOT operator is used in combination with other operators to give the opposite result, also called the negative result.
SELECT *
FROM Employees
WHERE JobTitle NOT IN ('HR', 'Salesman', 'Accountant');


-- IS NULL, IS NOT NULL
SELECT *
FROM Employees
WHERE AGE IS NULL;

SELECT *
FROM Employees
WHERE LastName IS NOT NULL;

SELECT COUNT(*) AS CountNullAge -- total number of NULL values in a column.
FROM Employees
WHERE AGE IS NULL;


-- BETWEEN
SELECT *
FROM Employees
WHERE Age BETWEEN 30 AND 35;

SELECT *  -- NOT BETWEEN Operator with IN
FROM Employees
WHERE Salary NOT BETWEEN 40000 AND 50000
      AND JobTitle IN ('Salesman');


-- EXISTS
SELECT *
FROM Employees
WHERE EXISTS (SELECT EmployeeID
              FROM EmployeesInfo
              WHERE Employees.EmployeeID = EmployeesInfo.EmployeeID 
                    AND Employees.JobTitle = 'Salesman' 
                    AND EmployeesInfo.SeasonCount = 9);


-- UNION
-- The SQL UNION operator is used to combine data from multiple tables by eliminating duplicate rows (if any)
--    The same number of columns selected with the same datatype.
--    These columns must also be in the same order.
--    They need not have same number of rows.
SELECT EmployeeID, 
       JobTitle 
FROM Employees
UNION
SELECT EmployeeID, 
       JobTitle 
FROM EmployeesInfo


-- INSTERSECT
SELECT EmployeeID, 
       FirstName, 
       LastName
FROM Employees
INTERSECT 
SELECT EmployeeID, 
       FirstName, 
       LastName
FROM EmployeesInfo;


-- EXCEPT
SELECT EmployeeID, 
       FirstName, 
       LastName
FROM Employees
EXCEPT 
SELECT EmployeeID, 
       FirstName, 
       LastName
FROM EmployeesInfo;
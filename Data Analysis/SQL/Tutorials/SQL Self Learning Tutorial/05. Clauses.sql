/*
	Clauses
	   WHERE, ORDER BY, GROUP BY, HAVING, FETCH
*/

-- First, let's create the table we will use.
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int,
                        FirstName varchar(50),
                        LastName varchar(50),
                        Age int, 
                        Gender varchar(50),
                        JobTitle varchar(50),
                        Salary int
                        );

INSERT INTO Employees VALUES
(1001, 'Jim', 'Halpert', 30, 'Male', 'Salesman', 45000),
(1002, 'Pam', 'Beasley', 30, 'Female', 'Receptionist', 36000),
(1003, 'Dwight', 'Schrute', 29, 'Male', 'Salesman', 63000),
(1004, 'Angela', 'Martin', 31, 'Female', 'Accountant', 47000),
(1005, 'Toby', 'Flenderson', 32, 'Male', 'HR', 50000),
(1006, 'Michael', 'Scott', 35, 'Male', 'Regional Manager', 65000),
(1007, 'Meredith', 'Palmer', 32, 'Female', 'Supplier Relations', 41000),
(1008, 'Stanley', 'Hudson', 38, 'Male', 'Salesman', 48000),
(1009, 'Kevin', 'Malone', 31, 'Male', 'Accountant', 42000),
(1010, 'Jan', NULL, NULL, 'Female', 'Chief Executive Officer', 70000);


--------------------------------------------------------------------------------------------------------------------------
-- WHERE
-- Operators that Can be Used with WHERE Clause
--    >, >=, <, <=, =, <>, BETWEEN, LIKE, IN, AND, OR
--------------------------------------------------------------------------------------------------------------------------

-- SELECT Statement
SELECT *
FROM Employees
WHERE Age = 30;

-- UPDATE Statement
UPDATE Employees
SET Age = 33, 
    LastName = 'Levinson'
WHERE EmployeeID = 1010;

-- DELETE Statement
DELETE FROM Employees
WHERE FirstName + ' ' + LastName = 'Toby Flenderson';

-- Logical Operators
SELECT FirstName, 
       LastName, 
       Age, 
       Gender
FROM Employees
WHERE Gender <> 'Male';

-- BETWEEN Operator
SELECT *
FROM Employees
WHERE Salary BETWEEN 45000 AND 50000;

-- LIKE Operator
-- The WHERE clause with LIKE operator allows us to filter rows that matches a specific pattern. 
-- This specific pattern is represented by wildcards (such as %, _, [] etc). 
SELECT *
FROM Employees
WHERE LastName LIKE 'S%';

-- IN, NOT IN Operator
SELECT FirstName, 
       Age
FROM Employees 
WHERE Age IN (29,35);

SELECT FirstName, 
       Age
FROM Employees 
WHERE Age NOT IN (29,35);

-- AND, OR Operators
SELECT *
FROM Employees
WHERE Salary > 45000 
      AND JobTitle = 'Salesman';

SELECT *
FROM Employees
WHERE Age = 30 
      OR Salary < 42000;

SELECT *
FROM Employees
WHERE (Age = 30 OR Salary < 42000) 
      AND (Gender = 'Female');


--------------------------------------------------------------------------------------------------------------------------
-- ORDER BY
-- The ORDER BY keyword is used to sort the result-set in ascending or descending order.
--    By default ORDER BY sorts the data in ascending order.
-- We can also sort the columns by order (starting from 1, not 0) instead of their names.
--------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM Employees
ORDER BY Salary;

SELECT * 
FROM Employees
ORDER BY Age DESC ;

-- Sort Multiple Columns
SELECT * 
FROM Employees
ORDER BY Age DESC, 
         Salary ASC;

-- Order Alphabetically
SELECT * 
FROM Employees
ORDER BY LastName;

-- Sorting By Column Order
SELECT * 
FROM Employees
ORDER BY 4; -- Age


--------------------------------------------------------------------------------------------------------------------------
-- GROUP BY
-- The GROUP BY is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()).
--------------------------------------------------------------------------------------------------------------------------

-- Single Column
SELECT JobTitle, 
       AVG(Salary) AS AVGSalary, 
       COUNT(EmployeeID) AS NumberOfEmployee
FROM Employees
GROUP BY JobTitle;

-- Multiple Columns
SELECT JobTitle, 
       Gender, 
       AVG(Salary) AS AVGSalary
FROM Employees
GROUP BY JobTitle, Gender;

-- with ORDER BY Clause
SELECT Gender, 
       AVG(Salary) AS AVGSalary
FROM Employees
GROUP BY Gender
ORDER BY AVGSalary DESC;

-- with WHERE Clause
SELECT JobTitle, 
       AVG(Salary) AS AVGSalary
FROM Employees
WHERE Age <= 35
GROUP BY JobTitle;

SELECT JobTitle, 
       Gender, 
       AVG(Salary) AS AVGSalary
FROM Employees
WHERE Gender = 'Female'
GROUP BY JobTitle, Gender;


--------------------------------------------------------------------------------------------------------------------------
-- HAVING
-- The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.
--------------------------------------------------------------------------------------------------------------------------
SELECT JobTitle, 
       AVG(Salary) AS AVGSalary
FROM Employees
GROUP BY JobTitle
HAVING  AVG(Salary) > 50000;

-- with ORDER BY Clause
SELECT JobTitle, 
       AVG(Salary) AS AVGSalary
FROM Employees
GROUP BY JobTitle
HAVING AVG(Salary) > 40000
ORDER BY 2 ASC;


--------------------------------------------------------------------------------------------------------------------------
-- FETCH
-- The FETCH is used to skip a specific number of rows before returning the result set. 
-- The 'OFFSET number ROWS' clause skips a certain number of rows specified by 'number'.
--------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM Employees
ORDER BY Salary OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY;
/*
	Table Constraints: SQL constraints are used to specify rules for the data in a table.
	The following constraints are commonly used in SQL:
	  NOT NULL, UNIQUE, PRIMARY KEY, 
	  FOREIGN KEY, CHECK, DEFAULT, CREATE INDEX
*/

--------------------------------------------------------------------------------------------------------------------------
-- NOT NULL
-- Built-in stored procedures can be used to check nullability. (EXEC sp_columns Persons;)  
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int NOT NULL,
                        LastName varchar(50) NOT NULL,
                        FirstName varchar(50) NOT NULL,
                        Age int, 
                        Gender varchar(50),
                        City varchar(50)
                        );

-- NOT NULL on ALTER TABLE
ALTER TABLE Employees
ALTER COLUMN Age int NOT NULL;


--------------------------------------------------------------------------------------------------------------------------
-- UNIQUE 
-- To check unique columns: 
--	  1. SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
--       WHERE table_name = 'table_name';
--    2. SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
--       WHERE table_name='table_name';
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int NOT NULL UNIQUE,
                        LastName varchar(50) NOT NULL,
                        FirstName varchar(50) NOT NULL,
                        Age int, 
                        Gender varchar(50),
                        City varchar(50)
                        );


-- UNIQUE Constraint on ALTER TABLE
ALTER TABLE Employees
ADD UNIQUE (FirstName, LastName); -- Define multiple/single column

ALTER TABLE Employees
ADD CONSTRAINT UC_Employee UNIQUE (Age); -- Name UNIQUE Constraint


-- Drop UNIQUE Constraint
ALTER TABLE Employees
DROP CONSTRAINT UC_Employee; -- Drop the named constraint column.

ALTER TABLE Employees
DROP CONSTRAINT UQ__Employee__2457AEF0D23DBE0D; -- Drop with unique Constraint Name


--------------------------------------------------------------------------------------------------------------------------
-- DEFAULT  
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int NOT NULL,
                        LastName varchar(50) NOT NULL,
                        FirstName varchar(50) NOT NULL,
                        Age int, 
                        Gender varchar(50),
                        City varchar(50) CONSTRAINT df_City DEFAULT 'Scranton'
                        );

INSERT INTO Employees VALUES (1001, 'Jim', 'Halpert', 30, 'Male', DEFAULT);

-- DROP a DEFAULT Constraint
ALTER TABLE Employees
DROP CONSTRAINT df_City;

-- DEFAULT on ALTER TABLE
ALTER TABLE Employees
ADD CONSTRAINT df_City
DEFAULT 'Stamford' FOR City;


--------------------------------------------------------------------------------------------------------------------------
-- PRIMARY Key
-- Primary keys must contain UNIQUE values, and cannot contain NULL values.
-- To check Primary keys: 
--	  1. SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
--       WHERE table_name = 'table_name';  
--    2. EXEC sp_fkeys 'Table'
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int NOT NULL,
                        LastName varchar(50) NOT NULL,
                        FirstName varchar(50) NOT NULL,
                        Age int, 
                        Gender varchar(50),
                        City varchar(50) ,
                        CONSTRAINT PK_Employee PRIMARY KEY (EmployeeID, LastName)
                        );

-- DROP a PRIMARY KEY Constraint
ALTER TABLE Employees
DROP CONSTRAINT PK_Employee;

-- PRIMARY KEY on ALTER TABLE
ALTER TABLE Employees
ADD CONSTRAINT PK_Employee PRIMARY KEY (EmployeeID, LastName);


--------------------------------------------------------------------------------------------------------------------------
-- FOREIGN Key
-- FOREIGN Key constraint maps with a column in another table and uniquely identifies a row/record in that table.
-- To check Foreign Keys:
--     EXEC sp_fkeys 'Table1'
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Customers
CREATE TABLE Customers(ID INT NOT NULL,
                       NAME VARCHAR (20) NOT NULL,
                       AGE INT NOT NULL,
                       ADDRESS CHAR (25),
                       SALARY DECIMAL (18, 2),       
                       CONSTRAINT PK_Customer PRIMARY KEY (ID)
                       );

DROP TABLE IF EXISTS Orders
CREATE TABLE Orders (ID INT NOT NULL,
                     DATE DATETIME, 
                     CUSTOMER_ID INT,
                     AMOUNT DECIMAL,
                     CONSTRAINT FK_Customer FOREIGN KEY(CUSTOMER_ID) REFERENCES Customers(ID),
                     CONSTRAINT PK_Order PRIMARY KEY (ID)
                     );


EXEC sp_fkeys 'Customers'

-- DROP a FOREIGN KEY Constraint
ALTER TABLE Orders
DROP CONSTRAINT FK_Customer;

-- FOREIGN KEY on ALTER TABLE
ALTER TABLE Orders
ADD CONSTRAINT FK_Customer
FOREIGN KEY (ID) REFERENCES Persons(ID);


--------------------------------------------------------------------------------------------------------------------------
-- CHECK Constraint 
-- The CHECK constraint is used to add conditions on a column of a table.
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int NOT NULL,
                        LastName varchar(50) NOT NULL,
                        FirstName varchar(50),
                        Age int,
                        Gender varchar(50),
                        City varchar(50),
                        CONSTRAINT CHK_Employee CHECK (Age>=18 AND City='Scranton')
                        );

-- DROP a CHECK Constraint
ALTER TABLE Employees
DROP CONSTRAINT CHK_Employee;

-- CHECK on ALTER TABLE
ALTER TABLE Employees
ADD CONSTRAINT CHK_Employee
CHECK (Age>=18);


--------------------------------------------------------------------------------------------------------------------------
-- INDEX Constraint
-- The INDEX constraints are created to speed up the data retrieval from the database.
-- There are various types of indexes that can be created using the CREATE INDEX statement. They are:
--     Unique Index
--     Single-Column Index
--     Composite Index
--     Implicit Index
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int NOT NULL,
                        LastName varchar(50) NOT NULL,
                        FirstName varchar(50) NOT NULL,
                        Age int, 
                        Gender varchar(50),
                        City varchar(50)
                        );

CREATE INDEX idx_lastname
ON Employees (LastName); -- You can create an index on a single or multiple columns.

-- SHOW INDEX 
EXEC sp_helpindex 'Employees'

-- DROP INDEX Statement
DROP INDEX IF EXISTS Employees.idx_lastname;

DROP INDEX IF EXISTS idx_lastname ON Employees;

ALTER TABLE Employees
DROP INDEX idx_lastname;
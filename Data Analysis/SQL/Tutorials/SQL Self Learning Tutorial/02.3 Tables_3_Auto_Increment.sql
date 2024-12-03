/*
	AUTO INCREMENT
	Auto Increment is used to automatically add unique sequential values into a column of a table.
*/

--------------------------------------------------------------------------------------------------------------------------
-- AUTO INCREMENT
--     IDENTITY [(seed, increment)]
--         seed: It sets the starting value for the auto-incrementing column.
--         increment: It specifies how much the value increases by for each new row.
--------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (EmployeeID int IDENTITY(1, 1) PRIMARY KEY,
                        LastName varchar(50) NOT NULL,
                        FirstName varchar(50) NOT NULL,
                        Age int, 
                        Gender varchar(50),
                        City varchar(50)
                        );

INSERT INTO Employees VALUES 
('Jim', 'Halpert', 30, 'Male', 'Scranton'),
('Pam', 'Beasley', 30, 'Female', 'Scranton');


/*
	WHERE Statement
	=, <>, <, >, And, Or, Like, Null, Not Null, In
*/

--------------------------------------------------------------------------------------------------------------------------
-- Equal
SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim'


--------------------------------------------------------------------------------------------------------------------------
-- Not Equal
SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim'


--------------------------------------------------------------------------------------------------------------------------
-- Greater Than, Less Than
-- Greater Than or Equal to, Less Than or Equal to
SELECT * 
FROM EmployeeDemographics
WHERE Age > 30

SELECT * 
FROM EmployeeDemographics
WHERE Age >= 30

SELECT * 
FROM EmployeeDemographics
WHERE Age < 32

SELECT * 
FROM EmployeeDemographics
WHERE Age <= 32


--------------------------------------------------------------------------------------------------------------------------
-- The AND operator displays a record if all the conditions are TRUE.
-- The WHERE clause can contain one or many AND operators.
SELECT * 
FROM EmployeeDemographics
WHERE Age <= 32 AND Gender = 'Male'


--------------------------------------------------------------------------------------------------------------------------
-- The OR operator displays a record if any of the conditions are TRUE.
SELECT * 
FROM EmployeeDemographics
WHERE Age <= 32 OR Gender = 'Male'


--------------------------------------------------------------------------------------------------------------------------
-- The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.
-- There are two wildcards often used in conjunction with the LIKE operator:
-- %	Represents zero or more characters
-- _	Represents a single character
-- []	Represents any single character within the brackets 
-- ^	Represents any character not in the brackets 
-- -	Represents any single character within the specified range 
-- {}	Represents any escaped character 

-- Will only return last names starting with 'S'
SELECT * 
FROM EmployeeDemographics
WHERE LastName LIKE 'S%'

-- '%S%' on the other hand this will return people with 'S' in their last name.
SELECT * 
FROM EmployeeDemographics
WHERE LastName LIKE '%S%'


--------------------------------------------------------------------------------------------------------------------------
-- NULL and NOT NULL

SELECT * 
FROM EmployeeDemographics
WHERE LastName IS NULL

SELECT * 
FROM EmployeeDemographics
WHERE LastName IS NOT NULL


--------------------------------------------------------------------------------------------------------------------------
-- The IN operator allows you to specify multiple values in a WHERE clause.
-- The IN operator is a shorthand for multiple OR conditions.

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael', 'Dwight')
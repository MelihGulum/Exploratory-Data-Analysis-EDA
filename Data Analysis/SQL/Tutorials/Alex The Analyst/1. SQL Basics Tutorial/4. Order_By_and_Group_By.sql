/*
	Group By, Order By
*/

-- The GROUP BY statement groups rows that have the same values into summary rows.
-- The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.

SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics
GROUP BY Gender


--------------------------------------------------------------------------------------------------------------------------
-- Group By with multiple column
SELECT Gender, Age, COUNT(Gender)
FROM EmployeeDemographics
GROUP BY Gender, Age


--------------------------------------------------------------------------------------------------------------------------
-- We can also use where statement with Group By.
SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics
WHERE Age > 31 
GROUP BY Gender

SELECT Gender, MAX(Age)
FROM EmployeeDemographics
GROUP BY Gender


--------------------------------------------------------------------------------------------------------------------------
-- The ORDER BY keyword is used to sort the result-set in ascending or descending order.
-- To sort the table reverse alphabetically, use the DESC keyword

SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31 
GROUP BY Gender
ORDER BY CountGender


--------------------------------------------------------------------------------------------------------------------------
-- Order By with multiple column
SELECT * 
FROM EmployeeDemographics
ORDER BY Gender, Age

SELECT * 
FROM EmployeeDemographics
ORDER BY Gender DESC, Age ASC


--------------------------------------------------------------------------------------------------------------------------
-- In ORDER BY,	We can order by index instead of column names.
-- Index starts with 1

SELECT * 
FROM EmployeeDemographics
ORDER BY 4 DESC

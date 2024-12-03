/*
	Case Statement
*/
-- The CASE expression goes through conditions and returns a value when the first condition is met (like an if-then-else statement). 
-- So, once a condition is true, it will stop reading and return the result. If no conditions are true, it returns the value in the ELSE clause.

-- If there is no ELSE part and no conditions are true, it returns NULL.


SELECT FirstName, LastName, Age,
	CASE
		WHEN Age > 30 THEN 'Old'
		ELSE 'Young'
	END
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age


--------------------------------------------------------------------------------------------------------------------------
-- Multiple condition
SELECT FirstName, LastName, Age,
	CASE
		WHEN Age > 30 THEN 'Old'
		WHEN Age BETWEEN 27 AND 30 THEN 'Young'
		ELSE 'Under 27'
	END
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age


--------------------------------------------------------------------------------------------------------------------------
-- If there is more than one condition, returns a value when the first condition is met.
SELECT FirstName, LastName, Age,
	CASE
		WHEN Age > 30 THEN 'Old'
		WHEN Age = 38 THEN 'Stanley'
		ELSE 'Under 27'
	END
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age

SELECT FirstName, LastName, Age,
	CASE
		WHEN Age = 38 THEN 'Stanley'
		WHEN Age > 30 THEN 'Old'
		ELSE 'Under 27'
	END
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age


SELECT FirstName, LastName, JobTitle, Salary,
	CASE
		WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
		WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
		WHEN JobTitle = 'HR' THEN Salary + (Salary * .00001)
		ELSE Salary + (Salary * .03)
	END AS SalaryAfterRaise
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
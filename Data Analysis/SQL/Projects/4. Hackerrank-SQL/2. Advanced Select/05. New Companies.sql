/* The tables are described as follows:
	
     Company Table:
		+-------------+------------+
		| Field       |   Type     |
		+-------------+------------+
		| company_name| STRING     |
		| founder     | STRING     |
		+-------------+------------+ 

     Lead_Manager:
		+------------------+------------+
		| Field            |   Type     |
		+------------------+------------+
		| lead_manager_code| STRING     |
		| company_code     | STRING     |
		+------------------+------------+ 

     Senior_Manager
		+--------------------+------------+
		| Field              |   Type     |
		+--------------------+------------+
		| senior_manager_code| STRING     |
		| lead_manager_code  | STRING     |
		| company_code       | STRING     |
		+--------------------+------------+ 
     
	 Manager
		+--------------------+------------+
		| Field              |   Type     |
		+--------------------+------------+
		| manager_code       | STRING     |
		| senior_manager_code| STRING     |
		| lead_manager_code  | STRING     |
		| company_code       | STRING     |
		+--------------------+------------+ 

     Employee
		+--------------------+------------+
		| Field              |   Type     |
		+--------------------+------------+
		| employee_code      | STRING     |
		| manager_code       | STRING     |
		| senior_manager_code| STRING     |
		| lead_manager_code  | STRING     |
		| company_code       | STRING     |
		+--------------------+------------+ 

   Write a query to print the company_code, founder name, total number of lead managers, 
   total number of senior managers, total number of managers, and total number of employees. 
   Order your output by ascending company_code. */

SELECT c.company_code,
       c.founder,
       COUNT(DISTINCT lm.lead_manager_code),
       COUNT(DISTINCT sm.senior_manager_code),
       COUNT(DISTINCT m.manager_code),
       COUNT(DISTINCT e.employee_code)
FROM company AS c
    JOIN lead_manager AS lm
        ON c.company_code = lm.company_code
    JOIN senior_manager AS sm
        ON c.company_code = sm.company_code
    JOIN manager AS m
        ON c.company_code = m.company_code
    JOIN employee AS e
        ON c.company_code = e.company_code
GROUP BY c.company_code, 
         c.founder
ORDER BY c.company_code;


-- Solution 2
SELECT c.company_code,
       c.founder,
       count(distinct lm.lead_manager_code),
       count(distinct sm.senior_manager_code),
       count(distinct m.manager_code), 
       count(distinct e.employee_code)
FROM Company c, 
     Lead_Manager lm, 
     Senior_Manager sm, 
     Manager m, 
     Employee e
WHERE c.company_code=lm.company_code 
    AND lm.lead_manager_code = sm.lead_manager_code 
    AND sm.senior_manager_code = m.senior_manager_code 
    AND m.manager_code = e.manager_code
GROUP BY c.company_code,
         c.founder
ORDER BY c.company_code ASC
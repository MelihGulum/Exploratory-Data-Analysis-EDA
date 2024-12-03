/* The Projects table is described as follows: 

		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| Task_ID     | INTEGER  |
		| Start_Date  | DATE     |
		| End_Date    | DATE     |
		+-------------+----------+

   Write a query to output the start and end dates of projects listed by the number of days 
       it took to complete the project in ascending order. 
   If there is more than one project that have the same number of completion days, 
       then order by the start date of the project.  */

SELECT MIN(start_date), 
       MAX(end_date)
FROM (SELECT start_date, 
             end_date, 
             SUM(flag) OVER(ORDER BY start_date) AS grp
      FROM (SELECT task_id, 
                   start_date, 
                   end_date,
                   CASE 
                       WHEN LAG(end_date) OVER(ORDER BY start_date) = start_date THEN 0 
                       ELSE 1 
                   END AS flag
            FROM Projects
            ) t1
      ) t2
GROUP BY grp
ORDER BY DATEDIFF(dd, MIN(start_date), MAX(end_date)), 
         MIN(start_date);
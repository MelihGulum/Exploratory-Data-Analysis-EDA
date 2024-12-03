/* The tables are described as follows: 

    Students:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| ID          | Integer  |
		| Name        | String   |
		| Marks       | Integer  |
		+-------------+----------+

    Grades:
		+-------+----------+----------+
		| Grade | Min_Mark | Max_Mark |
		+-------+----------+----------+
		| 1     | 0        | 9        |
		| 2     | 10       | 19       |
		| 3     | 20       | 29       |
		| 4     | 30       | 39       |
		| 5     | 40       | 49       |
		| 6     | 50       | 59       |
		| 7     | 60       | 69       |
		| 8     | 70       | 79       |
		| 9     | 80       | 89       |
		| 10    | 90       | 100      | 
		+-------+----------+----------+

    Ketty gives Eve a task to generate a report containing three columns: 
        Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8.
    The report must be in descending order by grade -- i.e. higher grades are entered first. 
    If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. 
    Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order.
    If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

    Write a query to help Eve. */

SELECT CASE
           WHEN g.grade > 7 THEN s.name
           ELSE NULL
       END AS names,
       g.grade,
       s.marks
FROM students AS s
    JOIN grades AS g
        ON marks BETWEEN Min_Mark AND Max_Mark
ORDER BY grade DESC, 
         name,
         marks;
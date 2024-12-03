/* The tables are described as follows: 

    Hackers:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| hacker_id   | Integer  |
		| name        | String   |
		+-------------+----------+

    Challanges:
		+------------------+----------+
		| Field            | Type     |
		+------------------+----------+
		| challange_id     | Integer  |
		| hacker_id        | Integer  |
		+------------------+----------+

    Julia asked her students to create some coding challenges. 
    Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
    Sort your results by the total number of challenges in descending order. 
    If more than one student created the same number of challenges, then sort the result by hacker_id. 
    If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, 
        then exclude those students from the result. */ 

SELECT hacker_id, 
       name, 
       c_cnt                     
FROM (SELECT hacker_id, 
             name, 
             c_cnt,
             COUNT(*) OVER(PARTITION BY c_cnt) AS same_cnt,    
             MAX(c_cnt) OVER() AS max_cnt                
      FROM (SELECT h.hacker_id, 
                   h.name, 
                   COUNT(*) AS c_cnt
            FROM Hackers AS h
                JOIN Challenges AS c 
                    ON h.hacker_id = c.hacker_id
            GROUP BY h.hacker_id, h.name
            ) t1
      ) t2
WHERE c_cnt = max_cnt                        
     OR  (c_cnt != max_cnt AND same_cnt = 1)                
ORDER BY c_cnt DESC, 
         hacker_id;  
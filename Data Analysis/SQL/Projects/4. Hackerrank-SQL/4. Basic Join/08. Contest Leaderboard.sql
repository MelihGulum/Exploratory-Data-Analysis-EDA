/* The tables are described as follows: 

    Hackers:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| hacker_id   | Integer  |
		| name        | String   |
		+-------------+----------+

    Submission:
		+---------------+----------+
		| Field         | Type     |
		+---------------+----------+
		| submission_id | Integer  |
		| hacker_id     | Integer  |
		| challange_id  | Integer  |
                | score         | Integer  |
		+---------------+----------+

    You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!

    The total score of a hacker is the sum of their maximum scores for all of the challenges. 
    Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
    If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
    Exclude all hackers with a total score of 0 from your result. */

SELECT s.hacker_id, 
       h.name, 
       SUM(max_score)
FROM (SELECT hacker_id, 
             challenge_id, 
             MAX(score) AS max_score
      FROM Submissions
      GROUP BY hacker_id, 
               challenge_id
      ) s
    JOIN Hackers AS h 
        ON s.hacker_id = h.hacker_id
GROUP BY s.hacker_id, 
         h.name
HAVING SUM(max_score) > 0
ORDER BY SUM(max_score) DESC, 
         hacker_id;
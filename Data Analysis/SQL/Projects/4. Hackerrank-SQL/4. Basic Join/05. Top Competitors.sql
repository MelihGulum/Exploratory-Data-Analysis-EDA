/* The tables are described as follows: 

    Hackers:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| hacker_id   | Integer  |
		| name        | String   |
		+-------------+----------+

    Difficulty:
		+------------------+----------+
		| Field            | Type     |
		+------------------+----------+
		| difficulty_level | Integer  |
		| score            | Integer  |
		+------------------+----------+

    Challanges:
		+------------------+----------+
		| Field            | Type     |
		+------------------+----------+
		| challange_id     | Integer  |
		| hacker_id        | Integer  |
		| difficulty_level | Integer  |
		+------------------+----------+

    Submission:
		+---------------+----------+
		| Field         | Type     |
		+---------------+----------+
		| submission_id | Integer  |
		| hacker_id     | Integer  |
		| challange_id  | Integer  |
                | score         | Integer  |
		+---------------+----------+

    Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard!
    Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
    Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
    If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id. */

SELECT h.hacker_id ,
       h.name 
FROM Submissions AS  s
    INNER JOIN Challenges AS c 
        ON s.challenge_id = c.challenge_id
    INNER JOIN Difficulty AS d 
        ON  c.difficulty_level = d.difficulty_level
    INNER JOIN Hackers AS h 
        ON h.hacker_id = s.hacker_id
WHERE s.score = d.score
GROUP BY h.hacker_id,
         h.name
HAVING COUNT(s.hacker_id) > 1
ORDER BY COUNT(s.score) DESC,
         h.hacker_id  
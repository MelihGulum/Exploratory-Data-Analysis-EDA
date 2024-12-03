/* The tables are described as follows: 

    Contests:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| contest_id  | Integer  |
		| hacker_id   | Integer  |
		| name        | String   |
		+-------------+----------+

    Colleges:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| college_id  | Integer  |
		| contest_id  | Integer  |
		+-------------+----------+

    Challanges:
		+--------------+----------+
		| Field        | Type     |
		+--------------+----------+
		| challange_id | Integer  |
		| college_id   | Integer  |
		+--------------+----------+

    View_Stats:
		+-------------------+----------+
		| Field             | Type     |
		+-------------------+----------+
		| challange_id      | Integer  |
		| total_view        | Integer  |
		| total_unique_view | Integer  |
		+-------------------+----------+

    Submission_Stats:
		+----------------------------+----------+
		| Field                      | Type     |
		+----------------------------+----------+
		| challange_id               | Integer  |
		| total_submissions          | Integer  |
		| total_accepted_submissions | Integer  |
		+----------------------------+----------+

    Samantha interviews many candidates from different colleges using coding challenges and contests. 
    Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, 
        total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. 
    Exclude the contest from the result if all four sums are 0. */

SELECT con.contest_id, 
       con.hacker_id, 
       con.name,
       SUM(sg.total_submissions),
       SUM(sg.total_accepted_submissions),
       SUM(vg.total_views), 
       SUM(vg.total_unique_views)
FROM Contests AS con
    JOIN Colleges AS col 
        ON con.contest_id = col.contest_id
    JOIN Challenges AS cha 
        ON cha.college_id = col.college_id
    LEFT JOIN (SELECT ss.challenge_id, 
                      SUM(ss.total_submissions) AS total_submissions, 
                      SUM(ss.total_accepted_submissions) AS total_accepted_submissions 
               FROM Submission_Stats AS ss GROUP BY ss.challenge_id
               ) AS sg
        ON cha.challenge_id = sg.challenge_id
    LEFT JOIN (SELECT vs.challenge_id, 
                      SUM(vs.total_views) AS total_views, 
                      SUM(vs.total_unique_views) AS total_unique_views
               FROM View_Stats AS vs 
               GROUP BY vs.challenge_id
               ) AS vg
        ON cha.challenge_id = vg.challenge_id
GROUP BY con.contest_id, 
         con.hacker_id, 
         con.name
HAVING SUM(sg.total_submissions) +
       SUM(sg.total_accepted_submissions) +
       SUM(vg.total_views) +
       SUM(vg.total_unique_views) > 0
ORDER BY con.contest_id;

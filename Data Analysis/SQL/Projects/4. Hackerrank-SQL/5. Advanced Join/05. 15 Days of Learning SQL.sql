/* The tables are described as follows: 

    Hackers:
		+-------------+----------+
		| Field       | Type     |
		+-------------+----------+
		| hacker_id   | Integer  |
		| name        | String   |
		+-------------+----------+

    Submission:
		+-----------------+----------+
		| Field           | Type     |
		+-----------------+----------+
		| submission_date | Date     |
		| submission_id   | Integer  |
		| hacker_id       | Integer  |
                | score           | Integer  |
		+-----------------+----------+

    Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.

    Write a query to print total number of unique hackers who made at least 1 submission each day (starting on the first day of the contest), 
        and find the hacker_id and name of the hacker who made maximum number of submissions each day. 
    If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
    The query should print this information for each day of the contest, sorted by the date. */

WITH ConsistentHackers AS (SELECT s.submission_date,
                                  s.hacker_id
                           FROM Submissions AS s
                           WHERE s.submission_date = '2016-03-01'
                           UNION ALL
                           SELECT DATEADD(dd,1,ch.submission_date),
                                  s.hacker_id
                           FROM Submissions s
                           JOIN ConsistentHackers ch
                               ON s.hacker_id = ch.hacker_id
                                   AND s.submission_date = DATEADD(dd,1,ch.submission_date)
                           ),
      ConsistencyCounts AS (SELECT ch.submission_date,
                                   COUNT(DISTINCT ch.hacker_id) AS ConsistentHackers
                            FROM ConsistentHackers ch
                            GROUP BY ch.submission_date
                            ),
      SubmissionsSummary AS (SELECT s.submission_date,
                                    s.hacker_id,
                                    ROW_NUMBER() OVER (PARTITION BY s.submission_date ORDER BY COUNT(*) DESC, s.hacker_id) AS ranking
                             FROM Submissions s
                             GROUP BY s.submission_date, 
                                      s.hacker_id)

SELECT ss.submission_date,
       cc.ConsistentHackers,
       h.hacker_id,
       h.name
FROM SubmissionsSummary AS ss
    JOIN ConsistencyCounts AS cc
        ON ss.submission_date = cc.submission_date
            AND ss.ranking = 1
    JOIN Hackers AS h
        ON ss.hacker_id = h.hacker_id
ORDER BY ss.submission_date;

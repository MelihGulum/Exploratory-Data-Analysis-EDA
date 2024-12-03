-- How many movies and shows are in the dataset and list the titles?
SELECT 'MOVIE' AS type, 
       COUNT(*) AS Movie_count
FROM NetflixTitles
WHERE type = 'MOVIE'
UNION
SELECT 'SHOW' AS type, 
       COUNT(*) AS Show_count
FROM NetflixTitles
WHERE type = 'SHOW'


-- How many movies/shows are released each year?
SELECT release_year, 
       COUNT(*) 
FROM NetflixTitles
GROUP BY release_year
ORDER BY 1


-- Which Movie is the longest and which one is the shortest runtime?
SELECT 'Longest Runtime' AS type, 
       title, 
       runtime
FROM NetflixTitles
WHERE runtime = (SELECT MAX(runtime) 
                 FROM NetflixTitles
                 WHERE type = 'MOVIE')
UNION
SELECT TOP 1 'Shortest Runtime' AS type, 
             title, 
             runtime
FROM NetflixTitles
WHERE runtime = (SELECT MIN(runtime) 
                 FROM NetflixTitles
                 WHERE runtime <> 0
                     AND type = 'MOVIE')


-- Which Show is the longest and which one is the shortest runtime?
SELECT 'Longest Runtime' AS type, 
       title, 
       runtime
FROM NetflixTitles
WHERE runtime = (SELECT MAX(runtime) 
                 FROM NetflixTitles
                 WHERE type = 'SHOW')
UNION
SELECT TOP 1 'Shortest Runtime' AS type, 
             title, 
             runtime
FROM NetflixTitles
WHERE runtime = (SELECT MIN(runtime) 
                 FROM NetflixTitles
                 WHERE runtime <> 0
                     AND type = 'SHOW')


-- What is the average runtime of each type by age certification?
SELECT type, 
       age_certification, 
       AVG(runtime) AS AVG_runtime
FROM NetflixTitles
GROUP BY type, 
         age_certification


-- How many movies in each Imdb Score?
SELECT imdb_score, 
       COUNT(*)
FROM NetflixTitles
GROUP BY imdb_score
ORDER BY 1 DESC


-- Analyse of Seasons Netflix Shows/Serie
SELECT seasons, 
       COUNT(title) AS count_of_show
FROM NetflixTitles
WHERE type = 'SHOW'
GROUP BY seasons
ORDER BY 1

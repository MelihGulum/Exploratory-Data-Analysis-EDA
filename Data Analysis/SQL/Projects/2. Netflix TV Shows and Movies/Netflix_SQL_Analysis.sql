-- What were the top 10 movies according to IMDB score?
SELECT DISTINCT(type)
FROM NetflixTitles


SELECT TOP 10 title, 
              type, 
              imdb_score
FROM NetflixTitles
WHERE type = 'MOVIE'
ORDER BY imdb_score DESC


-- What were the top 10 shows according to IMDB score? 
SELECT TOP 10 title, 
              type, 
              imdb_score
FROM NetflixTitles
WHERE type = 'SHOW'
ORDER BY imdb_score DESC


-- What were the bottom 10 movies according to IMDB score? 
SELECT TOP 10 title, 
              type, 
              imdb_score
FROM NetflixTitles
WHERE type = 'MOVIE' 
    AND imdb_score IS NOT NULL
ORDER BY imdb_score ASC



-- What were the bottom 10 shows according to IMDB score? 
SELECT TOP 10 title, 
              type, 
              imdb_score
FROM NetflixTitles
WHERE type = 'SHOW' 
    AND imdb_score IS NOT NULL
ORDER BY imdb_score ASC


-- What were the average IMDB and TMDB scores for shows and movies? 
SELECT type, 
       ROUND(AVG(imdb_score), 2) AS AVG_imdb_score,
       ROUND(AVG(tmdb_score), 2) AS AVG_tmbd_score
FROM NetflixTitles
GROUP BY type


-- Count of movies and shows in each decade
SELECT (release_year / 10 * 10) AS Decade,
       COUNT(*) AS total_movie_show
FROM NetflixTitles
GROUP BY (release_year / 10)
ORDER BY Decade 


-- What were the average IMDB and TMDB scores for each production country?
SELECT production_countries,
       ROUND(AVG(imdb_score), 2) AS AVG_imdb_score,
       ROUND(AVG(tmdb_score), 2) AS AVG_tmbd_score
FROM NetflixTitles
GROUP BY production_countries
ORDER BY 2 DESC


-- What were the average IMDB and TMDB scores for each age certification for shows and movies?
SELECT age_certification,
       ROUND(AVG(imdb_score), 2) AS AVG_imdb_score,
       ROUND(AVG(tmdb_score), 2) AS AVG_tmbd_score
FROM NetflixTitles
GROUP BY age_certification
ORDER BY 2 DESC

-- What were the 5 most common age certifications for movies?
SELECT TOP 5 age_certification, 
             COUNT(*) AS 'COUNT'
FROM NetflixTitles
WHERE type = 'MOVIE'
GROUP BY age_certification
ORDER BY 2 DESC

-- Who were the top 20 actors that appeared the most in movies/shows? 
SELECT TOP 20 name, 
              COUNT(*) AS Apperance
FROM NetflixCredits
WHERE role = 'ACTOR'
GROUP BY name
ORDER BY 2 DESC


-- Who were the top 20 directors that directed the most movies/shows? 
SELECT TOP 20 name, 
              COUNT(*) AS Apperance
FROM NetflixCredits
WHERE role = 'DIRECTOR'
GROUP BY name
ORDER BY 2 DESC


-- Calculating the average runtime of movies and TV shows separately (Hint: Union)
SELECT 'MOVIE' AS type, 
       AVG(runtime) AS AVG_Runtime
FROM NetflixTitles
WHERE type = 'MOVIE'
UNION
SELECT 'SHOW' AS type, 
       AVG(runtime) AS AVG_Runtime
FROM NetflixTitles
WHERE type = 'SHOW'


-- Finding the titles and  directors of movies released on or after 2010
SELECT t.title, 
       t.release_year, 
       c.role
FROM NetflixCredits AS c
    JOIN NetflixTitles AS t
        ON c.id = t.id
WHERE c.role = 'DIRECTOR'
    AND type = 'MOVIE'
    AND t.release_year >= 2010
ORDER BY 2


-- Which shows on Netflix have the most seasons?
SELECT TOP 20 title, 
              seasons
FROM NetflixTitles
WHERE type = 'SHOW'
ORDER BY 2 DESC


-- Which genres had the most movies? 
SELECT TOP 20 genres, 
              COUNT(*) AS 'COUNT'
FROM NetflixTitles
WHERE type = 'MOVIE'
GROUP BY genres
ORDER BY 2 DESC


-- Which genres had the most shows? 
SELECT TOP 20 genres, 
              COUNT(*) AS 'COUNT'
FROM NetflixTitles
WHERE type = 'SHOW'
GROUP BY genres
ORDER BY 2 DESC


-- Titles and Directors of movies with high IMDB scores (>7.5) and high TMDB popularity scores (>80) 
SELECT t.title, 
       MAX(t.imdb_score) AS imdb_score, 
       MAX(t.tmdb_score) AS tmbd_score, 
       STRING_AGG(CONCAT(name, ','), ', ') AS DIRECTOR
FROM NetflixTitles AS t
    JOIN NetflixCredits AS c
        ON t.id = c.id
WHERE t.type = 'MOVIE' 
    AND c.role = 'DIRECTOR'
    AND t.imdb_score > 7.5 
    AND t.tmdb_score > 80
GROUP BY t.title
ORDER BY 2 DESC


-- What were the total number of titles for each year? 
SELECT release_year, 
       COUNT(*) AS TOTAL
FROM NetflixTitles
GROUP BY release_year
ORDER BY 2 DESC


-- Actors who have starred in the most highly rated movies or shows
SELECT c.name, 
       COUNT(*) AS Number_of_app_highly_rated
FROM NetflixTitles AS t
    JOIN NetflixCredits AS c
        ON t.id = c.id
WHERE t.imdb_score > 8.0
    AND t.tmdb_score > 80
GROUP BY c.name
ORDER BY 2 DESC


-- Which actors/actresses played the same character in multiple movies or TV shows? 
SELECT c.name, 
       c.character, 
       COUNT(DISTINCT t.title) AS how_many_times
FROM NetflixTitles AS t
    JOIN NetflixCredits AS c
        ON t.id = c.id
WHERE c.character IS NOT NULL
GROUP BY c.name, 
         c.character
HAVING COUNT(DISTINCT t.title) > 1
ORDER BY 3 DESC

-- 7 In which we join actors to movies in the Movie Database.

-- 7.1 List the films where the yr is 1962 [Show id, title]
SELECT id, title
  FROM movie
 WHERE yr = 1962;

-- 7.2 Give year of 'Citizen Kane'.
SELECT yr
  FROM movie
 WHERE title = 'Citizen kane';

-- 7.3 List all of the Star Trek movies, include the id, title and yr
--     (all of these movies include the words Star Trek in the title).
--     Order results by year.
SELECT id, title, yr
  FROM movie
 WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 7.4 What id number does the actor 'Glenn Close' have?
SELECT id
  FROM actor
 WHERE name = 'Glenn Close';

-- 7.5 What is the id of the film 'Casablanca'?
SELECT id
  FROM movie
 WHERE title = 'Casablanca';

-- 7.6 Obtain the cast list for 'Casablanca'.
-- Note: I have replaced 'movieid=11768' with the operation that returns this id
-- to make the process clearer (to me).
SELECT name
  FROM actor JOIN casting ON id = actorid
 WHERE movieid = (SELECT id
                  FROM movie
                  WHERE title = 'Casablanca');

-- 7.7 Obtain the cast list for the film 'Alien'
SELECT name
  FROM actor JOIN casting ON id = actorid
 WHERE movieid = (SELECT id
                  FROM movie
                  WHERE title = 'Alien');

-- 7.8 List the films in which 'Harrison Ford' has appeared
SELECT title
  FROM movie JOIN casting ON id = movieid
 WHERE actorid = (SELECT id
                  FROM actor
                  WHERE name = 'Harrison Ford');

-- 7.9 List the films where 'Harrison Ford' has appeared -
--     but not in the starring role.
SELECT title
  FROM movie JOIN casting ON id = movieid
 WHERE actorid = (SELECT id
                  FROM actor
                  WHERE name = 'Harrison Ford'
                  AND ORD != 1);

-- 7.10 List the films together with the leading star for all 1962 films.
SELECT title, name
  FROM movie JOIN casting ON movieid = id
   JOIN actor ON actor.id = casting.actorid
 WHERE movie.yr = 1962 AND ORD = 1;

-- 7.11 Which were the busiest years for 'John Travolta'? Show the year and
--      the number of movies he made each year for any year in which he made
--      more than 2 movies.
--      Note: this example was given in the exercise.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)

-- 7.12 List the film title and the leading actor for all of the films
--      'Julie Andrews' played in.
SELECT title, name AS lead
FROM movie JOIN casting ON (id = movieid AND ORD = 1)
           JOIN actor ON actorid = actor.id
  WHERE movieid IN (SELECT movieid
                FROM  movie JOIN casting ON id = movieid
                JOIN actor ON actorid = actor.id
                WHERE name = 'Julie Andrews');

-- 7.13 Obtain a list, in alphabetical order, of actors who've had
--      at least 30 starring roles.
SELECT name
  FROM actor JOIN casting ON (id = actorid AND ORD = 1)
 GROUP BY name
 HAVING COUNT(movieid) >= 30;

-- 7.14 List the films released in the year 1978 ordered by the number of
--      actors in the cast, then by title.
SELECT title, COUNT(actorid) AS num_actors
  FROM movie JOIN casting ON (id = movieid AND yr = 1978)
 GROUP BY title
 ORDER BY num_actors DESC, title;

-- 7.15 List all the people who have worked with 'Art Garfunkel'
SELECT name
  FROM actor JOIN casting ON id = actorid
 WHERE movieid IN (SELECT movieid
                  FROM actor JOIN casting ON id = actorid
                  WHERE name = 'Art Garfunkel')
 AND name != 'Art Garfunkel';

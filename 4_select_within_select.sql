-- 4 In which we form queries using other queries.

-- 4.1 List each country name where the population is larger than that
--     of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

-- 4.2 Show the countries in Europe with a per capita GDP greater
--     than 'United Kingdom'.
SELECT name FROM world
  WHERE gdp / population >
     (SELECT gdp / population FROM world
      WHERE name = 'United Kingdom')
      AND continent = 'Europe';

-- 4.3 List the name and continent of countries in the continents containing
--     either Argentina or Australia. Order by name of the country.
SELECT name, continent
  FROM world
 WHERE continent IN
    (SELECT continent FROM world
     WHERE name IN ('Argentina', 'Australia'))
  ORDER BY name;

-- 4.4 Which country has a population that is more than Canada but less
--     than Poland? Show the name and the population.
SELECT name, population
  FROM world
 WHERE population >
    (SELECT population FROM world WHERE name = 'Canada')
    AND population <
    (SELECT population FROM world WHERE name = 'Poland');

-- 4.5 Show the name and the population of each country in Europe. Show the
--     population as a percentage of the population of Germany.
SELECT name, CONCAT(ROUND(population * 100 /
                          (SELECT population
                           FROM world
                           WHERE name = 'Germany')),
                    '%')
  FROM world
 WHERE continent = 'Europe';

-- 4.6 Which countries have a GDP greater than every country in Europe?
--     [Give the name only.] (Some countries may have NULL gdp values)
SELECT name
  FROM world
 WHERE gdp > (SELECT MAX(gdp)
              FROM world
              WHERE continent = 'Europe');

-- 4.7 Find the largest country (by area) in each continent, show the
--     continent, the name and the area:
SELECT continent, name, area
  FROM world
   AS cna
 WHERE area= (SELECT MAX(area)
              FROM world
              WHERE continent = cna.continent);

-- 4.8 List each continent and the name of the country that comes first
--     alphabetically.
SELECT continent, name
  FROM world
   AS cn
 WHERE name = (SELECT name
               FROM world
               WHERE continent = cn.continent
               ORDER BY name
               LIMIT 1);

-- 4.9 Find the continents where all countries have a population <= 25000000.
--     Then find the names of the countries associated with these continents.
--     Show name, continent and population.
SELECT name, continent, population
  FROM world
   AS ncp
 WHERE (SELECT MAX(population)
        FROM world
        WHERE continent = ncp.continent) <= 25000000;

-- 4.10 Some countries have populations more than three times that of any of
-- their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent
  FROM world
   AS nc
 WHERE population / 3 > ALL(SELECT population
                            FROM world
                            WHERE continent = nc.continent
                            AND name != nc.name);

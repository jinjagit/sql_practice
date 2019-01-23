-- 2 In which we query the World country profile table.

-- 2.1 ... SQL command to show the name, continent and population of all countries.
SELECT name, continent, population FROM world;

-- 2.2 Show the name for the countries that have a population of at least
--     200 million. 200 million is 200000000, there are eight zeros.
SELECT name FROM world
  WHERE population >= 200000000;

-- 2.3 Give the name and the per capita GDP for those countries with a
--     population of at least 200 million.
SELECT name, gdp / population AS per_capita_gdp
 FROM world
  WHERE population >= 200000000;

-- 2.4 Show the name and population in millions for the countries of the
--     continent 'South America'.
SELECT name, population / 1000000 AS population_M
 FROM world
  WHERE continent = 'South America';

-- 2.5 Show the name and population for France, Germany, Italy
SELECT name, population
 FROM world
  WHERE name IN ('France', 'Germany', 'Italy');

-- 2.6 Show the countries which have a name that includes the word 'United'
SELECT name
 FROM world
  WHERE name LIKE '%United%';

-- 2.7 Show the countries that are big by area or big by population.
--     Show name, population and area.
SELECT name, population, area
 FROM world
  WHERE area > 3000000 OR population > 250000000;

-- 2.8 Exclusive OR (XOR). Show the countries that are big by area or big by
--     population but not both. Show name, population and area.
SELECT name, population, area
 FROM world
  WHERE area > 3000000 XOR population > 250000000;

-- 2.9 Show the name and population in millions and the GDP in billions for the
--     countries of the continent 'South America'. Use the ROUND function to
--     show the values to two decimal places.
SELECT name,
  ROUND(population / 1000000, 2) AS population_M,
  ROUND (gdp / 1000000000, 2) AS gdp_Bn
 FROM world
  WHERE continent = 'South America';

-- 2.10 Show the name and per-capita GDP for those countries with a GDP of
--      at least one trillion (1000000000000; that is 12 zeros).
--      Round this value to the nearest 1000.
SELECT name,
  ROUND(gdp / population, -3) AS per_capita_gdp_K
 FROM world
  WHERE gdp >= 1000000000000;

-- 2.11 Show the name and capital where the name and the capital have the
--      same number of characters.
SELECT name, capital
  FROM world
 WHERE LENGTH(name) = LENGTH(capital);

-- 2.12 Show the name and the capital where the first letters of each match.
--      Don't include countries where the name and the capital are the same word.
SELECT name, capital
  FROM world
 WHERE LEFT(name, 1) = LEFT(capital, 1)
  AND name <> capital;

  -- 2.13 Find the country that has all the vowels and no spaces in its name.
  SELECT name
   FROM world
WHERE name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';

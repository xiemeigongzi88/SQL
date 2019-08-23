-- SELECT from WORLD Tutorial

name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
...


/* 1. 
Read the notes about this table. Observe the result of running this SQL command to show the name, continent and population of all countries. */



/*
8.
Exclusive OR (XOR). Show the countries that are big by area or big by population but not both. Show name, population and area.

Australia has a big area but a small population, it should be included.
Indonesia has a big population but a small area, it should be included.
China has a big population and big area, it should be excluded.
United Kingdom has a small population and a small area, it should be excluded.
*/

SELECT name, population, area 
FROM world
WHERE area>= 3000000 XOR population >= 250000000


/* 
9.
Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.

For South America show population in millions and GDP in billions both to 2 decimal places.
Millions and billions
*/


SELECT name, ROUND(population/1000000,2), ROUND(gdp/1000000000,2)
FROM world
WHERE continent='South America'



/*
10.
Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.

Show per-capita GDP for the trillion dollar countries to the nearest $1000.
*/

SELECT name, ROUND(gdp/population,-3)
FROM world
WHERE gdp>=1000000000000



/*
12.
The capital of Sweden is Stockholm. Both words start with the letter 'S'.

Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
You can use the function LEFT to isolate the first character.
You can use <> as the NOT EQUALS operator.
*/

SELECT name, capital
FROM world
WHERE LEFT(name,1)=LEFT(capital,1) AND capital<>name


/*
13.
Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.

Find the country that has all the vowels and no spaces in its name.

You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
The query shown misses countries like Bahamas and Belarus because they contain at least one 'a'
*/


SELECT name
   FROM world
WHERE name not LIKE '% %'  AND name LIKE '%a%'  AND name LIKE '%e%'  AND name LIKE '%i%'  AND name LIKE '%o%'  AND name LIKE '%u%'


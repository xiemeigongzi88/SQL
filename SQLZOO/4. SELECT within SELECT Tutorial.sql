4. SELECT within SELECT Tutorial

This tutorial looks at how we can use SELECT statements within SELECT statements to perform more complex queries.

name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
...


/*
1.
List each country name where the population is larger than that of 'Russia'.
*/

SELECT name 
FROM world 
WHERE population > (SELECT  population 
					FROM world 
					WHERE name ='Russia')
					
					
/*
2.
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
*/

SELECT name 
FROM world 
WHERE continent='Europe' 
		AND gdp/population >(SELECT gdp/population
							FROM world
							WHERE name ='United Kingdom')

/*
3.
List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
*/

-- wrong 
SELECT name, continent
FROM world 
WHERE name in (SELECT name FROM world 
					WHERE continent in ('Argentina', 'Australia'))
					
select name,continent
from world
where continent in (select continent from world
                    where name in ('Argentina','Australia')) order by name					
					

/*
4.
Which country has a population that is more than Canada but less than Poland? Show the name and the population.
*/

SELECT name, population 
FROM world 
WHERE population >(SELECT population FROM world
						WHERE name ='Canada')
						AND population <(SELECT population FROM world
						WHERE name ='Poland')

/*
5.
Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

Decimal places
Percent symbol %
*/

-- wrong answer 
SELECT name, population 
FROM world
WHERE continent ='Europe' AND 
------


SELECT 
  name, 
  CONCAT(ROUND((population*100)/(SELECT population 
                                 FROM world 
								 WHERE name='Germany'), 0), '%')
FROM world
WHERE population IN (SELECT population
                     FROM world
                     WHERE continent='Europe')

-----------------------##############################3
SELECT name, CONCAT(ROUND((population*100)/(SELECT population FROM world
                                             WHERE name='Germany')),'%')
FROM world 
WHERE population in (SELECT population FROM world 
                     WHERE continent='Europe')


/*6.
Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
*/

SELECT name 
FROM world 
WHERE gdp > ALL(SELECT gdp FROM world
			WHERE  continent='Europe' AND gdp IS NOT NULL)
			
			
/*
7.
Find the largest country (by area) in each continent, show the continent, the name and the area:
*/

SELECT  continent, name, area
FROM world 
WHERE area in (SELECT MAX(area) FROM world 
GROUP BY continent 				)


SELECT continent, name, area
FROM world as w1
WHERE area = (SELECT max(area) FROM world as w2 where w1.continent=w2.continent)



/*
8.
List each continent and the name of the country that comes first alphabetically.
*/

SELECT continent, name
FROM world as w1
WHERE name = (SELECT min(name) FROM world as w2 where w1.continent=w2.continent)


SELECT continent, name
FROM world as w1
WHERE name IN (SELECT min(name) FROM world as w2 where w1.continent=w2.continent)


/*
9.
Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
*/

SELECT name,continent,population

FROM world

where continent not in (select distinct continent from world where population >25000000)


/*
10.
Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
*/
SELECT name,continent

FROM world as w1

where w1.population/3 > (SELECT max(population) FROM world as w2 where w1.continent=w2.continent and w1.population<>w2.population)

SELECT name, continent 
FROM world as w1 
WHERE w1.population/3 > (SELECT max(population) FROM world as w2
WHERE w1.continent = w2.continent AND w1.name<>w2.name)

3. SELECT from Nobel Tutorial

nobel
yr	subject	winner
1960	Chemistry	Willard F. Libby
1960	Literature	Saint-John Perse
1960	Medicine	Sir Frank Macfarlane Burnet
1960	Medicine	Peter Madawar

/*
5.
Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
*/
SELECT * 
FROM nobel 
WHERE subject='Literature' and yr BETWEEN 1980 AND 1989

/*
9.
Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
*/

SELECT yr, subject, winner 
FROM nobel 
WHERE yr=1980 AND (subject NOT IN ('Chemistry','Medicine'))

/*
10.
Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
*/

SELECT yr, subject, winner 
FROM nobel 
WHERE (subject='Medicine' AND yr<1910) OR (subject='Literature' AND yr>=2004)


/*
12.
Find all details of the prize won by EUGENE O'NEILL

Escaping single quotes
You can't put a single quote in a quote string directly. You can use two single quotes within a quoted string.
*/
SELECT * 
FROM nobel 
WHERE winner ='EUGENE O''NEILL'


/*
13.
Knights in order

List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
*/

SELECT winner, yr, subject 
FROM nobel 
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC,winner


/*
14.
The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.

Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
*/

SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'), subject,winner
、


Nobel Quiz
nobel
yr	subject	winner
1960	Chemistry	Willard F. Libby
1960	Literature	Saint-John Perse
1960	Medicine	Sir Frank Macfarlane Burnet
1960	Medicine	Peter Medawar
1960	Physics	Donald A. Glaser
1960	Peace	Albert Lutuli
...

/*
1. Pick the code which shows the name of winner's names beginning with C and ending in n
*/
SELECT winner 
FROM nobel 
WHERE  winner LIKE 'C%' AND winner LIKE '%n'


/*
2. Select the code that shows how many Chemistry awards were given between 1950 and 1960
*/

SELECT COUNT(subject)
FROM nobel 
WHERE subject='Chemistry' AND yr BETWEEN 1950 AND 1960 

/*
3. Pick the code that shows the amount of years where no Medicine awards were given
*/

SELECT DISTINCT yr 
FROM nobel 
WHERE subject<>'Medicine'

SELECT COUNT( DISTINCT yr)
FROM nobel
WHERE yr NOT IN (SELECT DISTINCT yr 
			FROM nobel 
			WHERE subject='Medicine')

/*
4. Select the result that would be obtained from the following code:
*/

SELECT subject, winner FROM nobel WHERE winner LIKE 'Sir%' AND yr LIKE '196%'


/*
5. Select the code which would show the year when neither a Physics or Chemistry award was given
*/

-- 
SELECT yr 
FROM nobel 
WHERE yr NOT IN (SELECT yr 
				FROM nobel 
				WHERE subject IN ('Physics','Chemistry'))
				
				
/*
6. Select the code which shows the years when a Medicine award was given but no Peace or Literature award was
*/

SELECT yr 
FROM  nobel 
WHERE subject ='Medicine' 
		AND yr NOT IN (SELECT yr 
						FROM nobel
						WHERE subject='Peace')					
		AND yr NOT IN (SELECT yr 
						FROM nobel 
						WHERE subject='Literature')

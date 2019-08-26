5. The JOIN operation
game
id	     mdate	    stadium	                   team1	team2
1001	8 June 2012	National Stadium, Warsaw	POL	    GRE
1002	8 June 2012	Stadion Miejski (Wroclaw)	RUS	    CZE
1003	12 June 2012	Stadion Miejski (Wroclaw)	GRE	CZE
1004	12 June 2012	National Stadium, Warsaw	POL	RUS
...


goal
matchid	teamid	player	gtime
1001	POL	    Robert Lewandowski	17
1001	GRE	    Dimitris Salpingidis	51
1002	RUS	    Alan Dzagoev	15
1002	RUS	    Roman Pavlyuchenko	82
...


eteam
id	teamname	coach
POL	Poland	Franciszek Smuda
RUS	Russia	Dick Advocaat
CZE	Czech Republic	Michal Bilek
GRE	Greece	Fernando Santos
...


/*
1.
The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
*/

SELECT matchid, player 
FROM goal 
WHERE teamid = 'GER'


/*
2.
From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.

Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.

Show id, stadium, team1, team2 for just game 1012

*/
SELECT id,stadium,team1,team2
  FROM game
WHERE id=1012


/*
3、
You can combine the two steps into a single query with a JOIN.
*/
SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid) AND teamid='GER'


/*
4. 
Use the same JOIN as in the previous question.

Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

*/

SELECT team1, team2, player 
FROM game JOIN goal on (id=matchid) AND player LIKE 'Mario%'


/*
5.
The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id

Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
*/

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON (teamid=id)
 WHERE gtime<=10
 
 
/*
6.
To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id

List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
*/ 
SELECT mdate, teamname
FROM game JOIN eteam ON (game.team1=eteam.id)
WHERE eteam.coach ='Fernando Santos'


/*
7.
List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
*/

SELECT player 
FROM game JOIN goal ON (game.id=goal.matchid)
WHERE game.stadium= 'National Stadium, Warsaw'


/*
8.
The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany.
所有与 Germany 比赛的队伍 ， 但是 Germany 没有得分的比赛的 player 

*/

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND teamid<>'GER'
	
	
/*
9.
Show teamname and the total number of goals scored.
*/

SELECT teamname, COUNT(teamid)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname
 
 
/*
10.
Show the stadium and the number of goals scored in each stadium.
*/
SELECT stadium, COUNT(teamid)
FROM game JOIN goal on (id=matchid)
GROUP BY stadium 

/*
11.
For every match involving 'POL', show the matchid, date and the number of goals scored.
*/

SELECT matchid,mdate,COUNT(*)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
 GROUP BY matchid, mdate
 
 /*
 12.
For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
 */
 
SELECT matchid, mdate, COUNT(*)
FROM game JOIN goal on matchid=id 
WHERE teamid='GER'
group by matchid,mdate




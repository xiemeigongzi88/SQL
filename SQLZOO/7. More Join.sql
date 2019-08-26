7. More Join 

/*
7.
Obtain the cast list for the film 'Alien'
*/

select name 
from casting
	join actor on (actor.id=casting.actorid)
    join movie on (casting.movieid = movie.id)
where movie.title= 'Alien'

/*
8.
List the films in which 'Harrison Ford' has appeared
*/

select title 
from casting
	join actor on (actor.id=casting.actorid)
    join movie on (casting.movieid = movie.id)
where actor.name= 'Harrison Ford'


/*
9.
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/


select title 
from casting
	join actor on (actor.id=casting.actorid)
    join movie on (casting.movieid = movie.id)
where actor.name= 'Harrison Ford' AND casting.ord<>1


/*
10.
List the films together with the leading star for all 1962 films.
*/
select title , name 
from casting
	join actor on (actor.id=casting.actorid)
    join movie on (casting.movieid = movie.id)
where casting.ord=1 AND yr=1962


/*
11.
Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/


select yr, COUNT(title)
from casting
	join actor on (actor.id=casting.actorid)
    join movie on (casting.movieid = movie.id)
where name = 'Rock Hudson'
group by yr 
having count(title)>2


/*
12.
List the film title and the leading actor for all of the films 'Julie Andrews' (name) played in.

Did you get "Little Miss Marker twice"?
*/

/*
select title, name 
from casting
	join actor on (actor.id=casting.actorid)
    join movie on (casting.movieid = movie.id)
where ord=1 AND name ='Julie Andrews'
*/



select title,name
from movie
join casting 
on casting.movieid=movie.id
join actor 
on casting.actorid=actor.id
where movieid in (select movieid from casting 
                  join actor 
                  on actor.id=casting.actorid
                  where name='Julie Andrews') and ord=1


/*
13.
Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
*/

select name
from actor
join casting
on casting.actorid=actor.id
where ord=1 
group by name
having count(name)>=30
order by name


/* 
14.
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/

-- right version
select title , count(actorid)
from  movie join casting on (id=movieid)
where yr=1978 
group by title 
having count(title)
order by  count(actorid) desc, title 

-- right version
select title,count(actorid)
from movie
join casting
on casting.movieid=movie.id
join actor
on casting.actorid=actor.id
where yr=1978
group by title
order by count(actorid) desc,title

/*
15.
List all the people who have worked with 'Art Garfunkel'.
*/


select a.name
from (select movie.*
      from movie
      join casting
      on casting.movieid=movie.id
      join actor
      on casting.actorid=actor.id
      where name='Art Garfunkel') as m
join (select actor.*,casting.movieid as movieid
      from actor
      join casting
      on casting.actorid=actor.id
      where name!='Art Garfunkel') as a
on m.id=a.movieid


SELECT DISTINCT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
--GROUP BY name

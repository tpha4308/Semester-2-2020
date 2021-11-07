-----------------------------------------------------------------------------------------
--Only used for COMP2400 students in S2 2020
--Please enter your SQL queries to Question 1.1-1.10 
--Please input your UID here: U7205329
------------------------------------------------------------------------------------------

-- Q1.1


select award_name from award
where lower(country) = 'usa';


-- Q1.2

select title from movie 
where lower(major_genre) = 'comedy' and production_year = 1994;


-- Q1.3

select distinct id, first_name, last_name from person natural join role
where production_year = 1995;

-- Q1.4


select count(*) from director natural join writer;

-- Q1.5

select title, production_year, count(*) from restriction
where lower(description) = 'pg'
group by title, production_year
having count(*) >= 2;

-- Q1.6

with temp as (select id, count(*) as nmovie 
		from movie natural join writer
		where lower(country) = 'usa'
		group by id
		having count(*)  = 2)
select id, first_name, last_name from temp natural join person
order by id asc;


-- Q1.7

with temp as (select id from director
		except 
		select id from director natural join role)
select count(*) from temp;

-- Q1.8

with temp as (select id, count(*) as nmovie from crew
		group by id
		order by nmovie desc)
select id, first_name, last_name from temp natural join person
where temp.nmovie = (select max(nmovie) from temp);


-- Q1.9

with temp as (select id, count(*) as num_nomination from writer_award 
		where lower(result) <> 'won'
		group by id)
select id from temp where num_nomination = (select max(num_nomination) from temp)
except 
select id from writer_award
where lower(result) = 'won'
group by id;


-- Q1.10


with temp1 as (select id, year_of_award-year_born as age 
	       from crew_award natural join person
	       where result = 'won'),
     temp2 as (select id, year_of_award-year_born as age 
	       from crew_award natural join person
	       where result = 'won') 
select temp1.id, temp2.id from temp1 inner join temp2
on temp1.age = temp2.age and temp1.id > temp2.id;


----------------------------------------------------------------
-- End of your answers
-----------------------------------------------------------------



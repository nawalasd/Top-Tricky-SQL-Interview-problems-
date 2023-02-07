
-- 4. Customer visited which floor 

-- Table format  :

/*
create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),
('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR')

*/

-- Code : 

with t1 as (
select name,
       floor,
	   count(1),
	   rank() over(partition by name order by count(1) desc)
from entries
group by 1,2
), t2 as (
select name,floor as most_visited_floor
from t1
where rank = 1
),t3 as (
select e.name,
       count(1) total_visits, 
	   string_agg(resources,',')  as total_resources
from entries as e  
group by 1
)
select t3.name,total_visits,most_visited_floor,total_resources
from t3 join t2 
on t3.name = t2.name



---------------------------------------------------------------------


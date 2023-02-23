-- 17. Second most frequent activity (Leet code,hard)

/*
 Table structure : 
create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


+----------+----------+------------+------------+
| username | activity | startDate  |  endDate   |
+----------+----------+------------+------------+
| Alice    | Travel   | 2020-02-12 | 2020-02-20 |
| Alice    | Dancing  | 2020-02-21 | 2020-02-23 |
| Alice    | Travel   | 2020-02-24 | 2020-02-28 |
| Bob      | Travel   | 2020-02-11 | 2020-02-18 |
+----------+----------+------------+------------+



*/

/* Excepted Output : 


+----------+----------+------------+------------+
| username | activity | startDate  |  endDate   |
+----------+----------+------------+------------+
| Alice    | Travel   | 2020-02-12 | 2020-02-20 |
| Bob      | Travel   | 2020-02-11 | 2020-02-18 |
+----------+----------+------------+------------+


*/

-- Code : 
with t1 as (
select *, rank() over(partition by username order by startDate ) as rn,
          count(username) over(partition by username) as total_users
from      Useractivity
)
select username,
       activity,
	   startDate,
	   endDate
from   t1
where rn = 1 or total_users  =1








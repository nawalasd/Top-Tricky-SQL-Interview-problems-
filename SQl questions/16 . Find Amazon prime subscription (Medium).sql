-- 16 : Amazon subcription rate (medium )

/* 
Problem Statement : 

Given 2 tables , return the fraction of users who accessed to prime music
and upgraded to prime membership within 30 days of signup 

*/

/*

Table structure : 

create table amz_users
(
user_id integer,
name varchar(20),
join_date date
);
insert into amz_users
values (1, 'Jon', '2020-02-14'), -- 2020-02-14
(2, 'Jane', '2020-02-14'), -- 2020-02-14
(3, 'Jill', '2020-02-15'), -- 2020-02-15
(4, 'Josh', '2020-02-15'), -- 2020-02-15
(5, 'Jean', '2020-02-16'), -- 2020-02-16
(6, 'Justin','2020-02-17'),-- 2020-02-17
(7, 'Jeremy','2020-02-18');-- 2020-02-18

drop table events
create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', '2020-03-01'), 
(2, 'Music', '2020-03-02'),
(2, 'P', '2020-03-12'), 
(3, 'Music','2020-03-15'), 
(4, 'Music','2020-03-15'),
(1, 'P', '2020-03-16' ),   
(3, 'P', '2020-03-22');   



*/

/*

Resultant Output : 


+--------------------+
| "percent_of_users" |
+--------------------+
|              33.33 |
+--------------------+


*/


select * from events
select * from amz_users


-- code : 

WITH t1 AS
(
         SELECT   *,
                  Count(type) OVER(partition BY au.user_id) cn
         FROM     amz_users au
         JOIN     events AS e
         ON       au.user_id = e.user_id
         WHERE    type IN ('Music',
                           'P')
         ORDER BY au.user_id,
                  access_date )
SELECT Round(100 * Count(*) /
       (
              SELECT Count(user_id)
              FROM   events
              WHERE  type = 'Music') :: decimal,2) AS percent_of_users
FROM   t1
WHERE  cn = 2
AND    type = 'P'
AND    access_date <= join_date + interval '30 days'
































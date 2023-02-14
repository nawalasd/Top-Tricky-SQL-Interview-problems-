/*
11. Write an SQL query to find the total number of users and 
    the total amount spent using mobile only, desktop only 
    and both mobile and desktop together for each date.
*/

/* 
Table structure : 
Spending table:
+---------+------------+----------+--------+
| user_id | spend_date | platform | amount |
+---------+------------+----------+--------+
| 1       | 2019-07-01 | mobile   | 100    |
| 1       | 2019-07-01 | desktop  | 100    |
| 2       | 2019-07-01 | mobile   | 100    |
| 2       | 2019-07-02 | mobile   | 100    |
| 3       | 2019-07-01 | desktop  | 100    |
| 3       | 2019-07-02 | desktop  | 100    |
+---------+------------+----------+--------+

create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),
                           (1,'2019-07-01','desktop',100),
						   (2,'2019-07-01','mobile',100),
						   (2,'2019-07-02','mobile',100),
						   (3,'2019-07-01','desktop',100),
						   (3,'2019-07-02','desktop',100);

*/

/*
Result table:
+------------+----------+--------------+-------------+
| spend_date | platform | total_amount | total_users |
+------------+----------+--------------+-------------+
| 2019-07-01 | desktop  | 100          | 1           |
| 2019-07-01 | mobile   | 100          | 1           |
| 2019-07-01 | both     | 200          | 1           |
| 2019-07-02 | desktop  | 100          | 1           |
| 2019-07-02 | mobile   | 100          | 1           |
| 2019-07-02 | both     | 0            | 0           |
+------------+----------+--------------+-------------+
On 2019-07-01, user 1 purchased using both desktop and mobile, 
               user 2 purchased using mobile only and user 3 purchased using desktop only.
On 2019-07-02, user 2 purchased using mobile only, user 3 purchased using desktop only 
               and no one purchased using both platforms.
*/
--Code : 

-- Find users who did only have any one platform

with t1 as (
select   spend_date,
         max(platform) as platform,
         count(distinct user_id)total_users,
         sum(amount) total_amount 
from     spending
group by user_id,spend_date
having count(distinct platform) = 1
union all
select spend_date,
       'both' as platform,
       count(distinct user_id)total_users,
       sum(amount)  total_amount 
from   spending
group by user_id,spend_date
having count(distinct platform) = 2
-- Inserting dummy record
union all
select spend_date , 'both' as platform, null  as total_users, 0 as total_amount
from spending
group by spend_date,user_id
)
select *
from t1






-- select spend_date,
--        platform,
-- 	   count(distinct total_users),
-- 	   sum(total_amount)
-- from t1
-- group by spend_date,platform
-- order by spend_date,platform desc



			   
			   

			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
-- 19 Spotify case study


-- Problem Statement :  
 --- This case study has 5 questions and with each question difficulty level will go up.

/*  Table structure : */

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');



-- Code : 

/*Question 1 : 
  Total unique active users per day

 Excepted Output :
+------------+---------------------+
| event_date | unique_active_users |
+------------+---------------------+
| 2022-01-01 |                   3 |
| 2022-01-02 |                   1 |
| 2022-01-03 |                   3 |
| 2022-01-04 |                   1 |
+------------+---------------------+

  */

select event_date, 
       count(distinct user_id) unique_active_users
from activity
group by event_date
order by event_date

----------------------------------------------------------------------------------------

/* Question 2 : 
  Weekly active users

  Excepted output : 
  
+----------+---------------------+
| Week_num | unique_active_users |
+----------+---------------------+
|        1 |                   3 |
|        2 |                   5 |
+----------+---------------------+

*/
-- Code : 

	select DATEPART(week,event_date) Week_num ,
		   count(distinct user_id) unique_active_users
	from activity
	group by DATEPART(week,event_date)

----------------------------------------------------------------------------------------


/* Question 3 : 
   Date wise total no. of users who made purchased on same day they installed app

Excepted Output :
+------------+-----------------------------+
| event_date | installed_purchase_same_day |
+------------+-----------------------------+
| 2022-01-01 |                           0 |
| 2022-01-02 |                           0 |
| 2022-01-03 |                           2 |
| 2022-01-04 |                           1 |
+------------+-----------------------------+

*/
-- Code : 
with t1 as (
select event_date, 
       user_id,
       count(user_id) over(partition by event_date,user_id order by event_date) as same_day_purchase
from activity
),
t2 as (
select event_date,count(distinct user_id) as same_day
from t1
where same_day_purchase = 2
group by event_date
)
select distinct a.event_date, coalesce(same_day,0) as installed_purchase_same_day
from activity as a
left join t2
on a.event_date = t2.event_date


----------------------------------------------------------------------------------------

/* Question 4 : 
   Percentage of paid users in india , usa and others


   Excepted Output : 
   
+----------+-----------------------+
| country1 | percent_of_paid_users |
+----------+-----------------------+
| India    |                    40 |
| others   |                    40 |
| USA      |                    20 |
+----------+-----------------------+



*/ 
-- Code : 

select case when country not in ('India','USA') then 'others' else country end country1,
       (100* count(1) / (select count(1) from activity where event_name = 'app-purchase') ) as percent_of_paid_users
      
from activity
where event_name = 'app-purchase'
group by case when country not in ('India','USA') then 'others' else country end



----------------------------------------------------------------------------------------

/* Question 5 :
   Among all users who installed app on given date, 
   how many did in- app purchased on very next date - day wise result
     
   Excepted Output : 

	
	+------------+-------------------+
	| event_date | nextdate_purchase |
	+------------+-------------------+
	| 2022-01-01 |                 0 |
	| 2022-01-02 |                 1 |
	| 2022-01-03 |                 0 |
	| 2022-01-04 |                 0 |
	+------------+-------------------+

	
*/

-- Code : 

with t1 as (
 select 
        event_date , 
		lag(event_date) over(partition by user_id order by event_date) as  next_dt
 from activity
 ), 
 t2 as (
 select event_date,count(1) as nextdate_purchase
 from t1
 where  DATEDIFF(day,event_date,next_dt) = -1
 group by event_date
 )
 select distinct a.event_date, coalesce(nextdate_purchase,0) as nextdate_purchase
 from activity as a 
 left join t2 
 on a.event_date = t2.event_date
 
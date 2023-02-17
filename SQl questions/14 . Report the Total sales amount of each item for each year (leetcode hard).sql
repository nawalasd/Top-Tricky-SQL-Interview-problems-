-- 14 
/* 
Report the Total sales amount of each item for each year, 
with corresponding product name, product_id, product_name and report_year.
Dates of the sales years are between 2018 to 2020. 
Return the result table ordered by product_id and report_year.
*/

/* Table Structure : 


create table sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales values(1,'2019-01-25',
                        '2019-02-28',100),
						(2,'2018-12-01',
						'2020-01-01',10),
						(3,'2019-12-01',
						'2020-01-31',1);



Sales table:
+------------+--------------+-------------+---------------------+
| product_id | period_start | period_end  | average_daily_sales |
+------------+--------------+-------------+---------------------+
| 1          | 2019-01-25   | 2019-02-28  | 100                 |
| 2          | 2018-12-01   | 2020-01-01  | 10                  |
| 3          | 2019-12-01   | 2020-01-31  | 1                   |
+------------+--------------+-------------+---------------------+

*/

/* Excepted Output : 

Result table:
+--------------+---------------+-------------+
| "product_id" | "report_year" | "total_amt" |
+--------------+---------------+-------------+
|            1 |          2019 |        3500 |
|            2 |          2018 |         310 |
|            2 |          2019 |        3650 |
|            2 |          2020 |          10 |
|            3 |          2019 |          31 |
|            3 |          2020 |          31 |
+--------------+---------------+-------------+

*/

--Code : 

-- select *
-- from sales

with recursive t1 as 
(
	select min(period_start :: date) as dates, max(period_end :: date) as max_date 
	from sales
	UNION ALL 
	select date(dates + interval '1 day') as dt,max_date
	from t1
	where dates < max_date
)
select product_id,
       date_part('year',dates) as report_year,
	   sum(average_daily_sales) total_amt
from t1
join sales  on 
dates between period_start and period_end
group by 1,2
order by product_id



















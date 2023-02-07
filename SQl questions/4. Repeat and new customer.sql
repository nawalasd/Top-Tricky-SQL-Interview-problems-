-- 3) Old and new customers : 

/*
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
insert into customer_orders values
(1,100,cast('2022-01-01' as date),2000),
 (2,200,cast('2022-01-01' as date),2500),
 (3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),
(5,400,cast('2022-01-02' as date),2200),
(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),
(8,400,cast('2022-01-03' as date),1000),
(9,600,cast('2022-01-03' as date),3000)
;
*/

-- final_output : 
+------------+--------------+-----------------+
| orderdate  | new_customer | repeat_customer |
+------------+--------------+-----------------+
| 2022-01-01 |            3 |               0 |
| 2022-01-02 |            2 |               1 |
| 2022-01-03 |            1 |               2 |
+------------+--------------+-----------------+

-- Code : 

-- get the first date of customerid and join with main table
with t1 as (
				select customer_id, 
					   min(order_date) dt
				from customer_orders
				group by 1
	)
select order_date,
           sum(case when t1.dt = co.order_date then 1 else 0 end) new_customer,
	       sum(case when t1.dt <> co.order_date then 1 else 0 end) old_customer
from t1
join customer_orders  as co
on t1.customer_id = co.customer_id
group by order_date
order by 1
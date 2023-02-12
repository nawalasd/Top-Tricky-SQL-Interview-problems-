-- 8. Market analysis : 

/*Problem Statement : 
Find for each seller whether brand of second item they sold (by date) is their fav brank or not.
if seller sells less than 2 items report the ans for that seller as no
*/

/* link : https://leetcode.ca/all/1159.html */

/*Table Structure : 
create table ecom_users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into ecom_users values (1,'2019-01-01','Lenovo'),
                           (2,'2019-02-09','Samsung'),
						   (3,'2019-01-19','LG'),
						   (4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),
                          (2,'Lenovo'),
						  (3,'LG'),
						  (4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),
                           (2,'2019-08-02',2,1,3),
						   (3,'2019-08-03',3,2,3),
						   (4,'2019-08-04',1,4,2),
						   (5,'2019-08-04',1,3,4),
						   (6,'2019-08-05',2,2,4);
						   
*/

/* Excepted output : 
Result table:
+-----------+--------------------+
| seller_id | 2nd_item_fav_brand |
+-----------+--------------------+
| 1         | no                 |
| 2         | yes                |
| 3         | yes                |
| 4         | no                 |
+-----------+--------------------+

The answer for the user with id 1 is no because they sold nothing.
The answer for the users with id 2 and 3 is yes because the brands of their second sold items are their favorite brands.
The answer for the user with id 4 is no because the brand of their second sold item is not their favorite brand.

*/
--  Tables : 

select * from ecom_users
select * from orders
select * from items

-- Code : 

with t1 as (
select coalesce(seller_id,user_id) as seller_id,
       favorite_brand,
       order_id,
	   order_date,
	   ord.item_id,
	   dense_rank() over(partition by seller_id order by order_date) as order_rank
from ecom_users as eu 
left join orders as ord 
on eu.user_id = ord.seller_id
order by seller_id,order_date
)
select seller_id, 
       case when item_brand is null then 'no'
	        when favorite_brand = item_brand  then 'yes'
			else 'no'
			end  as fav_brand_2nd
	     
from t1
left join items as it
on t1.item_id = it.item_id
where order_rank = 2 or item_brand is null



















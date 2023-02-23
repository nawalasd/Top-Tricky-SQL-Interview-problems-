-- 15  Customers who frequently bought 2 items together : 


/*  Table Structure : 
create table cust_orders
(
order_id int,
customer_id int,
product_id int
);

insert into cust_orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

*/

/* Excepted Output : 


+----------------+-------------+
| "paired_items" | "frequency" |
+----------------+-------------+
| "A,B"          |           2 |
| "A,C"          |           1 |
| "B,C"          |           1 |
| "A,D"          |           1 |
| "B,D"          |           1 |
+----------------+-------------+



*/

select * from cust_orders
select * from products

-- Code : 
-- We need to pair  : self join 
WITH t1
     AS (SELECT t1.order_id,
                t1.product_id AS p1,
                t2.product_id AS p2
         FROM   cust_orders AS t1
                JOIN cust_orders AS t2
                  ON t1.order_id = t2.order_id
                     -- remove duplicates
                     AND t1.product_id < t2.product_id),
     t2
     AS (SELECT p1,
                p2,
                Count(*) AS frequency
         FROM   t1
         GROUP  BY 1,
                   2)
SELECT Concat(pro.NAME, ',', pros.NAME) AS paired_items,
       frequency
FROM   t2
       -- double inner join 
       JOIN products AS pro
         ON t2.p1 = pro.id
       JOIN products AS pros
         ON t2.p2 = pros.id 

















-- 18. Bill rate of customer

/* Table structure :

create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings;
insert into billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;


create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4)

*/

/* Excepted Output : 


+----------+---------------+
| emp_name | total_charges |
+----------+---------------+
| Sachin   |           320 |
| Sehwag   |            30 |
+----------+---------------+



*/

-- Code : 
WITH t1
     AS (SELECT *,
                Lead(bill_date, 1, '2050-01-01')
                  OVER(
                    partition BY emp_name
                    ORDER BY bill_date) AS dt
         FROM   billings),
     t2
     AS (SELECT *,
                Dateadd(day, -1, dt) dt1
         FROM   t1)
SELECT t2.emp_name,
       Sum(bill_rate * bill_hrs) AS total_charges
FROM   t2
       JOIN hoursworked AS h
         ON t2.emp_name = h.emp_name
            AND work_date BETWEEN bill_date AND dt1
GROUP  BY t2.emp_name 


/* table structure : 

CREATE TABLE emp_details
    (
        id           int PRIMARY KEY,
        name         varchar(100),
        manager_id   int,
        salary       int,
        designation  varchar(100)

    );

INSERT INTO emp_details VALUES (1,  'Shripadh', NULL, 10000, 'CEO');
INSERT INTO emp_details VALUES (2,  'Satya', 5, 1400, 'Software Engineer');
INSERT INTO emp_details VALUES (3,  'Jia', 5, 500, 'Data Analyst');
INSERT INTO emp_details VALUES (4,  'David', 5, 1800, 'Data Scientist');
INSERT INTO emp_details VALUES (5,  'Michael', 7, 3000, 'Manager');
INSERT INTO emp_details VALUES (6,  'Arvind', 7, 2400, 'Architect');
INSERT INTO emp_details VALUES (7,  'Asha', 1, 4200, 'CTO');
INSERT INTO emp_details VALUES (8,  'Maryam', 1, 3500, 'Manager');
INSERT INTO emp_details VALUES (9,  'Reshma', 8, 2000, 'Business Analyst');
INSERT INTO emp_details VALUES (10, 'Akshay', 8, 2500, 'Java Developer');

*/

-- Q1: Find the hierarchy of employees under a given manager "Asha".
select *  from emp_details


/* Excepted Output :


+-----------+----------------+
|  "name"   | "manager_name" |
+-----------+----------------+
| "Asha"    | "Shripadh"     |
| "Michael" | "Asha"         |
| "Arvind"  | "Asha"         |
| "Satya"   | "Michael"      |
| "Jia"     | "Michael"      |
| "David"   | "Michael"      |
+-----------+----------------+



*/

-- Code : 

with recursive t1 as 
(
	select id,name,manager_id , 1 as level -- Base query 
	from emp_details
	where name = 'Asha'
    Union all 
	select ed.id,ed.name, ed.manager_id, level +1
	from t1
	join emp_details as ed 
	on t1.id = ed.manager_id
)
select t1.name, t2.name as manager_name
from t1 
join emp_details as t2
on t1.manager_id = t2.id


-- Q2: Find the hierarchy of managers for a given employee "David"

/* Excepted Output : 


+--------+-----------+----------------+
| "id"   |  "name"   | "manager_name" |
+--------+-----------+----------------+
|      4 | "David"   | "Michael"      |
|      5 | "Michael" | "Asha"         |
|      7 | "Asha"    | "Shripadh"     |
+--------+-----------+----------------+


*/

--Code : 

WITH recursive t1 AS
(
       SELECT id,
              NAME,
              manager_id
       FROM   emp_details
       WHERE  NAME = 'David'
       UNION ALL
       SELECT ed.id,
              ed.NAME,
              ed.manager_id
       FROM   t1
       JOIN   emp_details AS ed
       ON     t1.manager_id = ed.id )
SELECT t1.id,
       t1.NAME,
       t2.NAME AS manager_name
FROM   t1
JOIN   emp_details AS t2
ON     t1.manager_id = t2.id
	















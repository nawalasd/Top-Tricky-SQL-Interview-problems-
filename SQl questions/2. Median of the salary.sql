-- 2 ) Find medium of the salary 


/* table format 
create table emp_salary 
( salary int );
insert into emp_salary values
(9),(10),(34),(45),(67);

*/

-- Code : 

with t1 as (
select salary , 
       row_number() over(order by salary ) rn,
	   count(1) over() cn
from emp_salary
)
select avg(salary) 
from t1
where rn between  (1.0 * cn/2)  and (1.0 * cn/2 )+ 1
-- 1 ) Print 1 to 10 using recursion : 


WITH recursive t1 AS
(
       SELECT 1 AS num
       UNION ALL
       SELECT num + 1
       FROM   t1
       WHERE  num < 10 )
SELECT *
FROM   t1

-- 2 ) Print even number using recursion  ( 1 - 12)

with recursive t1 as 
(
	select 2 as num
	union all 
	select num  + 2 
	from t1
	where num < 12
)

select * from t1


-- 3) Print odd number using recursion  ( 1 - 12)

with recursive t1 as 
(
	select 1 as num
	union all 
	select num  + 2 
	from t1
	where num < 12
)

select * from t1

/* 4) Pattern  using recursion : 

			* 
			* * 
			* * * 
			* * * * 
			* * * * *

*/

WITH recursive t1 AS
(
       SELECT 1 AS num
       UNION ALL
       SELECT num+1
       FROM   t1
       WHERE  num < 5 )
	   
SELECT repeat('* '  ,num)
FROM   t1


/* 5) Pattern  using recursion : 

			1
			2 2
			3 3 3
			4 4 4 4
			5 5 5 5 5

*/

WITH recursive t1 AS
(
       SELECT 1 AS num
       UNION ALL
       SELECT num+1
       FROM   t1
       WHERE  num < 5 )
	   
SELECT repeat(num :: varchar || ' '  ,num)
FROM   t1

/* 6 ) Pattern using recursion : 


				A A A A B 
				A A A B B 
				A A B B B 
				A B B B B 
				B B B B B
   
*/
  
	 
WITH recursive t1 AS
(
       SELECT 4 AS A, 1 as B
       UNION ALL
       SELECT A -1 , B +1
       FROM   t1
       WHERE  B < 5 )
	   
SELECT repeat('A ',A) ||  repeat('B ',B)
FROM   t1	 
	 
	 
	 
	 
	 
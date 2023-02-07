-- 5.
/*
Write a query to personID, name, no_of_friends and total friends score
with total score greater than 100
*/  

-- Dataset is in sql dataset folder 
-- file name (person ,friend)

-- table name : friend
+----------+----------+
| PersonID | FriendID |
+----------+----------+
|        1 |        2 |
|        1 |        3 |
|        2 |        1 |
|        2 |        3 |
|        3 |        5 |
|        4 |        2 |
|        4 |        3 |
|        4 |        5 |
+----------+----------+

-- table name : person1
+----------+-------+-----------------------+-------+
| PersonID | Name  |         Email         | Score |
+----------+-------+-----------------------+-------+
|        1 | Alice | alice2018@hotmail.com |    88 |
|        2 | Bob   | bob2018@hotmail.com   |    11 |
|        3 | Davis | davis2018@hotmail.com |    27 |
|        4 | Tara  | tara2018@hotmail.com  |    45 |
|        5 | John  | john2018@hotmail.com  |    63 |
+----------+-------+-----------------------+-------+

-- Excepted output : 


+------------+--------+-----------------+----------------------+
| "personid" | "name" | "no_of_friends" | "total_friend_score" |
+------------+--------+-----------------+----------------------+
|          2 | "Bob"  |               2 |                  115 |
|          4 | "Tara" |               3 |                  101 |
+------------+--------+-----------------+----------------------+

--Code : 

with t1 as (
select p1.personid, name,score,friendid
from person1 as p1
join friend as f 
on p1.personid = f.personid
)
select t1.personid,
       t1.name,
	   count(t1.personid) no_of_friends,
	   sum(p2.score) total_friend_score
from t1 
join person1 as p2 
on t1.friendid = p2.personid
group by 1,2
having sum(p2.score) > 100
order by t1.personid


as a
join t1 as b
on a.friendid = b.personid
order by a.personid





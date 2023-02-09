
-- 7. Winner in each group : 

'''
 Problem Statement : 
 the winner in each group is a player who score max points within that group ,
   in case tie , lower player id wins
'''
 
/* Table structure : 
create table players
(player_id int,
group_id int);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

*/

/*
Excepted Output : 
+------------+-------------+
| "group_id" | "player_id" |
+------------+-------------+
|          1 |          15 |
|          2 |          35 |
|          3 |          40 |
+------------+-------------+
*/

-- Tables : 
select * from players
select * from matches

-- Code : 

-- Step 1 : First Indivdual  get players scores : 

with t1 as (
			select        first_player, 
	                      first_score
			from          matches
			Union all
			select        second_player, 
	                     second_score
			from matches
), 
t2 as (
			select first_player as players , 
				   sum(first_score) as total_score
			from t1
            group by 1
         ),
t3 as (
select group_id, 
       p1.player_id,
	   total_score,
	   dense_rank() over(partition by group_id order by total_score desc, player_id asc ) rnk
from players as p1 
join t2 
on p1.player_id = t2.players
)
select group_id,player_id
from t3
where rnk = 1


















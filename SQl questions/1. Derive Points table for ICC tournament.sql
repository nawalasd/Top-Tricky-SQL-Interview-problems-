-- 1 . Derive Points table for ICC tournament

/* -- Table format 
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');
*/

-- Output : 
/*
+-----------+--------------------+------+------+
| Team name | No of match played | wins | loss |
+-----------+--------------------+------+------+
| IND       |                  2 |    2 |    0 |
| SL        |                  2 |    0 |    2 |
| SA        |                  1 |    0 |    1 |
| ENG       |                  2 |    1 |    1 |
| AUS       |                  2 |    1 |    1 |
| NZ        |                  1 |    1 |    0 |
+-----------+--------------------+------+------+

*/
-- Query : 

with t1 as (
			select team_1,winner
			from icc_world_cup
			union all 
			select team_2 , winner
			from icc_world_cup
           ) 
select team_1,
       count(team_1) matchesPlayed,
       count(case when team_1 = winner then 'win' else null  end) total_wins,
	   count(case when team_1 <> winner then 'loss' else null  end) total_loss
from t1
group by 1
order by 1

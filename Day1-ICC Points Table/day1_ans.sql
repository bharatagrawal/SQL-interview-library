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

select * from icc_world_cup;

with cte_matches as (
select 
Team_1 as team_name, 
case when winner = Team_1 then 1 else 0 end as winner
 from icc_world_cup
union all
select Team_2 as team_name, 
case when winner = Team_2 then 1 else 0 end as winner
 from icc_world_cup
)
select 
team_name, 
count(*) as matches_played,
sum(winner) as no_of_wins,
count(*) - sum(winner) as no_of_losses
from cte_matches
group by team_name


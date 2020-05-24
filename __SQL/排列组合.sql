/*
排列组合
一个叫 team 的表，里面只有一个字段 name，
一共有 4 条记录，分别是 a、b、c、d，对应四个球队
四个球队进行比赛，用一条 sql 语句显示所有可能的比赛组合
*/
/*
select * from team a, team b where a.name > b.name
*/
/*
SELECT
    team.name AS team_1,
    team.name AS team_2
FROM
    team AS T1
CROSS JOIN 
    team AS T2
WHERE
    T1.name<>T2.name;
*/
Select
    a.Name,
    b.Name
From
    Team as a,
    Team as b
Where
    a.Name<b.Name 
And
order by
    a.Name,b.Name;

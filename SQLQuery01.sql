/****** Script for SelectTopNRows command from SSMS  ******/

  select * from HrmResource;
  select * from HrmDepartment;
  
  update HrmResource set loginid='qian.jiang' where id=10;

  update HrmResource set password='123456' where id=10;


   select departmentname,lastname from HrmDepartment d,HrmResource r
   where r.departmentid=d.id and d.id=2;

  sp_help HrmDepartment;/*查询表中所有字段*/
  sp_columns hrmresource;

  /*查询数据库中所有的表名*/
  select * from sys.tables;
  select * from Sysobjects where xtype='U' order by name;
  exec sp_tables;/*所有表与视图*/
  
/*
SQL Server查询所有数据库，一个数据库中所有表和表的所有字段  
查询所有的数据库 
select [name] from [sysdatabases] order by [name]    
查询一个数据库中的所有表『 [type] = 'u' 是用户表,[type] = 's'是系统表』 
select [id], [name] from [sysobjects] where [type] = 's'    
根据上个语句的查询结果然后再查询一个表中的所有字段   
select [name] from [syscolumns] where [id] = 1931153925
*/

  sp_help formtable_main_132;

  use ecology;

  select name,xtype,id from sysobjects where xtype='U' and name like '%card%';
  sp_help HrmCardInfo;
  sp_helpconstraint hrmresource;/*查询表的约束*/
  select * from HrmCardInfo;

 
 select top 5 * from HrmResource order by id asc;

 select * into a_mytest from hrmresource ;/*sqlserver用旧表创建新表*/

 sp_help a_mytest;
 sp_helpconstraint a_mytest;

 select count(*) from a_mytest;
 truncate table a_mytest;
 insert into a_mytest select * from HrmResource;/*sqlserver将旧表中数据导入新表*/
 delete from a_mytest;

 delete from a_mytest
 where id in
 (select id from a_mytest group by id having count(id)>1)
 and
 unid not in
 (select max(unid) from a_mytest group by id having count(id)>1);

 select * from a_mytest where id=2234;
 select id,lastname from a_mytest order by id asc;
 alter table a_mytest add unid uniqueidentifier not null
     default newid();/*增加全数据库唯一标示*/

select unid,id,lastname from a_mytest order by id;
select count(id) from a_mytest group by unid having count(*)>1;/*无返回值*/

sp_help a_mytest;
select top 5 * from a_mytest order by id desc;
insert into a_mytest(id,loginid,password,lastname,sex,unid) 
values(2818,'Vincent.One','123456','VincentOne','1',newid());
update a_mytest set telephone='13815502491' where lastname like 'Vincent%';

/*找出lastname一样的人*/
select id,lastname,case when sex='1' then '女' else '男' end as 'agender',workcode from a_mytest
where lastname=(
select lastname from a_mytest
group by lastname having count(lastname)>1);

select workcode,id,lastname,case when sex='1' then '女' else '男' end as 'agender',lastlogindate,unid
from a_mytest
where lastname='朱永伟';



select * from a_mytest;
select * from HrmDepartment;

select a.id,a.lastname,d.departmentname
from a_mytest a,HrmDepartment d
where a.departmentid=d.id
order by a.id;

select GETDATE();
sp_help hrmresource;
sp_helpconstraint hrmresource;
select * from HrmResource;
sp_help hrmdepartment;
select * from HrmJobTitles;
select r.lastname,d.departmentname,j.jobtitlename from HrmResource r,HrmDepartment d,HrmJobTitles j
where lastname='王阳阳' and r.departmentid=d.id and r.jobtitle=j.id;

sp_help HrmPinYinResource;
select * from sysobjects where xtype='U' and name like 'hrm%';

if exists (select *　from sysobjects where name='view_department')
drop view view_department
go 
create view view_department
as 
 select * from HrmDepartment
go
 select * from view_department




 



 


 
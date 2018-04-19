select * from HrmDepartment where (canceled is null or canceled=0)
 
select d.id as '编号',t1.subcompanyname as '公司',d.departmentname as '部门',t1.lastname as '部门负责人',
t2.lastname as '部门分管领导',t3.lastname as '中心总监',t4.lastname as '人事专员',t5.lastname as '人事专员上级',t6.lastname as '部门助理'
from HrmDepartment d
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.bmfzr as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t1
on t1.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.bmfgld as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t2
on t2.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.zxzj as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t3
on t3.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.rszy as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t4
on t4.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.rszysj as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t5
on t5.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.bmzl as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t6
on t6.id=d.id
where (d.canceled is null or d.canceled=0) 


use ecology
go
if exists(select count(*) from sysobjects where id='ecology.dbo.chaxunbumenjuzheng') drop proc dbo.chaxunbumenjuzheng
go
create proc chaxunbumenjuzheng
as
begin
select d.id as '编号',t1.subcompanyname as '公司',d.departmentname as '部门',t1.lastname as '部门负责人',
t3.lastname as '中心总监',t2.lastname as '部门分管领导',t4.lastname as '人事专员',t7.lastname as '考勤专员',t5.lastname as '人事专员上级',t6.lastname as '部门助理'
from HrmDepartment d
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.bmfzr as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t1
on t1.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.bmfgld as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t2
on t2.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.zxzj as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t3
on t3.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.rszy as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t4
on t4.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.rszysj as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t5
on t5.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.bmzl as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t6
on t6.id=d.id
left join
(select d.id,c.subcompanyname,r.lastname from HrmDepartment d,HrmResource r,HrmSubCompany c
where cast(d.kqrszy as varchar)=cast(r.id as varchar) and d.subcompanyid1=c.id) t7
on t7.id=d.id
where (d.canceled is null or d.canceled=0) 
end

exec chaxunbumenjuzheng
select * from HrmDepartment where (canceled is null or canceled=0)
 
select d.id as '���',t1.subcompanyname as '��˾',d.departmentname as '����',t1.lastname as '���Ÿ�����',
t2.lastname as '���ŷֹ��쵼',t3.lastname as '�����ܼ�',t4.lastname as '����רԱ',t5.lastname as '����רԱ�ϼ�',t6.lastname as '��������'
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
select d.id as '���',t1.subcompanyname as '��˾',d.departmentname as '����',t1.lastname as '���Ÿ�����',
t3.lastname as '�����ܼ�',t2.lastname as '���ŷֹ��쵼',t4.lastname as '����רԱ',t7.lastname as '����רԱ',t5.lastname as '����רԱ�ϼ�',t6.lastname as '��������'
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
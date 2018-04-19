use ecology

select * from HrmJobActivities
select * from HrmJobTitles
select * from HrmJobGroups


select * from HrmJobTitles t
left join HrmJobActivities a
on t.jobactivityid=a.id 
left join HrmJobGroups g
on a.jobgroupid=g.id 

select * from HrmJobActivities,HrmJobTitles,HrmJobGroups
where HrmJobActivities.id=HrmJobTitles.jobactivityid and HrmJobActivities.jobgroupid=HrmJobGroups.id
and HrmJobTitles.jobtitlename='OA运营专员'

if exists (select * from sysobjects where name='view_temp') drop view view_temp
go
create view  view_temp
as 
select a.lastname, b.jobtitlename,c.jobactivityname,d.jobgroupname from HrmResource a 
left join HrmJobTitles b on a.jobtitle = b.id
left join HrmJobActivities c on b.jobactivityid = c.id
left join HrmJobGroups d on c.jobgroupid = d.id
go 
select * from view_temp

select * from HrmResource
update view_temp set lastname='陈文彬' where lastname='cwb'
update view_temp set lastname='cwb'  where lastname='陈文彬' 

select GETDATE();
select SYSDATETIME();


select * from HrmResource
select * from HrmJobTitles
select * from HrmDepartment
select * from HrmSubCompany

select r.lastname,j.jobtitlename,d.departmentname,c.subcompanyname from HrmResource r,HrmJobTitles j,HrmDepartment d,HrmSubCompany c 
where r.departmentid=d.id and r.jobtitle=j.id and r.subcompanyid1=c.id 



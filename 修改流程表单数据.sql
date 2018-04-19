use ecology

select * from formtable_main_128 where xm='1291'
select * from HrmResource where lastname like '曾__'

select * from formtable_main_90
select * from formtable_main_90_dt1

select * from formtable_main_90 m
join formtable_main_90_dt1 d on d.mainid=m.id

select * from HrmResource where lastname='王阳阳'

select r.id,r.managerid,d.departmentname,d.rszy from HrmDepartment d,HrmResource r
where convert(varchar(20),d.rszy)=convert(varchar(20),r.id)  




sp_help HrmDepartment
sp_help HrmSubCompany
select * from HrmSubCompany


select d.id,d.departmentname ,convert(varchar(20),d.rszy) as rszy from HrmDepartment d
select convert(varchar(20),r.id) from HrmResource r

select * from formtable_main_106
select id,mc,mc from formtable_main_106

 select * from workflow_requestbase  --流程标题信息等基础信息
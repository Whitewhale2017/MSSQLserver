select * from HrmDepartment where id='806' or supdepid='806'

update HrmDepartment set zxzj='6381' where id='806' or supdepid='806'


select * from HrmResource where id='2015'
select * from HrmResource where lastname='ÕÅÈð'

select d.departmentname as ssjbm,d.id as ssjbmid,d.supdepid as ssjbmsjbmid,t2.* from HrmDepartment d, 
(select d.departmentname as sjbm,t1.departmentname,d.id as sjbmid,d.supdepid as sjbmsjid,t1.id,t1.supdepid
from HrmDepartment d,
(select * from HrmDepartment where 
departmentcode in
(select departmentcode from HrmDepartment 
group by departmentcode
having count(departmentcode)>1)
and (canceled is null or canceled=0)) t1
where t1.supdepid=d.id) t2
where d.id=t2.sjbmsjid
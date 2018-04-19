select EmployeeCode from hrmresource_midtable group by EmployeeCode having count(EmployeeCode)>1

select * from hrmresource_midtable where EmployeeCode in ('820669')

delete from hrmresource_midtable where id in (10740,10742)
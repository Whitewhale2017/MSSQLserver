
--update ecology8.dbo.hrmresource  set ecology8.dbo.hrmresource.enddate=t.LeaveDate,ecology8.dbo.hrmresource.status=5,loginid=''
from 
(
select * from 
(select e7.workcode as e7workcode,e7.lastname as e7lastname,e7.status as e7status,e7.LeaveDate,
e8.workcode as e8workcode,e8.lastname as e8lastname,e8.status as e8status,e8.probationenddate,
case when e7.status=e8.status then 1 else 0 end as same
from ecology.dbo.hrmresource e7
left join ecology8.dbo.hrmresource e8
on e7.workcode=e8.workcode) t 
where t.same=0 and e7status in (1,5) and e7workcode!='' and e7workcode not like 'DD%' and e8status=0
)
t
where t.e7workcode=ecology8.dbo.hrmresource.workcode

select * from 



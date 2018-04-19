select count(requestid),sum(sc) from 
(
select c.typename,b.workflowname,--a.requestname,
a.requestid, 
case a.currentnodetype when 3 then '¹éµµ' when 0 then '·¢Æğ' else 'ÉóÅú' end as 'zt',
(select sum(case when logtype='3' then 1 else 0 end) from workflow_requestLog where requestid=a.requestid) as 'thcs',
DATEDIFF(HOUR,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime) as 'sc',
round(DATEDIFF(HOUR,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)/24.0,2) as 'spsc'
from workflow_requestbase a
left join workflow_base b
on a.workflowid=b.id
left join workflow_type c
on b.workflowtype=c.id
where a.createdate>='2017-01-01' and a.createdate<='2017-12-31' and a.currentnodetype=3
) t

select 10907620/90911.0/24.0


select * from workflow_requestbase where currentnodetype=0
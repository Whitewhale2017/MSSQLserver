select * from (
select lastname 姓名,
count(lastname) 流程数
from (
select d.lastname
from (
select a.creater
from workflow_requestbase a,
workflow_requestLog b
where b.logtype='3'
and a.requestid=b.requestid
and
substring(a.creater,0,7)=convert(getdate(),'yyyy-mm')
) c,HrmResource d
where c.creater=d.id
and d.subcompanyid1=101
)e
group by e.lastname
order by count(lastname) desc)
where rownum<=10

select GETDATE()
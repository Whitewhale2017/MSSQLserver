alter view v_cwlc_spsc  --屏蔽发起、归档状态
as
select a.requestId,c.workflowname,b.requestname,a.lcbh,b.creater,d.subcompanyid1 as 'syb',b.createdate,b.createtime,
a.fkgs,a.zje as 'zje',a.sdrq,e.nodename,b.currentnodeid,right(f.dspr,len(f.dspr)-1) as 'dczz',
DATEDIFF(day,b.createdate,case when a.sdrq='' then b.createdate when a.sdrq is null then b.createdate else a.sdrq end) as 'sdzts',
cast(round(DATEDIFF(HOUR,b.createdate+' '+b.createtime,convert(varchar(20),GETDATE(),120))/24.0,2) as numeric(20,2))as 'spzts'
from (
select requestId,lcbh,fkgs,hjjedx as 'zje',sdrq from formtable_main_75
union all
select requestId,lcbm as 'lcbh',fkgs,hjjedx as 'zje',sdrq from formtable_main_78
union all
select requestId,lcbm as 'lcbh',fkgs,jkje as 'zje',sdrq from formtable_main_90
union all
select requestId,lcbh as 'lcbh',fkgs,hjje as 'zje',sdrq from formtable_main_82
union all
select requestId,lcbm as 'lcbh',fkgs,hjjedx as 'zje',sdrq from formtable_main_147
) a
left join workflow_requestbase b
on a.requestId=b.requestid
left join workflow_base c
on b.workflowid=c.id
left join hrmresource d
on b.creater=d.id
left join workflow_nodebase e
on b.currentnodeid=e.id
left join (select requestid,nodeid,(select ','+cast(userid as varchar)
from workflow_currentoperator 
where requestid=t.requestid and nodeid=t.nodeid and isremark in (0,1,8,9) --0未操作 1转发 8抄送（不需提交） 9抄送需提交
for xml path(''))  as 'dspr'
from workflow_currentoperator t
group by requestid,nodeid
) f
on b.requestid=f.requestid 
where b.currentnodetype not in (3,0) -- and DATEDIFF(HOUR,b.createdate+' '+b.createtime,convert(varchar(10),GETDATE(),120))>24*17
and f.nodeid=b.currentnodeid





select requestid,nodeid,(select ','+cast(userid as varchar)
from workflow_currentoperator 
where requestid=t.requestid and nodeid=t.nodeid and isremark in (0,1,8,9)
for xml path(''))  as 'spr'
from workflow_currentoperator t
group by requestid,nodeid
select ','+cast(userid as varchar)
from workflow_currentoperator 
where requestid='111275' --and nodeid='651' and isremark in (0,1,8,9) 
for xml path('')

select a.requestId,
DATEDIFF(day,b.createdate,case when a.sdrq='' then b.createdate when a.sdrq is null then b.createdate else a.sdrq end) as 'sdzts',
a.sdrq,b.createdate
from formtable_main_78 a
left join workflow_requestbase b
on a.requestId=b.requestid



 








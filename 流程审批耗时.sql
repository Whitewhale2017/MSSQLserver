-------------单条流程耗时计算-----------------------------------------
select workflowid,requestid,requestname,createdate,createtime,lastoperatedate,lastoperatetime
,datediff(HOUR,createdate+' '+createtime,CONVERT(varchar(20),GETDATE(),120)) as spsc
from workflow_requestbase
where createdate>='2018-12-01' and createdate<='2018-12-31' and currentnodetype<>3
union all
select  workflowid,requestid,requestname,createdate,createtime,lastoperatedate,lastoperatetime
,dbo.jisuanshichang(createdate,createtime,lastoperatedate,lastoperatetime) as spsc
from workflow_requestbase
where createdate>='2018-12-01' and createdate<='2018-12-31' and currentnodetype=3

-------------类型流程耗时计算-----------------------------------------

select t.workflowid
,(select a.workflowname from workflow_base a where a.id=t.workflowid) as workflowname
,sum(spsc) as SPZSC,count(requestid) as LCSL,sum(spsc)/count(requestid) as PJHS
from  
(
select workflowid,requestid,requestname,createdate,createtime,lastoperatedate,lastoperatetime
,datediff(HOUR,createdate+' '+createtime,CONVERT(varchar(20),GETDATE(),120)) as spsc
from workflow_requestbase
where createdate>='2018-12-01' and createdate<='2018-12-31' and currentnodetype<>3
union all
select  workflowid,requestid,requestname,createdate,createtime,lastoperatedate,lastoperatetime
,dbo.jisuanshichang(createdate,createtime,lastoperatedate,lastoperatetime) as spsc
from workflow_requestbase
where createdate>='2018-12-01' and createdate<='2018-12-31' and currentnodetype=3
) t
group by workflowid
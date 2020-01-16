select workflowid,workflowname,requestid,requestname
 from (
select a.workflowid,c.workflowname,b.requestname,d.lastname
,e.nodename,operatedate,operatetime
,a.requestid,a.userid,a.nodeid
from workflow_currentoperator  a
left join workflow_requestbase b
on a.requestid=b.requestid
left join workflow_base c
on a.workflowid=c.id
left join hrmresource d
on a.userid=d.id
left join workflow_nodebase e
on a.nodeid=e.id
where operatedate='2019-07-11' and operatetime<='13:30:00'
and a.workflowid not in (1,55,105,36,39,40,45,53,54,41,52,60,67,68,77,79,80,84,86,91,94,109,110,122,157,161,171,179,181,183,185,190,198,200
,201,206,215,218,223,228,229,231,246,254,261,263,165,81,87,286,289,360,366,369,370,371,385,387,392,396,400,408,418,424,427)
and a.isremark in ('2','f') ----'2'已操作  'f'系统自动提交
) t
group by workflowid,workflowname,requestid,requestname



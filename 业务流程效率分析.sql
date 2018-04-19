select * from formtable_main_263 ---YGJX
select * from formtable_main_264 ---YGSD
select * from formtable_main_265 ---TTRJ
select * from formtable_main_253 ---新单流转


select * from workflow_requestbase where currentnodetype in (1,2)

select * from workflow_base


create view view_yewulcyx
as
select r.requestid,rb.requestname,(select workflowname from workflow_base where id=rb.workflowid) as workflowname,rb.workflowid,r.sqrq,
rb.createdate,rb.createtime,rb.lastoperatedate,rb.lastoperatetime,rb.currentnodetype,
(case when rb.currentnodetype=3 then '归档' when rb.currentnodetype=0 then '发起' else '审批' end) as status,
dbo.Jisuanshichang(rb.createdate,rb.createtime,rb.lastoperatedate,rb.lastoperatetime) as 'time'
from 
(select requestid,xytjrq as sqrq from formtable_main_263
union 
select requestid,xytjrq as sqrq from formtable_main_264 
union 
select requestid,xytjrq as sqrq from formtable_main_265 
union
select requestid,sqrq as sqrq from formtable_main_253) r
left join workflow_requestbase rb
on rb.requestid=r.requestid
--order by workflowid,sqrq

drop view view_yewulcyx

select * from view_yewulcyx


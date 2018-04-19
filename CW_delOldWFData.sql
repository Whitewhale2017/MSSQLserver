use ecology1019
go
update formtable_main_78 set sysm=null,sfhq=null,hqr=null where requestId in   --删除用款申请 事由,是否会签,会签人
(
select t.requestID from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=142
) t
)
go
update formtable_main_78_dt1 set XGLC=null where mainid in (        --删除用款申请 相关流程
select t.id from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=142
) t
)
go
update formtable_main_78 set sysm=null,sfhq=null,hqr=null where requestId in   --删除费用报销 事由,是否会签,会签人
(
select t.requestID from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=146
) t
)
go
update formtable_main_78_dt1 set XGLC=null where mainid in (        --删除费用报销 相关流程
select t.id from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=146
) t
)
go
update formtable_main_78 set sysm=null,sfhq=null,hqr=null where requestId in   --删除差旅费报销 事由,是否会签,会签人
(
select t.requestID from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=148
) t
)
go
update formtable_main_78_dt1 set XGLC=null where mainid in (        --删除差旅费报销 相关流程
select t.id from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=148
) t
)
go
update formtable_main_78_dt1 set XGLC=null where mainid in (        --删除特殊用款 相关流程
select t.id from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=249
) t
)
go
update formtable_main_78 set sysm=null,sfhq=null,hqr=null,XGLC=null where requestId in   --删除个人借款 事由,是否会签,会签人,相关流程
(
select t.requestID from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=150
) t
)
go
delete from workflow_requestLog where requestid in     --shanchu差旅费报销huiqianyijian 
(
 select t.requestid from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id  and w.workflowid=148
) t
)
and nodeid='2398'
go
delete from workflow_requestLog where requestid in     --shanchu费用报销huiqianyijian 
(
 select t.requestid from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id  and w.workflowid=146
) t
)
and nodeid='2400'
go
delete from workflow_requestLog where requestid in     --shanchu用款申请huiqianyijian 
(
 select t.requestid from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id  and w.workflowid=142
) t
)
and nodeid='2407'
go
delete from workflow_requestLog where requestid in     --shanchu个人借款huiqianyijian 
(
 select t.requestid from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id  and w.workflowid=150
) t
)
and nodeid='2402'
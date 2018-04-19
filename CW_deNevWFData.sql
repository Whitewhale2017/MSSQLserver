/*use ecology1019
需删除字段            事由sysm  相关流程 XGLC  是否会签 sfhq  会签人hqr    
费用报销    wfid 363    189        dt1           189           189
差旅费报销  wfid 361    187        dt1           187           187
用款申请    wfid 364    190        dt1           190           190
个人借款    wfid 365    191        191           191           191
 */                        
/*
select * from formtable_main_78

select sysm,XGLC,sfhq ,hqr from formtable_main_190
select XGLC from formtable_main_189_dt1

select * from formtable_main_189
select * from formtable_main_189_dt1

select sysm,XGLC,sfhq,r.lastname as hqr from formtable_main_90 f
left join Hrmresource r
on convert(varchar(20),f.hqr)=convert(varchar(20),r.id)
*/
use ecology
go
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
update formtable_main_190 set sysm=null,sfhq=null,hqr=null    --删除用款申请 事由,是否会签,会签人
go
update formtable_main_190_dt1 set XGLC=null        --删除用款申请 相关流程
go
update formtable_main_189 set sysm=null,sfhq=null,hqr=null   --删除费用报销 事由,是否会签,会签人
go
update formtable_main_189_dt1 set XGLC=null        --删除费用报销 相关流程
go
update formtable_main_187 set sysm=null,sfhq=null,hqr=null    --删除差旅费报销 事由,是否会签,会签人
go
update formtable_main_187_dt1 set XGLC=null       --删除差旅费报销 相关流程
go
update formtable_main_191 set sysm=null,sfhq=null,hqr=null,XGLC=null    --删除个人借款 事由,是否会签,会签人,相关流程
go
/*-------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
select * from workflow_requestLog where requestid in     --查询会签意见 
(
 select t.requestid from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_191 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id  and w.workflowid=365
) t
)
and nodeid='3700'
order by requestid
*/

delete from workflow_requestLog where requestid in     --删除差旅费报销会签意见 
(
 select t.requestid from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_187 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id  and w.workflowid=361
) t
)
and nodeid='2400'
go
delete from workflow_requestLog where requestid in     --删除费用报销会签意见 
(
 select t.requestid from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_189 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id  and w.workflowid=363
) t
)
and nodeid='3671'
go
delete from workflow_requestLog where requestid in     --删除用款申请会签意见 
(
 select t.requestid from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_190 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id  and w.workflowid=364
) t
)
and nodeid='3686'
go
delete from workflow_requestLog where requestid in     --删除个人借款会签意见 
(
 select t.requestid from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_191 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id  and w.workflowid=365
) t
)
and nodeid='3700'
 

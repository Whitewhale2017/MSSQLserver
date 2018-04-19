
需删除字段            事由sysm  相关流程 XGLC  是否会签 sfhq  会签人hqr    
费用报销    wfid 146    78         dt1             78            78
差旅费报销  wfid 148    78         dt1             78            78
用款申请    wfid 142    78         dt1             78            78
个人借款    wfid 150    78         78              78            78
特殊用款    wfid 249               dt1                             


select * from formtable_main_78

select sysm,XGLC,sfhq ,hqr from formtable_main_78
select XGLC from formtable_main_78_dt1

select * from formtable_main_78
select * from formtable_main_78_dt1

select f.requestId,f.id,d.mainid,d.ZY,d.XGLC from formtable_main_78_dt1 d,formtable_main_78 f
where d.mainid=f.id and d.XGLC is not null


select * from workflow_requestbase 
select * from  workflow_base

select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id  --and w.workflowid=142
order by w.workflowid
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
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

select f.requestId,f.id,d.mainid,d.ZY,d.XGLC from formtable_main_78_dt1 d,formtable_main_78 f --yan zheng用款申请 相关流程shi fou shan chu
where d.mainid=f.id and d.XGLC is not null and f.requestId in 
(
select t.requestId from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=142
) t
)
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
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

select f.requestId,f.id,d.mainid,d.ZY,d.XGLC from formtable_main_78_dt1 d,formtable_main_78 f --yan zheng费用报销 相关流程shi fou shan chu
where d.mainid=f.id and d.XGLC is not null and f.requestId in 
(
select t.requestId from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=146
) t
)
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
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

select f.requestId,f.id,d.mainid,d.ZY,d.XGLC from formtable_main_78_dt1 d,formtable_main_78 f --yan zheng差旅费报销 相关流程shi fou shan chu
where d.mainid=f.id and d.XGLC is not null and f.requestId in 
(
select t.requestId from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=148
) t
)
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
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

select f.requestId,f.id,d.mainid,d.ZY,d.XGLC from formtable_main_78_dt1 d,formtable_main_78 f --yan zheng特殊用款 相关流程shi fou shan chu
where d.mainid=f.id and d.XGLC is not null and f.requestId in 
(
select t.requestId from
(
select w.workflowid,b.workflowname,f.requestId,f.id,w.requestname from formtable_main_78 f
left join workflow_requestbase w
on f.requestId=w.requestid 
join workflow_base b
on w.workflowid=b.id and w.workflowid=249
) t
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

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

select requestId,XGLC,hqr,sfhq,sysm  from formtable_main_78 where requestId in(   --yan zheng 删除个人借款 事由,是否会签,会签人,相关流程
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
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
select * from workflow_requestLog where requestid in     --cha xun hui qian yi jian 
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
order by requestid

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
 

use ecology1019
go
update formtable_main_78 set sysm=null,sfhq=null,hqr=null where requestId in   --ɾ���ÿ����� ����,�Ƿ��ǩ,��ǩ��
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
update formtable_main_78_dt1 set XGLC=null where mainid in (        --ɾ���ÿ����� �������
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
update formtable_main_78 set sysm=null,sfhq=null,hqr=null where requestId in   --ɾ�����ñ��� ����,�Ƿ��ǩ,��ǩ��
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
update formtable_main_78_dt1 set XGLC=null where mainid in (        --ɾ�����ñ��� �������
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
update formtable_main_78 set sysm=null,sfhq=null,hqr=null where requestId in   --ɾ�����÷ѱ��� ����,�Ƿ��ǩ,��ǩ��
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
update formtable_main_78_dt1 set XGLC=null where mainid in (        --ɾ�����÷ѱ��� �������
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
update formtable_main_78_dt1 set XGLC=null where mainid in (        --ɾ�������ÿ� �������
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
update formtable_main_78 set sysm=null,sfhq=null,hqr=null,XGLC=null where requestId in   --ɾ�����˽�� ����,�Ƿ��ǩ,��ǩ��,�������
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
delete from workflow_requestLog where requestid in     --shanchu���÷ѱ���huiqianyijian 
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
delete from workflow_requestLog where requestid in     --shanchu���ñ���huiqianyijian 
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
delete from workflow_requestLog where requestid in     --shanchu�ÿ�����huiqianyijian 
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
delete from workflow_requestLog where requestid in     --shanchu���˽��huiqianyijian 
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
/*use ecology1019
��ɾ���ֶ�            ����sysm  ������� XGLC  �Ƿ��ǩ sfhq  ��ǩ��hqr    
���ñ���    wfid 363    189        dt1           189           189
���÷ѱ���  wfid 361    187        dt1           187           187
�ÿ�����    wfid 364    190        dt1           190           190
���˽��    wfid 365    191        191           191           191
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
update formtable_main_190 set sysm=null,sfhq=null,hqr=null    --ɾ���ÿ����� ����,�Ƿ��ǩ,��ǩ��
go
update formtable_main_190_dt1 set XGLC=null        --ɾ���ÿ����� �������
go
update formtable_main_189 set sysm=null,sfhq=null,hqr=null   --ɾ�����ñ��� ����,�Ƿ��ǩ,��ǩ��
go
update formtable_main_189_dt1 set XGLC=null        --ɾ�����ñ��� �������
go
update formtable_main_187 set sysm=null,sfhq=null,hqr=null    --ɾ�����÷ѱ��� ����,�Ƿ��ǩ,��ǩ��
go
update formtable_main_187_dt1 set XGLC=null       --ɾ�����÷ѱ��� �������
go
update formtable_main_191 set sysm=null,sfhq=null,hqr=null,XGLC=null    --ɾ�����˽�� ����,�Ƿ��ǩ,��ǩ��,�������
go
/*-------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
select * from workflow_requestLog where requestid in     --��ѯ��ǩ��� 
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

delete from workflow_requestLog where requestid in     --ɾ�����÷ѱ�����ǩ��� 
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
delete from workflow_requestLog where requestid in     --ɾ�����ñ�����ǩ��� 
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
delete from workflow_requestLog where requestid in     --ɾ���ÿ������ǩ��� 
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
delete from workflow_requestLog where requestid in     --ɾ�����˽���ǩ��� 
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
 


��ɾ���ֶ�            ����sysm  ������� XGLC  �Ƿ��ǩ sfhq  ��ǩ��hqr    
���ñ���    wfid 146    78         dt1             78            78
���÷ѱ���  wfid 148    78         dt1             78            78
�ÿ�����    wfid 142    78         dt1             78            78
���˽��    wfid 150    78         78              78            78
�����ÿ�    wfid 249               dt1                             


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

select f.requestId,f.id,d.mainid,d.ZY,d.XGLC from formtable_main_78_dt1 d,formtable_main_78 f --yan zheng�ÿ����� �������shi fou shan chu
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

select f.requestId,f.id,d.mainid,d.ZY,d.XGLC from formtable_main_78_dt1 d,formtable_main_78 f --yan zheng���ñ��� �������shi fou shan chu
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

select f.requestId,f.id,d.mainid,d.ZY,d.XGLC from formtable_main_78_dt1 d,formtable_main_78 f --yan zheng���÷ѱ��� �������shi fou shan chu
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

select f.requestId,f.id,d.mainid,d.ZY,d.XGLC from formtable_main_78_dt1 d,formtable_main_78 f --yan zheng�����ÿ� �������shi fou shan chu
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

select requestId,XGLC,hqr,sfhq,sysm  from formtable_main_78 where requestId in(   --yan zheng ɾ�����˽�� ����,�Ƿ��ǩ,��ǩ��,�������
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
 


--------------------------
isremark
0��δ����
1��ת��
2���Ѳ���
4���鵵
5����ʱ
8������(�����ύ)
9������(���ύ)
a: �����ѯ
b: �ظ�
h: ת��
j: ת���ύ
f: ϵͳ�Զ��ύ
--------------------------
create view v_glc_lcdb 
as
select a.userid,a.����,a.��ȫ����,a.�ֻ���,a.����,
a.lcdbzs as '�������̺ϼ�',
t.δ����,t.ת��,t.[����(���ύ)],t.[����(�����ύ)],
b.lcsl as '����ʱ������240H������' 
from (
select --top 55 
a.userid,b.lastname as '����',b.seclevel as '��ȫ����',count(requestid) as lcdbzs,b.mobile as '�ֻ���',b.email as '����'
from (
	select a.requestid,a.userid from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1'  and b.id not in (1) and isremark in ('0','1','8','9') --and c.createdate<='2017-08-17' and a.userid in  ('146') --('7020','1780','2662','6106')
	group by a.requestid,a.userid 
) a 
left join HrmResource b on a.userid = b.id
where seclevel>20 and 
status in (0,1,2,3)
group by a.userid,b.lastname,b.seclevel,b.email,b.mobile
--order by lcdbzs desc
) a
left join (
select userid,count(requestid) as lcsl 
from (select requestid,userid,max(dbsc) as dbsc from 
(
select a.requestid,d.typename,b.workflowname,a.userid,c.lastname,c.seclevel,a.isremark,receivedate,receivetime,
dbo.Jisuanshichang(receivedate,receivetime,left(convert(varchar(20),getdate(),120),10),right(convert(varchar(20),getdate(),120),8)) as dbsc
from workflow_currentoperator a
left join workflow_base b on a.workflowid = b.id
left join HrmResource c on a.userid = c.id
left join workflow_type d on b.workflowtype = d.id
where isvalid = '1' and b.id not in (1) and isremark in ('0','1','8','9') --and a.receivedate<='2017-08-08' and a.userid in  (select userid from v_lcdbtop50) --('7020','1780','2662','6106')
group by a.requestid,a.userid,a.isremark,receivedate,c.lastname,c.seclevel,b.workflowname,d.typename,receivetime
) a
group by requestid,userid) t
where dbsc>240
group by userid
) b
on a.userid=b.userid
left join (select userid,lastname,--isremark,
count(requestid) as '��������',
sum(case isremark when 0 then 1 else 0 end) as 'δ����',sum(case isremark when 1 then 1 else 0 end) as 'ת��',
sum(case when isremark=8 then 1 else 0 end) as '����(�����ύ)',sum(case isremark when 9 then 1 else 0 end) as '����(���ύ)'
from (
	select a.requestid,a.userid,a.isremark from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in ('0','1','8','9') 
	group by a.requestid,a.userid,a.isremark
) a  left join HrmResource b on a.userid = b.id
group by userid,lastname) t
on a.userid=t.userid

select * from v_glc_lcdb

drop view view_top50_glc


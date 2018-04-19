use ecology8

select count(*) from HrmResource where status in (0,1,2,3)
--����������
select count(*) from workflow_requestbase 
where createdate>='2017-07-24' and createdate<='2017-07-30' and workflowid <>1  
--�Ѱ������
select count(*) from workflow_requestbase 
where createdate>='2017-07-24' and createdate<='2017-07-30' and workflowid <>1  and currentnodetype = '3'  
--���ܰ������
select count(*) from workflow_requestbase 
where createdate>='2017-07-24' and createdate<='2017-07-30' and workflowid <>1  and currentnodetype = '3'  and lastoperatedate >='2017-07-24' and lastoperatedate <='2017-07-30'

--����ҵ������������
select c.subcompanyname,count(*) as zs from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2017-07-24' and a.createdate<='2017-07-30' and workflowid <>1  
group by c.subcompanyname

--����ҵ�����ܰ������
select c.subcompanyname,count(*) as dzbjzs from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2017-07-24' and a.createdate<='2017-07-30' and workflowid <>1  and currentnodetype = '3'  and lastoperatedate >='2017-07-24' and lastoperatedate <='2017-07-30'
group by c.subcompanyname

--����������
select count(*) from workflow_requestbase 
where createdate>='2017-07-31' and createdate<='2017-08-06' and workflowid <>1  
--�Ѱ������
select count(*) from workflow_requestbase 
where createdate>='2017-07-31' and createdate<='2017-08-06' and workflowid <>1  and currentnodetype = '3'  
--���ܰ������
select count(*) from workflow_requestbase 
where createdate>='2017-07-31' and createdate<='2017-08-06' and workflowid <>1  and currentnodetype = '3'  and lastoperatedate >='2017-07-31' and lastoperatedate <='2017-08-06'

--����ҵ������������
select c.subcompanyname,count(*) as zs from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2017-07-31' and a.createdate<='2017-08-06' and workflowid <>1  
group by c.subcompanyname

--����ҵ�����ܰ������
select c.subcompanyname,count(*) as dzbjzs from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2017-07-31' and a.createdate<='2017-08-06' and workflowid <>1  and currentnodetype = '3'  and lastoperatedate >='2017-07-31' and lastoperatedate <='2017-08-06'
group by c.subcompanyname

--drop view v_lcdbtop50
create view v_lcdbtop50 as
select top 50 a.userid,b.lastname,b.seclevel,count(requestid) as lcdbzs from (
	select a.requestid,a.userid from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) and c.createdate<='2017-08-08' --and a.userid in  ('146') --('7020','1780','2662','6106')
	group by a.requestid,a.userid 
) a left join HrmResource b on a.userid = b.id
group by a.userid,b.lastname,b.seclevel
order by lcdbzs desc

--drop view v_lcczlx
create view v_lcczlx as
select userid,isremark,COUNT(requestid) as lcczlxsl from (
	select a.requestid,a.userid,a.isremark from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) and c.createdate<='2017-08-08' and a.userid in  (select userid from v_lcdbtop50) --('7020','1780','2662','6106')
	group by a.requestid,a.userid,a.isremark
) a  left join HrmResource b on a.userid = b.id
group by isremark,userid

select * from v_lcdbtop50
select * from v_lcczlx

--����ʱ������
select left(convert(varchar(20),getdate(),120),10)
select right(convert(varchar(20),getdate(),120),8)

select convert(varchar(20),getdate(),120)

select GETDATE()

alter view v_dbsctj --����ʱ��ͳ��
as
select requestid,userid,max(dbsc) as dbsc from 
(
select a.requestid,d.typename,b.workflowname,a.userid,c.lastname,c.seclevel,a.isremark,receivedate,receivetime,
dbo.Jisuanshichang(receivedate,receivetime,left(convert(varchar(20),getdate(),120),10),right(convert(varchar(20),getdate(),120),8)) as dbsc
from workflow_currentoperator a
left join workflow_base b on a.workflowid = b.id
left join HrmResource c on a.userid = c.id
left join workflow_type d on b.workflowtype = d.id
where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) --and a.receivedate<='2017-08-08' and a.userid in  (select userid from v_lcdbtop50) --('7020','1780','2662','6106')
group by a.requestid,a.userid,a.isremark,receivedate,c.lastname,c.seclevel,b.workflowname,d.typename,receivetime
) a
group by requestid,userid


drop view v_lcdbtop50g


----��������ͳ��
create view v_lcdbtop50g as 
select top 55 a.userid,b.lastname as '����',b.seclevel as '��ȫ����',count(requestid) as lcdbzs,b.mobile as '�ֻ���',b.email as '����'from (
	select a.requestid,a.userid from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1'  and b.id not in (1) and isremark in (0,1,8,9) --and c.createdate<='2017-08-17' and a.userid in  ('146') --('7020','1780','2662','6106')
	group by a.requestid,a.userid 
) a left join HrmResource b on a.userid = b.id
where seclevel>20 and status in (0,1,2,3)
group by a.userid,b.lastname,b.seclevel,b.email,b.mobile
order by lcdbzs desc

select * from v_lcdbtop50g

select a.userid,a.����,a.��ȫ����,a.�ֻ���,--a.����,
a.lcdbzs as '�������̺ϼ�',
t.δ����,t.ת��,t.[����(���ύ)],t.[����(�����ύ)],
b.lcsl as '����ʱ������240H������' 
from v_lcdbtop50g a
left join (
select userid,count(requestid) as lcsl from v_dbsctj 
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
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) 
	group by a.requestid,a.userid,a.isremark
) a  left join HrmResource b on a.userid = b.id
group by userid,lastname) t
on a.userid=t.userid


drop view v_lcdbtop50y


----Ա������ͳ��
create view v_lcdbtop50y as
select top 50 a.userid,b.lastname,b.seclevel,count(requestid) as lcdbzs,b.mobile,b.email from (
	select a.requestid,a.userid from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) and c.createdate<='2017-08-17' --and a.userid in  ('146') --('7020','1780','2662','6106')
	group by a.requestid,a.userid 
) a left join HrmResource b on a.userid = b.id
where seclevel<20 and status in (0,1,2,3)
group by a.userid,b.lastname,b.seclevel,b.email,b.mobile
order by lcdbzs desc

select * from v_lcdbtop50y


----�����������
select * from (
select userid,lastname,isremark,(case isremark when 0 then 'δ����' when 1 then 'ת��' when 8 then '����(�����ύ)' when 9 then '����(���ύ)' end) as remark,COUNT(requestid) as lcczlxsl from (
	select a.requestid,a.userid,a.isremark from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) --and c.createdate<='2017-08-17' and a.userid in  (select userid from v_lcdbtop50g)
	group by a.requestid,a.userid,a.isremark
) a  left join HrmResource b on a.userid = b.id
group by isremark,userid,lastname
--order by userid
) t

----Ա���������
select userid,lastname,(case isremark when 0 then 'δ����' when 1 then 'ת��' when 8 then '����(�����ύ)' when 9 then '����(���ύ)' end) as isremark,COUNT(requestid) as lcczlxsl from (
	select a.requestid,a.userid,a.isremark from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) --and c.createdate<='2017-08-17' and a.userid in  (select userid from v_lcdbtop50y) 
	group by a.requestid,a.userid,a.isremark
) a  left join HrmResource b on a.userid = b.id
group by isremark,userid,lastname
order by userid

---�������̷���
select userid,lastname,--isremark,
count(requestid) as '��������',
sum(case isremark when 0 then 1 else 0 end) as 'δ����',sum(case isremark when 1 then 1 else 0 end) as 'ת��',
sum(case when isremark=8 then 1 else 0 end) as '����(�����ύ)',sum(case isremark when 9 then 1 else 0 end) as '����(���ύ)'
from (
	select a.requestid,a.userid,a.isremark from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) 
	group by a.requestid,a.userid,a.isremark
) a  left join HrmResource b on a.userid = b.id
group by userid,lastname
order by �������� desc

---�������̺ϼ�
alter view v_lcdb as
select a.userid,b.lastname,b.seclevel,count(requestid) as lcdbzs,b.mobile,b.email from (
	select a.requestid,a.userid from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9)
	group by a.requestid,a.userid 
) a left join HrmResource b on a.userid = b.id
where status in (0,1,2,3)
group by a.userid,b.lastname,b.seclevel,b.email,b.mobile
order by lcdbzs desc

select * from v_lcdb

select * from workflow_currentoperator order by requestid
select * from workflow_requestbase



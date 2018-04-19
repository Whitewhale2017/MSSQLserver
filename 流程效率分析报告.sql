use ecology8

select count(*) from HrmResource where status in (0,1,2,3)
--流程总数：
select count(*) from workflow_requestbase 
where createdate>='2017-07-24' and createdate<='2017-07-30' and workflowid <>1  
--已办结数：
select count(*) from workflow_requestbase 
where createdate>='2017-07-24' and createdate<='2017-07-30' and workflowid <>1  and currentnodetype = '3'  
--当周办结数：
select count(*) from workflow_requestbase 
where createdate>='2017-07-24' and createdate<='2017-07-30' and workflowid <>1  and currentnodetype = '3'  and lastoperatedate >='2017-07-24' and lastoperatedate <='2017-07-30'

--各事业部流程总数：
select c.subcompanyname,count(*) as zs from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2017-07-24' and a.createdate<='2017-07-30' and workflowid <>1  
group by c.subcompanyname

--各事业部当周办结数：
select c.subcompanyname,count(*) as dzbjzs from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2017-07-24' and a.createdate<='2017-07-30' and workflowid <>1  and currentnodetype = '3'  and lastoperatedate >='2017-07-24' and lastoperatedate <='2017-07-30'
group by c.subcompanyname

--流程总数：
select count(*) from workflow_requestbase 
where createdate>='2017-07-31' and createdate<='2017-08-06' and workflowid <>1  
--已办结数：
select count(*) from workflow_requestbase 
where createdate>='2017-07-31' and createdate<='2017-08-06' and workflowid <>1  and currentnodetype = '3'  
--当周办结数：
select count(*) from workflow_requestbase 
where createdate>='2017-07-31' and createdate<='2017-08-06' and workflowid <>1  and currentnodetype = '3'  and lastoperatedate >='2017-07-31' and lastoperatedate <='2017-08-06'

--各事业部流程总数：
select c.subcompanyname,count(*) as zs from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2017-07-31' and a.createdate<='2017-08-06' and workflowid <>1  
group by c.subcompanyname

--各事业部当周办结数：
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

--待办时长分析
select left(convert(varchar(20),getdate(),120),10)
select right(convert(varchar(20),getdate(),120),8)

select convert(varchar(20),getdate(),120)

select GETDATE()

alter view v_dbsctj --待办时长统计
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


----管理层待办统计
create view v_lcdbtop50g as 
select top 55 a.userid,b.lastname as '姓名',b.seclevel as '安全级别',count(requestid) as lcdbzs,b.mobile as '手机号',b.email as '邮箱'from (
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

select a.userid,a.姓名,a.安全级别,a.手机号,--a.邮箱,
a.lcdbzs as '待办流程合计',
t.未操作,t.转发,t.[抄送(需提交)],t.[抄送(不需提交)],
b.lcsl as '审批时长超过240H流程量' 
from v_lcdbtop50g a
left join (
select userid,count(requestid) as lcsl from v_dbsctj 
where dbsc>240
group by userid
) b
on a.userid=b.userid
left join (select userid,lastname,--isremark,
count(requestid) as '待办总量',
sum(case isremark when 0 then 1 else 0 end) as '未操作',sum(case isremark when 1 then 1 else 0 end) as '转发',
sum(case when isremark=8 then 1 else 0 end) as '抄送(不需提交)',sum(case isremark when 9 then 1 else 0 end) as '抄送(需提交)'
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


----员工待办统计
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


----管理层待办解析
select * from (
select userid,lastname,isremark,(case isremark when 0 then '未操作' when 1 then '转发' when 8 then '抄送(不需提交)' when 9 then '抄送(需提交)' end) as remark,COUNT(requestid) as lcczlxsl from (
	select a.requestid,a.userid,a.isremark from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) --and c.createdate<='2017-08-17' and a.userid in  (select userid from v_lcdbtop50g)
	group by a.requestid,a.userid,a.isremark
) a  left join HrmResource b on a.userid = b.id
group by isremark,userid,lastname
--order by userid
) t

----员工待办解析
select userid,lastname,(case isremark when 0 then '未操作' when 1 then '转发' when 8 then '抄送(不需提交)' when 9 then '抄送(需提交)' end) as isremark,COUNT(requestid) as lcczlxsl from (
	select a.requestid,a.userid,a.isremark from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) --and c.createdate<='2017-08-17' and a.userid in  (select userid from v_lcdbtop50y) 
	group by a.requestid,a.userid,a.isremark
) a  left join HrmResource b on a.userid = b.id
group by isremark,userid,lastname
order by userid

---待办流程分析
select userid,lastname,--isremark,
count(requestid) as '待办总量',
sum(case isremark when 0 then 1 else 0 end) as '未操作',sum(case isremark when 1 then 1 else 0 end) as '转发',
sum(case when isremark=8 then 1 else 0 end) as '抄送(不需提交)',sum(case isremark when 9 then 1 else 0 end) as '抄送(需提交)'
from (
	select a.requestid,a.userid,a.isremark from workflow_currentoperator a
	left join workflow_base b on a.workflowid = b.id
	left join workflow_requestbase c on a.requestid = c.requestid
	where isvalid = '1' and b.id not in (1) and isremark in (0,1,8,9) 
	group by a.requestid,a.userid,a.isremark
) a  left join HrmResource b on a.userid = b.id
group by userid,lastname
order by 待办总量 desc

---待办流程合计
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



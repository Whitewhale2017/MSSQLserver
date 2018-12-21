
--------------------------
isremark
0：未操作
1：转发
2：已操作
4：归档
5：超时
8：抄送(不需提交)
9：抄送(需提交)
a: 意见征询
b: 回复
h: 转办
j: 转办提交
f: 系统自动提交
--------------------------
create view v_glc_lcdb 
as
select a.userid,a.姓名,a.安全级别,a.手机号,a.邮箱,
a.lcdbzs as '待办流程合计',
t.未操作,t.转发,t.[抄送(需提交)],t.[抄送(不需提交)],
b.lcsl as '审批时长超过240H流程量' 
from (
select --top 55 
a.userid,b.lastname as '姓名',b.seclevel as '安全级别',count(requestid) as lcdbzs,b.mobile as '手机号',b.email as '邮箱'
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
count(requestid) as '待办总量',
sum(case isremark when 0 then 1 else 0 end) as '未操作',sum(case isremark when 1 then 1 else 0 end) as '转发',
sum(case when isremark=8 then 1 else 0 end) as '抄送(不需提交)',sum(case isremark when 9 then 1 else 0 end) as '抄送(需提交)'
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


select b.workcode,b.lastname,b.seclevel,e.lastname,c.subcompanyname,d.departmentname,cjlczgs,
(ltrim(zhs/60) +'小时'+right('0'+ltrim(zhs%60),2)+'分'+ltrim(zhs%60)+'秒') as zhs,
(ltrim(pjhs/60) +'小时'+right('0'+ltrim(pjhs%60),2)+'分'+ltrim(pjhs%60)+'秒') as averagehs from (
	select COUNT(requestid) as cjlczgs,userid as id,SUM(ss) as zhs,SUM(ss)/COUNT(requestid) as pjhs from (
		select a.requestid,a.ss,b.requestname,userid from (
			select a.requestid,sum(DATEDIFF(MINUTE,receivedate+' '+receivetime,operatedate+' '+operatetime)) as ss,userid from	workflow_currentoperator a 
			left join workflow_nodebase b on a.nodeid = b.id 
			where 1=1 and a.workflowid not in (1,93,94,137) and b.isstart not in (1) and isend not in (1)  
			and a.isremark not in (1,8) and preisremark not in (1,8,9) and a.receivedate >='2017-01-09' and a.receivedate <= '2017-01-15' and a.operatedate <='2017-01-15'
			group by a.requestid,userid
		) a left join workflow_requestbase b on a.requestid = b.requestid
	) t1 group by userid
) a 
left join hrmresource b on a.id = b.id 
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join HrmDepartment d on b.departmentid = d.id
left join HrmResource e on b.managerid = e.id
where b.seclevel >'10'
order by a.pjhs desc 

create table WeHelpuLog(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[workcode] [varchar](100) NULL,
	[lastname] [varchar](100) NULL,
	[signature] [varchar](50) NULL,
	[result] [varchar](100) NULL,
	[fail_text] [varchar](500) NULL,
	[timestamp] [char](50) NULL
)

select * from WeHelpuLog

select * from HtmlLabelInfo where labelname like '%姓名%'
select * from HtmlLabelInfo where labelname like '%开始日期%'
select * from HtmlLabelInfo where labelname like '%结束日期%'
select * from HtmlLabelInfo where labelname like '加班%'
select * from HtmlLabelInfo where labelname like '%事由%'

select * from HtmlLabelInfo where labelname like '%发起人%'
select * from HtmlLabelInfo where labelname like '开始日期%'
select * from HtmlLabelInfo where labelname like '结束日期%'
select * from HtmlLabelInfo where labelname like '调休%'
select * from HtmlLabelInfo where labelname like '%事由%'
select * from HtmlLabelInfo where labelname like '%会议时间%'

select * from HtmlLabelInfo where labelname like '%开始结束时间%'
select * from HtmlLabelInfo where labelname like '%请假类型%'
select * from HtmlLabelInfo where labelname like '%请假原因%'

select * from HtmlLabelInfo where labelname like '%入职日期%'
select * from HtmlLabelInfo where labelname like '%申请日期%'
select * from HtmlLabelInfo where labelname like '%添加%'
select * from workflow_base where workflowname like 'RS-%'

select * from HtmlLabelInfo where indexid ='82'

RS-01-考勤管理-请假/调休流程V0.9		18	NULL	-31


select a.id,b.workcode,a.sqrq,b.lastname,jbksrq+' '+jbkssj as ksrq,jbjsrq+' '+jbjssj as jsrq,jbsc,jbsy        
from formtable_main_30 a left join HrmResource b on a.sqr = b.id left join workflow_requestbase c on a.requestId = c.requestid
where jbhcl = '0' and c.currentnodetype = '3' and b.workcode = 'SXL0043'
order by a.id desc

select a.id,b.workcode,a.tbrq,b.lastname,qsrq+' '+qssj as ksrq,jsrq+' '+jssj as jsrq,qjsc,qjyy        
from formtable_main_31 a left join HrmResource b on a.sqr = b.id left join workflow_requestbase c on a.requestId = c.requestid
where qjlx = '1' and c.currentnodetype = '3' and b.workcode = 'SXL0043'
order by a.id desc

select a.id,b.workcode,a.tbrq,b.lastname,qsrq+' '+qssj as ksrq,jsrq+' '+jssj as jsrq,qjsc,qjyy        
from formtable_main_31 a left join HrmResource b on a.sqr = b.id left join workflow_requestbase c on a.requestId = c.requestid
where qjlx = '0' and c.currentnodetype = '3' and b.workcode = 'SXL0043'
order by a.id desc

select count(*) from SysMaintenanceLog 
where operatedate >='2016-01-01' and operatedate<='2016-12-31'
and relatedid <>1
327099+29524

select * from HrmDepartment

select * from workflow_requestLog

select t1.clientip, t1.logtype,t1.operatedate,t1.operatetime,t1.workflowid,t1.operator,t1.requestid, t2.creater, t2.requestname,t3.subcompanyid1,t3.departmentid 
from workflow_requestLog t1,workflow_requestbase t2,HrmResource t3
where t1.requestid=t2.requestid and t2.creater =  t3.id
order by t1.operatedate desc,t1.operatetime desc

 select resourceid,tbrq,qjlx,ksrq+' '+kssj as ksrq,jsrq+' '+jssj as jsrq,qjts,qjyy from empxxqjd
drop table [empxxqjd]
CREATE TABLE [dbo].[empxxqjd](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tbr] [int] NULL,
	[tbrq] [char](10) NULL,
	[workcode] [char](15) NULL,	
	[qjlx] [char](10) NULL,
	[ksrq] [char](10) NULL,
	[kssj] [char](5) NULL,
	[jsrq] [char](10) NULL,
	[jssj] [char](5) NULL,
	[qjts] [float] NULL,
	[qjyy] [text] NULL
)
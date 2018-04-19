use ecology
go
if exists(select count(*) from sysobjects where id='dbo.Ckmlxlcsplbyname')
drop function dbo.Ckmlxlcsplbyname
go
create function  Ckmlxlcsplbyname(@workflowname varchar(200),@username varchar(100))
returns table
as
return
(
         select l.requestid,(select requestname from workflow_requestbase where requestid=l.requestid) as requestname
		 from workflow_requestlog l
		 where requestid in
                (select requestid  --,requestname 
				from workflow_requestbase
                where requestid in(
                select requestid from workflow_currentoperator
                where workflowid=(select id from workflow_base where workflowname=@workflowname) 
                and  userid=(select id from Hrmresource where lastname=@username)) 
				and l.logtype!= '2'
		        and l.logtype != 't'  
				and operator=(select id from Hrmresource where lastname=@username)
)
)

go 
select * from Ckmlxlcsplbyname('TY_月度优秀员工评选提醒流程V2.0','唐宇')
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
use ecology
go
if exists(select count(*) from sysobjects where id='dbo.Ckmlxlcsplbyname_and_times')
drop function dbo.Ckmlxlcsplbyname_and_times
go
create function  Ckmlxlcsplbyname_and_times(@workflowname varchar(200),@username varchar(100))
returns table
as
return
(
        select l.requestid,(select requestname from workflow_requestbase where requestid=l.requestid) as requestname,
		DATEDIFF(SECOND,d.receivedate+' '+d.receivetime,d.operatedate+' '+d.operatetime) as seconds,
		cast(ROUND((DATEDIFF(MINUTE,d.receivedate+' '+d.receivetime,d.operatedate+' '+d.operatetime)/60.0),2) as numeric(20,2))as hours
		 from workflow_requestlog l
		 left join workflow_currentoperator d
		  on  d.requestid=l.requestid and d.userid=(select id from Hrmresource where lastname=@username) and isremark=2
		 where l.requestid in
                (select requestid  
				from workflow_requestbase
                where requestid in(
                select requestid from workflow_currentoperator
                where workflowid=(select id from workflow_base where workflowname=@workflowname) 
                and  userid=(select id from Hrmresource where lastname=@username)) 
				and d.workflowid <> '1'
				and l.logtype!= '2'
		        and l.logtype != 't'  
				and operator=(select id from Hrmresource where lastname=@username)
				
)
)


go 

select * from
(select * from Ckmlxlcsplbyname_and_times('签呈（自由汇报）','岑荣德')) b where b.hours<>0



select * from workflow_currentoperator where requestid='29813' and userid='1572'

select   cast( round(1222.5255,2)   as   numeric(20,2)) 

select * from HrmResource where lastname='唐宇'

select * from workflow_requestLog where requestid='57962'
---------------------------------------------------------------------------------------
use ecology
go
if exists(select count(*) from sysobjects where id='dbo.Ckmlxlcsplbyname_and_times2')
drop function dbo.Ckmlxlcsplbyname_and_times2
go
create function  Ckmlxlcsplbyname_and_times2(@workflowname varchar(200),@username varchar(100))
returns table
as
return
(
        select d.requestid,(select requestname from workflow_requestbase where requestid=d.requestid) as requestname,
		DATEDIFF(SECOND,d.receivedate+' '+d.receivetime,d.operatedate+' '+d.operatetime) as seconds,
		cast(ROUND((DATEDIFF(MINUTE,d.receivedate+' '+d.receivetime,d.operatedate+' '+d.operatetime)/60.0),2) as numeric(20,2))as hours
		 from workflow_currentoperator d
		where
	    d.workflowid <> '1'
	    and d.workflowid = (select id from workflow_base where workflowname=@workflowname)
	    and userid = (select id from Hrmresource where lastname=@username)
	    and d.requestid in (select requestid from workflow_requestLog where operator =(select id from Hrmresource where lastname=@username) 
		and logtype != '2' and logtype != 't')
		and isremark='2'
				
)

select * from
(select * from Ckmlxlcsplbyname_and_times2('签呈（自由汇报）','岑荣德')) b order by b.hours desc



 select d.requestid,(select requestname from workflow_requestbase where requestid=d.requestid) as requestname,
		DATEDIFF(SECOND,d.receivedate+' '+d.receivetime,d.operatedate+' '+d.operatetime) as seconds,
		cast(ROUND((DATEDIFF(MINUTE,d.receivedate+' '+d.receivetime,d.operatedate+' '+d.operatetime)/60.0),2) as numeric(20,2))as hours
		 from workflow_currentoperator d
		where
	    d.workflowid <> '1'
	    and d.workflowid = (select id from workflow_base where workflowname='签呈（自由汇报）')
	    and userid = '3'
	    and d.requestid in (select requestid from workflow_requestLog where operator ='3' 
		and logtype != '2' and logtype != 't')
		and isremark='2'




select * from workflow_requestLog where requestid='55193'
select * from workflow_requestbase where requestid='55193'
select * from workflow_base where id='285'
select nodename from workflow_nodebase 


select (select nodename from workflow_nodebase where id=d.nodeid) as nodename,d.nodeid,
         max(cast(ROUND((DATEDIFF(MINUTE,d.receivedate+' '+d.receivetime,d.operatedate+' '+d.operatetime)/60.0),2) as numeric(20,2)))as hours
		 from workflow_currentoperator d
		 where requestid='55193' 
		 group by nodeid 


		


select * from workflow_currentoperator d where requestid='55193'order by nodeid

SELECT DATEDIFF(MINUTE,'2008-12-29','2008-12-30') AS DiffDate



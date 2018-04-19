use ecology
go
create function Splchz(@userid int)
returns table
as
return (select 
h.workflowid,
h.name,
h.workflowNum
--h.times,
--(right('0'+ltrim(h.times/h.workflowNum/60/24),2) +'天'+right('0'+ltrim(h.times/h.workflowNum/60%24),2) +'小时'+right('0'+ltrim(h.times/h.workflowNum%60),2)+'分') as averagehs
from(
	select 
		a.workflowid as workflowid,
		(select workflowname from workflow_base b where b.id = a.workflowid) as name,
		count(a.workflowid) as workflowNum,
		    ( select
				sum(DATEDIFF(MINUTE,receivedate+' '+receivetime,operatedate+' '+operatetime))
			from 
				workflow_currentoperator d
			where
				d.workflowid <> '1'
				and d.workflowid = a.workflowid
				and userid = @userid
		     ) as times
	from
		workflow_requestLog a
	where 
		operator = @userid
		and logtype != '2'
		and logtype != 't'
		group by a.workflowid
)h
)
go 
select * from  Splchz(5)

select* from HrmResource 

select requestid ,requestname 
from workflow_requestbase
where requestid in(
select requestid from workflow_currentoperator
where workflowid='112' and  userid='3')


select * from Ckmlxlcspl('277',3)

use ecology
go
create function Splchz(@userid int)
returns table
as
return (select 
h.workflowid,
h.name,
h.workflowNum
--h.times,
--(right('0'+ltrim(h.times/h.workflowNum/60/24),2) +'天'+right('0'+ltrim(h.times/h.workflowNum/60%24),2) +'小时'+right('0'+ltrim(h.times/h.workflowNum%60),2)+'分') as averagehs
from(
	select 
		a.workflowid as workflowid,
		(select workflowname from workflow_base b where b.id = a.workflowid) as name,
		count(a.workflowid) as workflowNum,
		    ( select
				sum(DATEDIFF(MINUTE,receivedate+' '+receivetime,operatedate+' '+operatetime))
			from 
				workflow_currentoperator d
			where
				d.workflowid <> '1'
				and d.workflowid = a.workflowid
				and userid = @userid
		     ) as times
	from
		workflow_requestLog a
	where 
		operator = @userid
		and logtype != '2'
		and logtype != 't'
		group by a.workflowid
)h
)
go 

select * from  Splchz()
select * from Ckmlxlcspl('359',1583)

----屏蔽抄送---------------
use ecology
go
if exists(select count(*) from sysobjects where id='dbo.Ckmlxlcspl')
drop function dbo.Ckmlxlcspl
go
create function Ckmlxlcspl(@workflowid varchar(100),@userid int)
returns table 
as
return 
(
   select l.requestid,(select requestname from workflow_requestbase where requestid=l.requestid) as requestname 
    from workflow_requestLog l,
   ( select requestid from workflow_currentoperator
     where workflowid=@workflowid and userid=@userid
   ) b
   where b.requestid=l.requestid and l.logtype!= '2'
		 and l.logtype != 't'  
   group by l.requestid  
)

------------------------------------------------------------------


use ecology
go
if exists(select count(*) from sysobjects where id='dbo.Ckmlxlcspl')
drop function dbo.Ckmlxlcspl
go
create function  Ckmlxlcspl(@workflowid varchar(100),@userid int)
returns table
as
return
(
select requestid,requestname from workflow_requestbase
where requestid in(
select requestid from workflow_currentoperator
where workflowid=@workflowid and  userid=@userid) 
)
go 
select * from Ckmlxlcspl('277',3)

use ecology
go
if exists(select count(*) from sysobjects where id='Splchz')
drop　function dbo.Splchz
go
create function Splchz(@userid int)
returns table
as
return (select 
h.workflowid,
h.name,
h.workflowNum
--h.times,
--(right('0'+ltrim(h.times/h.workflowNum/60/24),2) +'天'+right('0'+ltrim(h.times/h.workflowNum/60%24),2) +'小时'+right('0'+ltrim(h.times/h.workflowNum%60),2)+'分') as averagehs
from(
	select 
		a.workflowid as workflowid,
		(select workflowname from workflow_base b where b.id = a.workflowid) as name,
		count(a.workflowid) as workflowNum,
		    ( select
				sum(DATEDIFF(MINUTE,receivedate+' '+receivetime,operatedate+' '+operatetime))
			from 
				workflow_currentoperator d
			where
				d.workflowid <> '1'
				and d.workflowid = a.workflowid
				and userid = @userid
		     ) as times
	from
		workflow_requestLog a
	where 
		operator = @userid
		and logtype != '2'
		and logtype != 't'
		group by a.workflowid
)h
)
go 

select * from  Splchz(3) order by workflowid

select * from Ckmlxlcspl('48',3)



select * from workflow_currentoperator
select id from workflow_base where workflowname='TY-录用审批流程(无接口)'
select *from Hrmresource where lastname='李丰芹'
-------------------------------------------------------------------
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
select * from Ckmlxlcsplbyname('签呈单','')
--select l1.requestid,l1.nodeid,l1.logtype,l1.operatedate,l1.operatetime,l1.destnodeid,l2.operatedate,l2.operatetime,dbo.Jisuanshichang(l1.operatedate,l1.operatetime,l2.operatedate,l2.operatetime) from workflow_requestLog l1
--left join workflow_requestLog l2
--on l2.requestid=l1.requestid and l2.nodeid=l1.destnodeid
--where l1.workflowid=352 --and l1.logtype!='t' 
--order by l1.requestid,l1.operatedate,l1.operatetime

select (select nodename from workflow_nodebase where id=nodeid)as nodename,* from workflow_requestLog where requestid=34158 order by nodename

select c.requestid,(select lastname from hrmresource where id=userid) as username,nodeid,usertype,n.nodename,
receivedate,receivedate,operatedate,operatetime,dbo.Jisuanshichang(receivedate,receivetime,operatedate,operatetime) as 'caozuosc'
from workflow_currentoperator c
left join workflow_nodebase n
on n.id=nodeid
where workflowid=352 order by requestid,nodename

select * from workflow_currentoperator where workflowid=352 order by requestid





select * from workflow_base where id=352

select * from workflow_nodebase

select (select nodename from workflow_nodebase where id=workflow_nodelink.nodeid),* from workflow_nodelink where workflowid=445

select * from workflow_requestbase where workflowid=352 order by requestid

-------------------calculate time--------------------------------------
-----------------------------------------------------------------------
drop function dbo.Jisuanshichang


create function Jisuanshichang(@begindate varchar(20),@begintime varchar(20),@enddate varchar(20),@endtime varchar(20))--计算时长
returns numeric(20,2)
as
begin
   declare @res numeric(20,2)
   if (@enddate is null or @enddate='' or @begindate is null or @begindate=''or @begintime is null or @begintime='' 
   or @endtime is null or @endtime='')
   set @res=0.00
   else
   set @res=cast(ROUND((DATEDIFF(MINUTE,@begindate+' '+@begintime,@enddate+' '+@endtime)/60.0),2) as numeric(20,2))
   return @res
   --return cast(ROUND((DATEDIFF(MINUTE,@begindate+' '+@begintime,@enddate+' '+@endtime)/60.0),2) as numeric(20,2))
end



select requestid,cast(ROUND((DATEDIFF(MINUTE,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)/60.0),2) as numeric(20,2)) as hours
from workflow_requestbase 

select requestid,dbo.Jisuanshichang(createdate,createtime,lastoperatedate,lastoperatetime)
from workflow_requestbase 

where createdate is not null and createdate != '' 
and createtime is not null and createtime != '' 
and lastoperatedate is not null and lastoperatedate != '' 
and lastoperatetime is not null and lastoperatetime != '' 

select cast(ROUND((DATEDIFF(MINUTE,'2016-06-01 00:00:00','2016-06-02 00:00:00')/60.0),2) as numeric(20,2))

select dbo.Jisuanshichang('2016-06-01','00:00:00','2016-06-02','')

-------------------calculate time--------------------------------------
-----------------------------------------------------------------------

create proc Jiedianshichang(@formname varchar(50),@nodeid varchar(20))--计算时长
as 
begin
declare @str as varchar(1000)
set @str='select a.requestid,b.receivedate,b.receivetime,b.operatedate,b.operatetime,
(select nodename from workflow_nodebase where id=b.nodeid),
dbo.Jisuanshichang(b.receivedate,b.receivetime,b.operatedate,b.operatetime) as time
from '+@formname+''+' a left join workflow_currentoperator b on a.requestId = b.requestid
left join workflow_nodebase c on b.nodeid = c.id
left join workflow_requestbase d on a.requestId = d.requestid
where  b.nodeid ='+@nodeid
print @str
exec (@str)
end

print 'select a.requestid,b.receivedate,b.receivetime,b.operatedate,b.operatetime,
(select nodename from workflow_nodebase where id=b.nodeid),
dbo.Jisuanshichang(b.receivedate,b.receivetime,b.operatedate,b.operatetime) as time
from '+'formtable_main_265'+''+' a left join workflow_currentoperator b on a.requestId = b.requestid
left join workflow_nodebase c on b.nodeid = c.id
left join workflow_requestbase d on a.requestId = d.requestid
where  b.nodeid ='+'5315'


exec dbo.Jiedianshichang  'formtable_main_265','5315'

--select * from workflow_requestbase
--select * from workflow_requestLog

--select * from workflow_currentoperator where requestid='113306' 

--select * from workflow_nodebase
--select * from workflow_nodelink


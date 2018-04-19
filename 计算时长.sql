select * from workflow_requestlog
select * from workflow_requestbase

--use ecology
--go
--if exists(select * from sysobjects where name='dbo.Jisuanshichang') 
drop function dbo.Jisuanshichang


create function Jisuanshichang(@begindate varchar(20),@begintime varchar(20),@enddate varchar(20),@endtime varchar(20))--º∆À„ ±≥§
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

select datediff(HOUR,'2017-06-01 00:00:00',CONVERT(varchar(20),GETDATE(),120))



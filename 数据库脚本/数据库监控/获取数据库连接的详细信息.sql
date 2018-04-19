--获取当前正在执行的TSQL和存储过程的执行情况

declare @spid int
declare @sql varchar(max)
declare @count int
declare @time datetime
set @time=GETDATE()

create table #temp_sql
(
	eventtype varchar(128),
	sparameters int,
	eventinfo varchar(max)
)
create table #temp
(
	spid int,
	proccess_count int,
	eventinfo varchar(max)
)

declare cur cursor for select spid,COUNT(*)  from sys.sysprocesses 
where db_name([dbid]) not in (N'distribution,',N'master',N'model',N'msdb',N'tempdb') and [status]<>N'sleeping' and spid>50
group by spid 
open cur 
fetch cur into @spid,@count
while @@FETCH_STATUS=0
begin
	set @sql=N'dbcc inputbuffer('+LTRIM(str(@spid))+N')'
	insert into #temp_sql
	exec sp_sqlexec @sql
	insert into #temp select top 1 @spid,@count,eventinfo from #temp_sql
	delete from #temp_sql
	fetch cur into @spid,@count
end
close cur
deallocate cur
select * from #temp
drop table #temp
drop table #temp_sql
go

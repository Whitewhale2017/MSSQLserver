--每隔2秒获取当前数据库正在执行的TSQL语句和存储过程
if exists(select * from sys.objects where name='GetMulProccessSql')
drop table GetMulProccessSql
go
create table GetMulProccessSql
(
	starttime datetime null,
	spid int,
	proccessCount int,
	t_sql varchar(max)
)
GO
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
while @time<'2014-06-17 18:00:00.000'
begin
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
		insert into GetMulProccessSql select top 1 @time,@spid,@count,eventinfo from #temp_sql
		delete from #temp_sql
		fetch cur into @spid,@count
	end
	close cur
	deallocate cur
	waitfor delay '00:00:02'
	set @time=GETDATE()
end
drop table #temp_sql
go
create table #temp
(
	tbname varchar(128) ,
	indexname varchar(128),
	avg_fragmentation_in_percent float
)
declare @tbid bigint
declare @tbname varchar(128)
declare @ixid int
declare @ixname varchar(128)
declare @sql varchar(max)
declare cur cursor for SELECT obj.[object_id] as tbid,obj.[name] as tbname, ix.name as indexname,ix.index_id as ixid  FROM sys.objects as obj join sys.indexes as ix on obj.[object_id] =ix.[object_id] 
where obj.type_desc='USER_TABLE' 
group by obj.[object_id],obj.[name],ix.name,ix.index_id
having ix.name is not null
open cur
fetch cur into @tbid,@tbname,@ixname,@ixid
while @@FETCH_STATUS=0
begin
	insert into #temp
	select @tbname,@ixname,avg_fragmentation_in_percent  from sys.dm_db_index_physical_stats(DB_ID(),@tbid,@ixid,null,null)	
	fetch cur into @tbid,@tbname,@ixname,@ixid
end
close cur
deallocate cur
select * from #temp where avg_fragmentation_in_percent>30
--AND indexname NOT LIKE 'PK_%' 
ORDER BY tbname asc,indexname DESC

DROP TABLE #temp
GO

DECLARE @I INT
declare @tb_name varchar(128)
declare @column varchar(128)
DECLARE @sql varchar(max)
create table #temp(id int)
declare cur cursor for select N'['+sch.name+N'].'+obj.name,col.name from sys.objects  as obj join sys.columns as col on obj.[object_id] =col.[object_id] 
JOIN sys.schemas as sch on sch.[schema_id]=obj.[schema_id]
where col.is_identity=1
and obj.type_desc='USER_TABLE'
open cur 
fetch cur into @tb_name,@column
while @@FETCH_STATUS=0
begin
	SET @sql=N'SELECT MAX(['+@column+N'])+1 from '+@tb_name 
	insert into #temp
	exec (@sql)
	select @I=id from #temp
	IF(@I IS NOT NULL)
	BEGIN
		DBCC CHECKIDENT (@tb_name,RESEED,@I)
	END
	truncate table #temp
	fetch cur into @tb_name,@column
end
close cur
deallocate cur 

DROP TABLE #temp
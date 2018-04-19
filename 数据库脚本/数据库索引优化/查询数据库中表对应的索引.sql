--查询所有索引
declare @name varchar(100)
declare @object_id bigint
declare @index_name varchar(200)
declare @type_desc varchar(20)
create table #temp_index
(
	tb_name varchar(100),
	tb_index varchar(200),
	type_desc varchar(20)
)
declare cur cursor for select name , [object_id] from sys.objects where type_desc=N'USER_TABLE'
open cur 
fetch cur into @name,@object_id
while @@FETCH_STATUS=0
begin
	declare cur_1 cursor for select name,type_desc from sys.indexes where [object_id]=@object_id
	open cur_1 
	fetch cur_1 into @index_name,@type_desc
	while @@FETCH_STATUS=0
	begin
		insert into #temp_index values(@name,@index_name,@type_desc)
		fetch cur_1 into @index_name,@type_desc
	end
	close cur_1
	deallocate cur_1
	fetch cur into @name,@object_id
end
close cur
deallocate cur

--select a.* from (
--select tb_name from #temp_index group by tb_name) as a left join (
--select tb_name from #temp_index where type_desc =N'CLUSTERED') as b on a.tb_name=b.tb_name 
--where b.tb_name is null
--查询所有表空间大小
CREATE TABLE #temp  
    (  
      name VARCHAR(100),  
      rows INT ,  
      reserved varchar(20),  
      data varchar(20),  
      index_size varchar(20),  
      unused varchar(20)  
        
    )  
    
DECLARE @tablename VARCHAR(100)  
DECLARE @sql VARCHAR(500)  
DECLARE @str VARCHAR(100)  
DECLARE tablecursor CURSOR  
FOR  
    SELECT  name  
    FROM    sysobjects  
    WHERE   xtype = 'u'   
OPEN tablecursor  
FETCH NEXT FROM tablecursor INTO @tablename  
WHILE @@fetch_status = 0   
    BEGIN  
        SET @str = @tablename  
        SET @sql = N'insert into  #temp EXEC sp_spaceused [' + @tablename +N']'    
        EXEC(@sql)   
        FETCH NEXT FROM tablecursor INTO @tablename  
    END  
CLOSE tablecursor  
DEALLOCATE tablecursor  
--SELECT  *  
--FROM    #temp WHERE CONVERT(INT,SUBSTRING(data,1,len(data)-2))>100000 order by name
--查询大于100MB,但没有建立聚集索引的表
select tb_name  from #temp_index as a join #temp as b on a.tb_name=b.name 
WHERE CONVERT(INT,SUBSTRING(data,1,len(data)-2))>100000 
and tb_name not in ( select tb_name from #temp_index where type_desc = N'CLUSTERED')
group by tb_name
order by tb_name 
DROP TABLE #temp 
drop table #temp_index

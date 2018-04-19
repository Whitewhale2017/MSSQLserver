CREATE TABLE #tablespaceinfo
(
  nameinfo VARCHAR(500) ,
  rowscount BIGINT ,
  reserved VARCHAR(20) ,
  datainfo VARCHAR(20) ,
  index_size VARCHAR(20) ,
  unused VARCHAR(20),   
  rowdatainfo decimal(18,2),
  remark nvarchar(20)

)
declare @name varchar(500)
declare cur cursor for select name from sys.objects where type_desc='USER_TABLE' and is_ms_shipped=0
open cur 
fetch cur into @name
while @@FETCH_STATUS=0
begin
	insert into #tablespaceinfo(nameinfo,rowscount,reserved,datainfo,index_size,unused) exec sp_spaceused @objname=@name
	fetch cur into @name
end
close cur
deallocate cur
update #tablespaceinfo set rowdatainfo= case when rowscount =0 then 0 when datainfo='8 KB' then -1 else CAST(replace(datainfo,'KB','') as bigint)*1024.0/rowscount end ,
 remark= case when datainfo='8 KB' then N'计算不准确' end
select * from  #tablespaceinfo order by rowscount desc

drop table #tablespaceinfo 
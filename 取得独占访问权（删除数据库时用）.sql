sp_who

sp_who2 --查询进程

kill 63 --杀死进程

use master  --取得独占访问权限
ALTER DATABASE ecology SET OFFLINE WITH ROLLBACK IMMEDIATE
go
ALTER database ecology set online 


use master
go
--建一个存储过程，断开所有用户连接。
create proc killspid (@dbname varchar(20))
as
begin
declare @sql nvarchar(500)
declare @spid int
set @sql='declare getspid cursor for 
select spid from sysprocesses where dbid=db_id('''+@dbname+''')'
exec (@sql)
open getspid
fetch next from getspid into @spid
while @@fetch_status<>-1
begin
exec('kill '+@spid)
fetch next from getspid into @spid
end
close getspid
deallocate getspid
end

go

--用法
use master
--exec killspid '数据库名'
exec killspid 'ecology'

ALTER DATABASE ecology SET MULTI_USER --设置多用户模式

USE master
EXEC sp_dboption 'ecology', 'single user', 'TRUE'
go
DBCC CHECKDB( 'ecology',REPAIR_ALLOW_DATA_LOSS)
go
EXEC sp_dboption 'ecology', 'single user', 'false'
go




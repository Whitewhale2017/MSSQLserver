sp_who

sp_who2 --��ѯ����

kill 63 --ɱ������

use master  --ȡ�ö�ռ����Ȩ��
ALTER DATABASE mchr SET OFFLINE WITH ROLLBACK IMMEDIATE
go
ALTER database mchr set online 


use master
go
--��һ���洢���̣��Ͽ������û����ӡ�
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

--�÷�
use master
--exec killspid '���ݿ���'
exec killspid 'ecology'

ALTER DATABASE mchr SET MULTI_USER --���ö��û�ģʽ

USE master
EXEC sp_dboption 'ecology', 'single user', 'TRUE'
go
DBCC CHECKDB( 'ecology',REPAIR_ALLOW_DATA_LOSS)
go
EXEC sp_dboption 'ecology', 'single user', 'false'
go




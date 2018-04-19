IF EXISTS(SELECT * FROM sys.databases WHERE name='TestRestoreByLog')
DROP DATABASE TestRestoreByLog
GO
CREATE DATABASE TestRestoreByLog
GO
--创建新表
USE TestRestoreByLog
GO
if exists(select * from sys.objects where name ='tb_Class')
drop table tb_Class
go
CREATE TABLE dbo.tb_Class
(
	ClassID int identity(1,1) primary key not null,
	ClassName varchar(10)
)
go
--完整备份
use master
go
backup database TestRestoreByLog to disk='E:\database_bak\TestRestoreByLog.bak' with init
go
--导入数据
USE TestRestoreByLog
GO
insert into tb_Class (ClassName)
select ClassName from TestLoggingShip.dbo.tb_Class
go
----分离数据库
--USE [master]
--GO
--ALTER DATABASE [TestDB] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
--GO
--USE [master]
--GO
--EXEC master.dbo.sp_detach_db @dbname = N'TestDB', @skipchecks = 'false'
--GO
--尾日志备份
use master
go
BACKUP LOG [TestRestoreByLog] TO  DISK = N'E:\database_bak\TestRestoreByLog_log.bak' WITH NOFORMAT, INIT, SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
USE master
GO
RESTORE DATABASE TestRestoreByLog FROM DISK=N'E:\database_bak\TestRestoreByLog.bak' with norecovery,REPLACE
RESTORE DATABASE TestRestoreByLog FROM DISK=N'E:\database_bak\TestRestoreByLog_log.bak' with norecovery
RESTORE DATABASE TestRestoreByLog with recovery
GO
use TestRestoreByLog
go
insert into dbo.tb_Class(ClassName) values('I')
go
delete from dbo.tb_Class where ClassID between 3 and 7
go
use master
go
BACKUP LOG [TestRestoreByLog] TO  DISK = N'E:\database_bak\TestRestoreByLog_log_1.bak' WITH NOFORMAT, INIT, SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO 
USE master
GO
RESTORE DATABASE TestRestoreByLog FROM DISK=N'E:\database_bak\TestRestoreByLog.bak' with norecovery,REPLACE
go
RESTORE DATABASE TestRestoreByLog FROM DISK=N'E:\database_bak\TestRestoreByLog_log.bak' with norecovery
go
RESTORE DATABASE TestRestoreByLog 
FROM DISK=N'E:\database_bak\TestRestoreByLog_log_1.bak' with norecovery ,stopat='2014-07-01 16:42:30.000'
go
RESTORE DATABASE TestRestoreByLog with recovery
GO
use TestRestoreByLog
go
insert into dbo.tb_Class(ClassName) values('I')
go
use master
go
BACKUP LOG TestRestoreByLog TO  DISK = N'E:\database_bak\TestRestoreByLog_log_2.bak' WITH NOFORMAT, INIT, SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
use TestRestoreByLog
go
delete from dbo.tb_Class where ClassID between 3 and 7
go
use master
go
BACKUP LOG TestRestoreByLog TO  DISK = N'E:\database_bak\TestRestoreByLog_log_3.bak' WITH NOFORMAT, INIT, SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
USE master
GO
RESTORE DATABASE TestRestoreByLog FROM DISK=N'E:\database_bak\TestRestoreByLog.bak' with norecovery,REPLACE
go
RESTORE DATABASE TestRestoreByLog FROM DISK=N'E:\database_bak\TestRestoreByLog_log.bak' with norecovery
go
RESTORE DATABASE TestRestoreByLog 
FROM DISK=N'E:\database_bak\TestRestoreByLog_log_1.bak' with norecovery 
go
RESTORE DATABASE TestRestoreByLog 
FROM DISK=N'E:\database_bak\TestRestoreByLog_log_2.bak' with norecovery 
go
RESTORE DATABASE TestRestoreByLog 
FROM DISK=N'E:\database_bak\TestRestoreByLog_log_3.bak' with norecovery ,stopat='2014-07-01 16:03:09.000'
go
RESTORE DATABASE TestRestoreByLog with recovery
GO


--数据库改由单用户改为多用户
ALTER DATABASE TestRestoreByLog SET  MULTI_USER 
GO
--还原数据库并移动数据库文件
RESTORE DATABASE [HR] FROM  DISK = N'E:\hr.bak' WITH  FILE = 1,  MOVE N'kaoqin_Data' TO N'D:\MSSQL\hr.mdf',  MOVE N'kaoqin_Log' TO N'D:\MSSQL\hr.ldf',  NOUNLOAD,  REPLACE,  STATS = 10
GO

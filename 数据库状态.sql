--1，关闭数据库连接

USE [master];
GO
ALTER DATABASE [DatabaseName]
SET OFFLINE WITH ROLLBACK IMMEDIATE
--3，修改数据库状态为正常状态

USE master GO
RESTORE DATABASE [DatabaseName] WITH RECOVERY;
--2，连接数据库

ALTER DATABASE [DatabaseName]
SET ONLINE
--经过这3个步骤后，数据库就变成正常状态。






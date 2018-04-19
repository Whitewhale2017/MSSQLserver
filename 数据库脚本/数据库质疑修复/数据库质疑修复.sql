--恢复数据库置疑状态sp_resetstatus 
EXEC [sys]. [sp_resetstatus] @DBName = 'GPOSDB'
--重置置疑数据库的状态

--sp_resetstatus 关闭数据库上的置疑标记。此过程更新 sysdatabases 中的命名数据库的模式和状态列。
--在运行此过程之前，应参考 SQL Server 错误日志并解决所有问题。执行 sp_resetstatus 后停止并重新启动SQL Server。
--由于某些原因，数据库可能成为置疑状态。
--可能的原因包括操作系统拒绝对数据库资源的访问，以及一个或多个数据库文件不可用性或已损坏。

ALTER DATABASE [GPOSDB] SET EMERGENCY
GO
DBCC CHECKDB ( 'GPOSDB') WITH NO_INFOMSGS ,ALL_ERRORMSGS


ALTER DATABASE [GPOSDB] SET SINGLE_USER  WITH ROLLBACK IMMEDIATE

EXEC sys.SP_CONFIGURE 'ALLOW UPDATES' , 1
RECONFIGURE WITH OVERRIDE
GO
RECONFIGURE WITH OVERRIDE
GO

DBCC checkdb( 'GPOSDB',REPAIR_ALLOW_DATA_LOSS )
GO

ALTER DATABASE [GPOSDB] SET MULTI_USER
GO


ALTER DATABASE [GPOSDB] SET ONLINE
GO
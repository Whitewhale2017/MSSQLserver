/*

测试项目：

测试做了表分区的文件组还原。

*/


--创建测试数据库
USE master
GO
IF EXISTS(SELECT * FROM sys.databases  WHERE name='DB_BackupAndRestore')
DROP DATABASE DB_BackupAndRestore
GO
CREATE DATABASE DB_BackupAndRestore
GO
--添加文件组
ALTER DATABASE DB_BackupAndRestore
ADD FILEGROUP FG_TEST_1
GO
ALTER DATABASE DB_BackupAndRestore
ADD FILEGROUP FG_TEST_2
GO
--添加数据文件
ALTER DATABASE DB_BackupAndRestore
ADD FILE
(
	NAME='DATA_TEST_1',
	FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\DATA_TEST_1.NDF',
	SIZE=3MB
) TO FILEGROUP FG_TEST_1
GO
ALTER DATABASE DB_BackupAndRestore
ADD FILE
(
	NAME='DATA_TEST_2',
	FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\DATA_TEST_2.NDF',
	SIZE=3MB
) TO FILEGROUP FG_TEST_2
GO
--创建分区函数
USE DB_BackupAndRestore
GO
CREATE PARTITION FUNCTION TestPartFunc(int) AS RANGE LEFT FOR VALUES(10000,20000)
GO
--创建分区架构
CREATE PARTITION SCHEME TestPartSche AS PARTITION TestPartFunc TO ([PRIMARY],FG_TEST_1,FG_TEST_2)
GO
--创建分区表
CREATE TABLE [dbo].[temp_trc_Order_five](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationName] [varchar](128) NULL,
	[TextData] [varchar](max) NULL,
	[Duration] [bigint] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Reads] [bigint] NULL,
	[Writes] [bigint] NULL,
	[CPU] [int] NULL,
	[Type] [varchar](10) NULL,
	[Type_desc] [varchar](128) NULL
) ON TestPartSche([RowNumber])
GO
--建立全文目录
CREATE FULLTEXT CATALOG FullText_Test AS DEFAULT;
--创建索引
create unique index UQ_RowNumber on [dbo].[temp_trc_Order_five]([RowNumber]) ON TestPartSche([RowNumber])
create clustered index IX_Clustered_StartTime on [dbo].[temp_trc_Order_five]([StartTime]) ON TestPartSche([RowNumber])
create nonclustered index IX_Clustered_EndTime on [dbo].[temp_trc_Order_five]([EndTime]) ON TestPartSche([RowNumber])
create nonclustered index IX_Clustered_Duration on [dbo].[temp_trc_Order_five]([Duration]) ON TestPartSche([RowNumber])
GO
--创建全文索引
CREATE FULLTEXT INDEX ON [dbo].[temp_trc_Order_five]([TextData]) 
KEY INDEX UQ_RowNumber 
WITH STOPLIST = SYSTEM
GO

--导入数据
INSERT INTO dbo.temp_trc_Order_five( TextData,ApplicationName, Duration, StartTime, EndTime, Reads, Writes, CPU)
SELECT TextData,[ApplicationName],Duration, StartTime, EndTime, Reads, Writes, CPU
FROM fn_trace_gettable('E:\Profiler_ERPSystem\2014-08-27\无标题 - 1.trc', 5)
where  ApplicationName in('.Net SqlClient Data Provider','Microsoft SQL Server','PHP 5','jTDS')
and TextData not like 'exec sp_reset_connection '
and TextData not like 'select getdate()'
GO
--查看数据
SELECT * FROM temp_trc_Order_five
GO

--查看全文索引状态
EXEC sp_help_fulltext_catalogs 'FullText_Test'
GO
--备份数据库,日志,文件组
BACKUP DATABASE DB_BackupAndRestore TO DISK='E:\database_bak\DB_BackupAndRestore_Full.bak' WITH INIT
BACKUP LOG DB_BackupAndRestore TO DISK='E:\database_bak\DB_BackupAndRestore_Log.bak' WITH INIT
BACKUP DATABASE DB_BackupAndRestore FILE = 'DATA_TEST_2',FILEGROUP='FG_TEST_2' TO DISK='E:\database_bak\DB_BackupAndRestore_File.bak' WITH INIT
GO
--更新数据
UPDATE temp_trc_Order_five SET Type='PROC' WHERE RowNumber>20000
GO
--查看数据
SELECT * FROM temp_trc_Order_five WHERE RowNumber>20000
GO
--还原数据库
/*
	注意：
	直接将还原选项改为WITH RECOVERY,在查询时,RowNumber>20000的数据同样不可查询，此时，DATA_TEST_2文件是处于脱机状态.
	可以通过下面查询文件状态语句查看文件状态
*/

USE master
GO
RESTORE DATABASE DB_BackupAndRestore FILE = 'DATA_TEST_2',FILEGROUP='FG_TEST_2' FROM DISK='E:\database_bak\DB_BackupAndRestore_File.bak' WITH NORECOVERY
GO
--查看数据被更新的数据库是否还原
/*
查询报错:

消息 679，级别 16，状态 1，第 1 行
表 'dbo.temp_trc_Order_five' 的索引 'IX_Clustered_StartTime' 的分区之一(分区 ID 72057594039304192)
所驻留的文件组("FG_TEST_2")因为处于离线状态或正在还原或已经不存在而无法访问。
这种情况可能会限制查询结果。
*/
USE DB_BackupAndRestore
GO
SELECT * FROM temp_trc_Order_five WHERE RowNumber>20000
GO
--查看未被更新的数据
SELECT * FROM temp_trc_Order_five WHERE RowNumber<=20000
GO

/*
当前数据库只有部分可用,即被还原的文件不可用
*/
--查看文件状态
USE DB_BackupAndRestore
GO
SELECT * FROM sys.database_files
GO
/*
需要还原之前备份的日志，先采用WITH RECOVERY选项试试
结果报错：


消息 4326，级别 16，状态 1，第 1 行
此备份集中的日志终止于 LSN 176000000054700001，该 LSN 太早，无法应用到数据库。可以还原包含 LSN 176000000056400001 的较新的日志备份。
消息 3013，级别 16，状态 1，第 1 行
RESTORE LOG 正在异常终止。

*/
USE master
GO
RESTORE LOG DB_BackupAndRestore FROM DISK='E:\database_bak\DB_BackupAndRestore_Log.bak' WITH FILE=1,RECOVERY
GO
/*
必须重头开始，删除数据库后，再次使用文件组还原一次数据库
现在再对日志使用WITH NORECOVERY选项

报错:
消息 4326，级别 16，状态 1，第 1 行
此备份集中的日志终止于 LSN 113000000081200001，该 LSN 太早，无法应用到数据库。可以还原包含 LSN 113000000136900001 的较新的日志备份。
消息 3013，级别 16，状态 1，第 1 行
RESTORE LOG 正在异常终止。

*/

USE master
GO
RESTORE LOG DB_BackupAndRestore FROM DISK='E:\database_bak\DB_BackupAndRestore_Log.bak' WITH FILE=1,NORECOVERY
GO

/*
备份尾日志,并使用尾日志还原.

结果:
数据并没有还原到被更新前.
*/
USE master
GO
BACKUP LOG DB_BackupAndRestore TO DISK='E:\database_bak\DB_BackupAndRestore_Log_Final.bak' WITH INIT,NO_TRUNCATE
GO
USE master
GO
RESTORE LOG DB_BackupAndRestore FROM DISK='E:\database_bak\DB_BackupAndRestore_Log_Final.bak' WITH RECOVERY
GO

/*

	结论：在表做了分区之后，由于当前日志和备份日志之间的冲突，导致还原失败。
	
	经验：
	
	1、文件组还原，只适合完整恢复模式的数据库。
	2、当表做了分区之后，无法做文件组还原。
	

*/
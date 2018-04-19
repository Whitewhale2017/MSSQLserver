/*

������Ŀ��

�������˱�������ļ��黹ԭ��

*/


--�����������ݿ�
USE master
GO
IF EXISTS(SELECT * FROM sys.databases  WHERE name='DB_BackupAndRestore')
DROP DATABASE DB_BackupAndRestore
GO
CREATE DATABASE DB_BackupAndRestore
GO
--����ļ���
ALTER DATABASE DB_BackupAndRestore
ADD FILEGROUP FG_TEST_1
GO
ALTER DATABASE DB_BackupAndRestore
ADD FILEGROUP FG_TEST_2
GO
--��������ļ�
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
--������������
USE DB_BackupAndRestore
GO
CREATE PARTITION FUNCTION TestPartFunc(int) AS RANGE LEFT FOR VALUES(10000,20000)
GO
--���������ܹ�
CREATE PARTITION SCHEME TestPartSche AS PARTITION TestPartFunc TO ([PRIMARY],FG_TEST_1,FG_TEST_2)
GO
--����������
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
--����ȫ��Ŀ¼
CREATE FULLTEXT CATALOG FullText_Test AS DEFAULT;
--��������
create unique index UQ_RowNumber on [dbo].[temp_trc_Order_five]([RowNumber]) ON TestPartSche([RowNumber])
create clustered index IX_Clustered_StartTime on [dbo].[temp_trc_Order_five]([StartTime]) ON TestPartSche([RowNumber])
create nonclustered index IX_Clustered_EndTime on [dbo].[temp_trc_Order_five]([EndTime]) ON TestPartSche([RowNumber])
create nonclustered index IX_Clustered_Duration on [dbo].[temp_trc_Order_five]([Duration]) ON TestPartSche([RowNumber])
GO
--����ȫ������
CREATE FULLTEXT INDEX ON [dbo].[temp_trc_Order_five]([TextData]) 
KEY INDEX UQ_RowNumber 
WITH STOPLIST = SYSTEM
GO

--��������
INSERT INTO dbo.temp_trc_Order_five( TextData,ApplicationName, Duration, StartTime, EndTime, Reads, Writes, CPU)
SELECT TextData,[ApplicationName],Duration, StartTime, EndTime, Reads, Writes, CPU
FROM fn_trace_gettable('E:\Profiler_ERPSystem\2014-08-27\�ޱ��� - 1.trc', 5)
where  ApplicationName in('.Net SqlClient Data Provider','Microsoft SQL Server','PHP 5','jTDS')
and TextData not like 'exec sp_reset_connection '
and TextData not like 'select getdate()'
GO
--�鿴����
SELECT * FROM temp_trc_Order_five
GO

--�鿴ȫ������״̬
EXEC sp_help_fulltext_catalogs 'FullText_Test'
GO
--�������ݿ�,��־,�ļ���
BACKUP DATABASE DB_BackupAndRestore TO DISK='E:\database_bak\DB_BackupAndRestore_Full.bak' WITH INIT
BACKUP LOG DB_BackupAndRestore TO DISK='E:\database_bak\DB_BackupAndRestore_Log.bak' WITH INIT
BACKUP DATABASE DB_BackupAndRestore FILE = 'DATA_TEST_2',FILEGROUP='FG_TEST_2' TO DISK='E:\database_bak\DB_BackupAndRestore_File.bak' WITH INIT
GO
--��������
UPDATE temp_trc_Order_five SET Type='PROC' WHERE RowNumber>20000
GO
--�鿴����
SELECT * FROM temp_trc_Order_five WHERE RowNumber>20000
GO
--��ԭ���ݿ�
/*
	ע�⣺
	ֱ�ӽ���ԭѡ���ΪWITH RECOVERY,�ڲ�ѯʱ,RowNumber>20000������ͬ�����ɲ�ѯ����ʱ��DATA_TEST_2�ļ��Ǵ����ѻ�״̬.
	����ͨ�������ѯ�ļ�״̬���鿴�ļ�״̬
*/

USE master
GO
RESTORE DATABASE DB_BackupAndRestore FILE = 'DATA_TEST_2',FILEGROUP='FG_TEST_2' FROM DISK='E:\database_bak\DB_BackupAndRestore_File.bak' WITH NORECOVERY
GO
--�鿴���ݱ����µ����ݿ��Ƿ�ԭ
/*
��ѯ����:

��Ϣ 679������ 16��״̬ 1���� 1 ��
�� 'dbo.temp_trc_Order_five' ������ 'IX_Clustered_StartTime' �ķ���֮һ(���� ID 72057594039304192)
��פ�����ļ���("FG_TEST_2")��Ϊ��������״̬�����ڻ�ԭ���Ѿ������ڶ��޷����ʡ�
����������ܻ����Ʋ�ѯ�����
*/
USE DB_BackupAndRestore
GO
SELECT * FROM temp_trc_Order_five WHERE RowNumber>20000
GO
--�鿴δ�����µ�����
SELECT * FROM temp_trc_Order_five WHERE RowNumber<=20000
GO

/*
��ǰ���ݿ�ֻ�в��ֿ���,������ԭ���ļ�������
*/
--�鿴�ļ�״̬
USE DB_BackupAndRestore
GO
SELECT * FROM sys.database_files
GO
/*
��Ҫ��ԭ֮ǰ���ݵ���־���Ȳ���WITH RECOVERYѡ������
�������


��Ϣ 4326������ 16��״̬ 1���� 1 ��
�˱��ݼ��е���־��ֹ�� LSN 176000000054700001���� LSN ̫�磬�޷�Ӧ�õ����ݿ⡣���Ի�ԭ���� LSN 176000000056400001 �Ľ��µ���־���ݡ�
��Ϣ 3013������ 16��״̬ 1���� 1 ��
RESTORE LOG �����쳣��ֹ��

*/
USE master
GO
RESTORE LOG DB_BackupAndRestore FROM DISK='E:\database_bak\DB_BackupAndRestore_Log.bak' WITH FILE=1,RECOVERY
GO
/*
������ͷ��ʼ��ɾ�����ݿ���ٴ�ʹ���ļ��黹ԭһ�����ݿ�
�����ٶ���־ʹ��WITH NORECOVERYѡ��

����:
��Ϣ 4326������ 16��״̬ 1���� 1 ��
�˱��ݼ��е���־��ֹ�� LSN 113000000081200001���� LSN ̫�磬�޷�Ӧ�õ����ݿ⡣���Ի�ԭ���� LSN 113000000136900001 �Ľ��µ���־���ݡ�
��Ϣ 3013������ 16��״̬ 1���� 1 ��
RESTORE LOG �����쳣��ֹ��

*/

USE master
GO
RESTORE LOG DB_BackupAndRestore FROM DISK='E:\database_bak\DB_BackupAndRestore_Log.bak' WITH FILE=1,NORECOVERY
GO

/*
����β��־,��ʹ��β��־��ԭ.

���:
���ݲ�û�л�ԭ��������ǰ.
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

	���ۣ��ڱ����˷���֮�����ڵ�ǰ��־�ͱ�����־֮��ĳ�ͻ�����»�ԭʧ�ܡ�
	
	���飺
	
	1���ļ��黹ԭ��ֻ�ʺ������ָ�ģʽ�����ݿ⡣
	2���������˷���֮���޷����ļ��黹ԭ��
	

*/
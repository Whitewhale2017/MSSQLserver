--�ָ����ݿ�����״̬sp_resetstatus 
EXEC [sys]. [sp_resetstatus] @DBName = 'GPOSDB'
--�����������ݿ��״̬

--sp_resetstatus �ر����ݿ��ϵ����ɱ�ǡ��˹��̸��� sysdatabases �е��������ݿ��ģʽ��״̬�С�
--�����д˹���֮ǰ��Ӧ�ο� SQL Server ������־������������⡣ִ�� sp_resetstatus ��ֹͣ����������SQL Server��
--����ĳЩԭ�����ݿ���ܳ�Ϊ����״̬��
--���ܵ�ԭ���������ϵͳ�ܾ������ݿ���Դ�ķ��ʣ��Լ�һ���������ݿ��ļ��������Ի����𻵡�

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
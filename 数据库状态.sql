--1���ر����ݿ�����

USE [master];
GO
ALTER DATABASE [DatabaseName]
SET OFFLINE WITH ROLLBACK IMMEDIATE
--3���޸����ݿ�״̬Ϊ����״̬

USE master GO
RESTORE DATABASE [DatabaseName] WITH RECOVERY;
--2���������ݿ�

ALTER DATABASE [DatabaseName]
SET ONLINE
--������3����������ݿ�ͱ������״̬��






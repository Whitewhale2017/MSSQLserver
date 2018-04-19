/*
	��������������Ĵ�����
*/

--��������������Ĵ�������������sa�˻�ֻ���ڱ�����ָ��IP��¼
--������IP��192.168.1.96
--ָ��IP��192.168.55.92
USE master
GO
CREATE TABLE TriggerLog (LogInfo xml)
GO
CREATE TRIGGER [tr_connection_limit]
ON ALL SERVER WITH EXECUTE AS 'sa'
FOR LOGON
AS
BEGIN
	--����test����ʺŵ�����
	IF ORIGINAL_LOGIN()= 'sa'
	--����test�ڱ����������IP��¼
	AND (SELECT EVENTDATA().value('(/EVENT_INSTANCE/ClientHost)[1]', 'NVARCHAR(15)'))
	NOT IN('<local machine>','192.168.1.96','192.168.55.92')
		BEGIN
			DECLARE @XML XML
			SET @XML=EVENTDATA()
			ROLLBACK;
			INSERT INTO TriggerLog VALUES(@XML)
		END
END;
GO
/*
	ɾ��������
*/
DROP TRIGGER [tr_connection_limit] ON ALL SERVER

GO
/*
	�������ݿ⼶�𴥷���
*/
USE MASTER
GO
CREATE TABLE TriggerLog (LogInfo xml)
GO
-- Create a dummy table to delete later on
CREATE TABLE TableToDelete (Id int PRIMARY KEY)
GO
-- �½�һ���±���Ϊɾ��ʵ���
INSERT INTO TableToDelete VALUES(1)
GO

-- ����һ��Drop Table �� DDL
CREATE TRIGGER StopTableDrop ON DATABASE AFTER DROP_TABLE
AS
  DECLARE @EventData AS xml
  SET @EventData = EVENTDATA() -- ����Ҫ��rollback֮ǰ�ػ�DDL��Ϣ
  ROLLBACK
  PRINT 'DROP TABLE attempt in database ' + DB_NAME() + '.'
  INSERT INTO TriggerLog VALUES(@EventData)
GO
DROP TABLE TableToDelete
GO
SELECT * FROM TriggerLog
GO

/*
	ɾ�����ݿ⼶�𴥷���
*/
DROP TRIGGER [StopTableDrop] ON DATABASE
GO

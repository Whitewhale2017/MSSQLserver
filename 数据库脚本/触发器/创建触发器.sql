/*
	创建服务器级别的触发器
*/

--创建服务器级别的触发器用来限制sa账户只能在本机和指定IP登录
--服务器IP：192.168.1.96
--指定IP：192.168.55.92
USE master
GO
CREATE TABLE TriggerLog (LogInfo xml)
GO
CREATE TRIGGER [tr_connection_limit]
ON ALL SERVER WITH EXECUTE AS 'sa'
FOR LOGON
AS
BEGIN
	--限制test这个帐号的连接
	IF ORIGINAL_LOGIN()= 'sa'
	--允许test在本机和下面的IP登录
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
	删除触发器
*/
DROP TRIGGER [tr_connection_limit] ON ALL SERVER

GO
/*
	创建数据库级别触发器
*/
USE MASTER
GO
CREATE TABLE TriggerLog (LogInfo xml)
GO
-- Create a dummy table to delete later on
CREATE TABLE TableToDelete (Id int PRIMARY KEY)
GO
-- 新建一个新表，作为删除实验表
INSERT INTO TableToDelete VALUES(1)
GO

-- 创建一个Drop Table 的 DDL
CREATE TRIGGER StopTableDrop ON DATABASE AFTER DROP_TABLE
AS
  DECLARE @EventData AS xml
  SET @EventData = EVENTDATA() -- 必须要在rollback之前截获DDL信息
  ROLLBACK
  PRINT 'DROP TABLE attempt in database ' + DB_NAME() + '.'
  INSERT INTO TriggerLog VALUES(@EventData)
GO
DROP TABLE TableToDelete
GO
SELECT * FROM TriggerLog
GO

/*
	删除数据库级别触发器
*/
DROP TRIGGER [StopTableDrop] ON DATABASE
GO


use master;
--Script1：创建test登录账号
--CREATE LOGIN 
--test WITH PASSWORD = '123'
--GO
CREATE TRIGGER tr_connection_limit
ON ALL SERVER WITH EXECUTE AS 'sa'
FOR LOGON
AS
BEGIN
--限制test这个帐号的连接
IF ORIGINAL_LOGIN()= 'mytest'
--允许test在本机和下面的IP登录
AND
(SELECT EVENTDATA().value('(/EVENT_INSTANCE/ClientHost)[1]', 'NVARCHAR(15)'))
NOT IN('<local machine>','172.16.1.30')
     ROLLBACK;
END;
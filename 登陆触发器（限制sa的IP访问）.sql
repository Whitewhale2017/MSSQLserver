
use master;
--Script1������test��¼�˺�
--CREATE LOGIN 
--test WITH PASSWORD = '123'
--GO
CREATE TRIGGER tr_connection_limit
ON ALL SERVER WITH EXECUTE AS 'sa'
FOR LOGON
AS
BEGIN
--����test����ʺŵ�����
IF ORIGINAL_LOGIN()= 'mytest'
--����test�ڱ����������IP��¼
AND
(SELECT EVENTDATA().value('(/EVENT_INSTANCE/ClientHost)[1]', 'NVARCHAR(15)'))
NOT IN('<local machine>','172.16.1.30')
     ROLLBACK;
END;
USE [master]
GO
CREATE SERVER AUDIT MyFileAudit TO FILE(FILEPATH='D:\sqlaudits') --这里指定文件夹不能指定文件，生成文件都会保存在这个文件夹
GO
USE [master]
GO
CREATE SERVER AUDIT MyFileAudit TO FILE(
FILEPATH='D:\sqlaudits',
MAXSIZE=4GB,
MAX_ROLLOVER_FILES=6) 
WITH (
ON_FAILURE=CONTINUE,
QUEUE_DELAY=1000);

GO
ALTER SERVER AUDIT MyFileAudit WITH(STATE =ON)
GO
--配置数据库CSOS_NEW_2的dbo.OrderInfo表为缓存表
DECLARE @DB_ID INT
SET @DB_ID=DB_ID('CSOS_NEW_2')
DECLARE @OBJECT_ID INT
SET @OBJECT_ID=OBJECT_ID('dbo.OrderInfo')
DBCC PINTABLE (@DB_ID,@OBJECT_ID)
GO
--开启缓存设置
EXEC sp_tableoption 'OrderInfo','pintable', 'true'
GO
--查询dbo.OrderInfo,把数据读取到内存中
SELECT * FROM dbo.OrderInfo

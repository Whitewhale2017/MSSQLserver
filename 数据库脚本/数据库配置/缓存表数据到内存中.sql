--�������ݿ�CSOS_NEW_2��dbo.OrderInfo��Ϊ�����
DECLARE @DB_ID INT
SET @DB_ID=DB_ID('CSOS_NEW_2')
DECLARE @OBJECT_ID INT
SET @OBJECT_ID=OBJECT_ID('dbo.OrderInfo')
DBCC PINTABLE (@DB_ID,@OBJECT_ID)
GO
--������������
EXEC sp_tableoption 'OrderInfo','pintable', 'true'
GO
--��ѯdbo.OrderInfo,�����ݶ�ȡ���ڴ���
SELECT * FROM dbo.OrderInfo

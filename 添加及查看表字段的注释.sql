------
1��sqlserver��������ע��
EXECUTE sp_addextendedproperty N'MS_Description', N'��ע��', N'user', N'dbo', N'table', N'����', NULL, NULL

2��sqlserver��������ġ��ֶΡ�ע��
EXECUTE sp_addextendedproperty N'MS_Description', N'�ֶ�ע��', N'user', N'dbo', N'table', N'����', N'column', N'�ֶ���'

3���鿴sqlserverע��

SELECT
A.name AS table_name,
B.name AS column_name,
C.value AS column_description
FROM sys.tables A
INNER JOIN sys.columns B ON B.object_id = A.object_id
LEFT JOIN sys.extended_properties C ON C.major_id = B.object_id AND C.minor_id = B.column_id
WHERE A.name = '����'
----------------------------------------------------------------------------------------------------------------------

EXECUTE sp_addextendedproperty N'MS_Description', N'��Ա����', N'user', N'dbo', N'table', N'Hrmresource', N'column', N'lastname'

SELECT
A.name AS table_name,
B.name AS column_name,
C.value AS column_description
FROM sys.tables A
INNER JOIN sys.columns B ON B.object_id = A.object_id
LEFT JOIN sys.extended_properties C ON C.major_id = B.object_id AND C.minor_id = B.column_id
WHERE A.name = 'Hrmresource'

select * from hrmresource

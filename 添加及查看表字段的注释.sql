------
1、sqlserver用语句给表注释
EXECUTE sp_addextendedproperty N'MS_Description', N'表注释', N'user', N'dbo', N'table', N'表名', NULL, NULL

2、sqlserver用语句给表的“字段”注释
EXECUTE sp_addextendedproperty N'MS_Description', N'字段注释', N'user', N'dbo', N'table', N'表名', N'column', N'字段名'

3、查看sqlserver注释

SELECT
A.name AS table_name,
B.name AS column_name,
C.value AS column_description
FROM sys.tables A
INNER JOIN sys.columns B ON B.object_id = A.object_id
LEFT JOIN sys.extended_properties C ON C.major_id = B.object_id AND C.minor_id = B.column_id
WHERE A.name = '表名'
----------------------------------------------------------------------------------------------------------------------

EXECUTE sp_addextendedproperty N'MS_Description', N'人员姓名', N'user', N'dbo', N'table', N'Hrmresource', N'column', N'lastname'

SELECT
A.name AS table_name,
B.name AS column_name,
C.value AS column_description
FROM sys.tables A
INNER JOIN sys.columns B ON B.object_id = A.object_id
LEFT JOIN sys.extended_properties C ON C.major_id = B.object_id AND C.minor_id = B.column_id
WHERE A.name = 'Hrmresource'

select * from hrmresource

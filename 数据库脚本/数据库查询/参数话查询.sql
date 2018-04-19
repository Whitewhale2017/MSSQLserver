DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
SET STATISTICS TIME ON
SET STATISTICS IO ON

EXEC sp_executesql N'SELECT * FROM [TestReplicationDB].[dbo].[tb_Student] WHERE [stu_no]=@stu_no',N'@stu_no varchar(6)',@stu_no='000005'
GO
EXEC sp_executesql N'SELECT * FROM [TestReplicationDB].[dbo].[tb_Student] WHERE [stu_no]=@stu_no',N'@stu_no varchar(6)',@stu_no='000006'
GO
SELECT stats.execution_count AS exec_count, 
p.size_in_bytes AS [size], 
[sql].[text] AS [plan_text] 
FROM sys.dm_exec_cached_plans p 
OUTER APPLY sys.dm_exec_sql_text (p.plan_handle) sql 
JOIN sys.dm_exec_query_stats stats ON stats.plan_handle = p.plan_handle;


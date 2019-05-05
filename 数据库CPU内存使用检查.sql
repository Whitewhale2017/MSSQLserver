select session_id, TEXT
from sys.dm_exec_requests er cross apply sys.dm_exec_sql_text(er.sql_handle)



SELECT TOP 10 (a.total_worker_time / a.execution_count) AS  "平均每次cpu消耗"
,Convert(VARCHAR, Last_Execution_Time) AS  "最后执行时间"
,Total_Physical_Reads AS "物理读"
,execution_count AS "执行次数"
,SUBSTRING(b.TEXT, a.statement_start_offset / 2, (
CASE
WHEN a.statement_end_offset = - 1
THEN len(convert(NVARCHAR(max), b.TEXT)) * 2
ELSE a.statement_end_offset
END - a.statement_start_offset
) / 2) AS [Query_Text]
FROM sys.dm_exec_query_stats a
CROSS APPLY sys.dm_exec_SQL_text(a.SQL_handle) AS b
ORDER BY 1 DESC
       
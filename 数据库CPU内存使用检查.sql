select session_id, TEXT
from sys.dm_exec_requests er cross apply sys.dm_exec_sql_text(er.sql_handle)



SELECT TOP 10 (a.total_worker_time / a.execution_count) AS  "ƽ��ÿ��cpu����"
,Convert(VARCHAR, Last_Execution_Time) AS  "���ִ��ʱ��"
,Total_Physical_Reads AS "�����"
,execution_count AS "ִ�д���"
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
       
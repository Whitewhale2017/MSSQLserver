--查看CPU使用最高的10个查询
SELECT TOP 50 total_worker_time/execution_count AS [Avg CPU Time],
SUBSTRING(st.text, (qs.statement_start_offset/2)+1,((CASE qs.statement_end_offset WHEN -1 THEN DATALENGTH(st.text) ELSE qs.statement_end_offset END - qs.statement_start_offset)/2) + 1) AS statement_text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
ORDER BY total_worker_time/execution_count DESC
--显示哪个查询占用了最多的 CPU 累计使用率
SELECT
highest_cpu_queries.plan_handle,highest_cpu_queries.total_worker_time/1000,db_name(q.dbid) as databaseName,
case when q.objectid is not null then OBJECT_NAME(q.objectid) else  ''  end as objectid,q.number,q.encrypted,q.[text]
from 
(
select top 50 qs.plan_handle,qs.total_worker_time from sys.dm_exec_query_stats qs order by qs.total_worker_time desc
) as highest_cpu_queries 
cross apply sys.dm_exec_sql_text(plan_handle) as q
where q.dbid=DB_ID('ERPSystem')
order by highest_cpu_queries.total_worker_time desc



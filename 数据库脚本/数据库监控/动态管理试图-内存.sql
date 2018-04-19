select name ,[type],single_pages_kb + multi_pages_kb  as total_kb,entries_count  from sys.dm_os_memory_cache_counters 
order by total_kb desc

select [type] ,[memory_node_id],[single_pages_kb],multi_pages_kb ,virtual_memory_reserved_kb ,virtual_memory_committed_kb ,awe_allocated_kb 
from sys.dm_os_memory_clerks
order by virtual_memory_reserved_kb desc

select * from sys.dm_exec_sessions where session_id>50
select * from sys.dm_os_memory_pools
select * from sys.dm_os_performance_counters
select * from sys.dm_os_schedulers
select wait_type ,sum(waiting_tasks_count) ,sum(wait_time_ms) from sys.dm_os_wait_stats group by wait_type order by sum(waiting_tasks_count) desc
GO
--查询等待信息
select wait_type, SUM(waiting_tasks_count) as num_waiting_tasks,
SUM(wait_time_ms)/1000 as total_wait_time_s  into #temp
from sys.dm_os_wait_stats 
group by wait_type
HAVING SUM(wait_time_ms)>0
order by total_wait_time_s desc
DECLARE @SUMCOUNT BIGINT
DECLARE @SUMTIME BIGINT
select @SUMCOUNT=SUM(num_waiting_tasks),@SUMTIME=SUM(total_wait_time_s) from #temp
--获取等待信息所占百分比
select 
wait_type,
num_waiting_tasks,
@SUMCOUNT as total_tasks,
substring(CONVERT(varchar(20),ROUND( 100* num_waiting_tasks*1.0/@SUMCOUNT,2)),1,CHARINDEX('.',CONVERT(varchar(20),ROUND( 100* num_waiting_tasks*1.0/@SUMCOUNT,2)),1)+2) as num_waiting_tasks_per,
total_wait_time_s,
@SUMTIME as total_times,
substring(CONVERT(varchar(20),ROUND( 100* total_wait_time_s*1.0/@SUMTIME,2)),1,CHARINDEX('.',CONVERT(varchar(20),ROUND( 100* total_wait_time_s*1.0/@SUMTIME,2)),1)+2) as total_wait_time_s_per
from #temp
order by total_wait_time_s desc
DROP TABLE #temp
GO

--阻塞等待
select * from sys.dm_tran_active_transactions

--查询缓存
select objtype as 'CacheObjectType',
COUNT(*) as 'NumberOfPlans',
SUM(cast(size_in_bytes as bigint))/1024/1024 as 'PlanCacheSize(MB)',
AVG(usecounts) as 'AvgUseCount'
from sys.dm_exec_cached_plans
group by objtype

--缓冲池中每个数据库所占缓存大小
select COUNT(*)*8/1024 as 'CachedSize(MB)',
case database_id when 32767 then 'resourceDb'
else DB_NAME(database_id)
end as 'Database'
from sys.dm_os_buffer_descriptors 
group by DB_NAME(database_id),database_id
order by 'CachedSize(MB)' desc

--缓冲池总大小
select COUNT(*)*8/1024 as 'CachedSize(MB)'
from sys.dm_os_buffer_descriptors 


select * from sys.dm_os_memory_cache_hash_tables

select * from sys.dm_os_memory_cache_counters

--清空等待信息
DBCC SQLPERF("sys.dm_os_wait_stats",CLEAR)
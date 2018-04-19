SELECT wait_type,
SUM(waiting_tasks_count) as total_waiting_tasks_count,
SUM(wait_time_ms)/1000 as total_wait_time_s
INTO #temp
FROM sys.dm_os_wait_stats 
GROUP BY wait_type
order by total_wait_time_s desc
waitfor delay '00:05:00'
SELECT wait_type,
SUM(waiting_tasks_count) as total_waiting_tasks_count,
SUM(wait_time_ms)/1000 as total_wait_time_s
INTO #temp1
FROM sys.dm_os_wait_stats 
GROUP BY wait_type
order by total_wait_time_s desc
select a.wait_type,
(a.total_waiting_tasks_count-b.total_waiting_tasks_count) as total_waiting_tasks_inFiveMinute_count,
(a.total_wait_time_s-b.total_wait_time_s) as total_wait_time_s_inFiveMinute INTO #TEMP_FINAL
from #temp1 as a
join #temp as b on a.wait_type=b.wait_type
drop table #temp
drop table #temp1

DECLARE @SUMCOUNT BIGINT
DECLARE @SUMTIME BIGINT
select @SUMCOUNT=SUM(total_waiting_tasks_inFiveMinute_count),@SUMTIME=SUM(total_wait_time_s_inFiveMinute) from #TEMP_FINAL
--获取等待信息所占百分比
select 
wait_type,
total_waiting_tasks_inFiveMinute_count,
substring(CONVERT(varchar(20),ROUND( 100* total_waiting_tasks_inFiveMinute_count*1.0/@SUMCOUNT,2)),1,CHARINDEX('.',CONVERT(varchar(20),ROUND( 100* total_waiting_tasks_inFiveMinute_count*1.0/@SUMCOUNT,2)),1)+2) as num_waiting_tasks_per,
total_wait_time_s_inFiveMinute,
substring(CONVERT(varchar(20),ROUND( 100* total_wait_time_s_inFiveMinute*1.0/@SUMTIME,2)),1,CHARINDEX('.',CONVERT(varchar(20),ROUND( 100* total_wait_time_s_inFiveMinute*1.0/@SUMTIME,2)),1)+2) as total_wait_time_s_per
from #TEMP_FINAL
order by total_waiting_tasks_inFiveMinute_count desc
DROP TABLE #TEMP_FINAL
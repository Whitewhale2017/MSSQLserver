/*

	递归查询阻塞

	注意：
	当出现错误时，代表session_id<=50的系统进程阻塞了session_id>50的用户进程
*/



SELECT 
	A.session_id,A.wait_type,A.blocking_session_id,B.resource_type,
	DB_NAME(B.resource_database_id) AS database_name,B.resource_lock_partition, 
	B.request_mode,B.request_type,B.request_status
into #temp
FROM SYS.dm_os_waiting_tasks A
JOIN SYS.dm_tran_locks B ON A.resource_address=B.lock_owner_address
WHERE session_id>50



;WITH CTE_TABLE(session_id,wait_type,blocking_session_id,resource_type,database_name,resource_lock_partition,request_mode,request_type,request_status,LV)
AS
(
select session_id,wait_type,blocking_session_id,resource_type,
	database_name,resource_lock_partition, 
	request_mode,request_type,request_status,1 from #temp where blocking_session_id not in (select session_id from #temp)
UNION ALL
SELECT 
 C.session_id,
 C.wait_type,
 C.blocking_session_id,
 C.resource_type, 
 C.database_name, 
 C.resource_lock_partition, 
 C.request_mode, 
 C.request_type,
 C.request_status,
 CTE_TABLE.LV+1
 FROM #temp AS C JOIN CTE_TABLE ON CTE_TABLE.session_id=C.blocking_session_id 
 )
SELECT * INTO #TEMP1 FROM CTE_TABLE
SELECT A.*,C.text as Blocked_Text,E.text AS Blocking_Text FROM #TEMP1 AS A 
JOIN sys.dm_exec_connections AS B ON A.session_id=B.session_id
CROSS APPLY sys.dm_exec_sql_text(B.most_recent_sql_handle) AS C
JOIN sys.dm_exec_connections AS D ON A.blocking_session_id=D.session_id
CROSS APPLY sys.dm_exec_sql_text(D.most_recent_sql_handle) AS E

DROP TABLE #temp
DROP TABLE #TEMP1
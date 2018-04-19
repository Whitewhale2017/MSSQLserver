

;WITH CTE_TABLE(session_id,wait_type,blocking_session_id,resource_type,database_name,resource_lock_partition,request_mode,request_type,request_status,LV)
AS
(
SELECT 
 A.session_id,
 A.wait_type,
 A.blocking_session_id,
 B.resource_type, 
 DB_NAME(B.resource_database_id) AS database_name, 
 B.resource_lock_partition, 
 B.request_mode, 
 request_type,
 B.request_status,
 1
FROM SYS.dm_os_waiting_tasks A
JOIN SYS.dm_tran_locks B ON A.resource_address=B.lock_owner_address
WHERE session_id>50
UNION ALL
SELECT 
 C.session_id,
 C.wait_type,
 C.blocking_session_id,
 C.resource_type, 
 C.DATABASE_NAME, 
 C.resource_lock_partition, 
 C.request_mode, 
 C.request_type,
 C.request_status,
 CTE_TABLE.LV+1
FROM
 (
  SELECT 
   A.session_id,
   A.wait_type,
   A.blocking_session_id,
   B.resource_type, 
   DB_NAME(B.resource_database_id) AS database_name, 
   B.resource_lock_partition, 
   B.request_mode, 
   request_type,
   B.request_status
  FROM SYS.dm_os_waiting_tasks A
  JOIN SYS.dm_tran_locks B ON A.resource_address=B.lock_owner_address
  WHERE session_id>50
 ) AS C JOIN CTE_TABLE ON CTE_TABLE.session_id=C.blocking_session_id
)
SELECT * INTO #TEMPTABLE_1 FROM CTE_TABLE
CREATE TABLE #TEMPTABLE
(
 session_id INT,--正在锁定资源的会话ID
 wait_type NVARCHAR(MAX),
 blocked_session_id INT,--请求被迫等待的会话ID
 resource_type NVARCHAR(MAX), 
 DATABASE_NAME NVARCHAR(MAX), 
 resource_lock_partition INT, 
 request_mode NVARCHAR(MAX), 
 request_type NVARCHAR(MAX),
 request_status NVARCHAR(MAX),
 LV INT,
 BLOCKING_SQL NVARCHAR(MAX),--正在锁定的查询语句
 BLOCKED_SQL NVARCHAR(MAX)--请求被迫等待的查询语句
)
INSERT INTO #TEMPTABLE(session_id,wait_type,blocked_session_id,resource_type,DATABASE_NAME,resource_lock_partition,request_mode,request_type,request_status,LV)
SELECT * FROM #TEMPTABLE_1
DROP TABLE #TEMPTABLE_1
CREATE TABLE #TEMO
(
 EVENTTYPE NVARCHAR(100) ,
 PARAMETER NVARCHAR(MAX) ,
 EVENTINFO NVARCHAR(MAX)
)
--通过游标把查询结果用session_id关联执行的sql语句
DECLARE @SEID INT
DECLARE @SEID_2 INT 
DECLARE @SQL NVARCHAR(MAX)
DECLARE @SEIDTEXT NVARCHAR(MAX)
DECLARE @SEID_2TEXT NVARCHAR(MAX)
DECLARE COSU CURSOR FOR SELECT session_id,blocked_session_id FROM #TEMPTABLE
OPEN COSU
FETCH NEXT FROM COSU INTO @SEID,@SEID_2
WHILE @@FETCH_STATUS<>-1
BEGIN
 SET @SQL=N'DBCC INPUTBUFFER('+STR(@SEID)+')'
 INSERT INTO #TEMO
 EXEC SP_SQLEXEC @SQL
 SELECT @SEIDTEXT=EVENTINFO FROM #TEMO
 DELETE FROM #TEMO
 SET @SQL=N'DBCC INPUTBUFFER('+STR(@SEID_2)+')'
 INSERT INTO #TEMO
 EXEC SP_SQLEXEC @SQL
 SELECT @SEID_2TEXT=EVENTINFO FROM #TEMO
 UPDATE #TEMPTABLE SET BLOCKING_SQL=@SEIDTEXT,BLOCKED_SQL=@SEID_2TEXT 
 WHERE session_id=@SEID AND blocked_session_id=@SEID_2
 FETCH NEXT FROM COSU INTO @SEID,@SEID_2
END
CLOSE COSU
DEALLOCATE COSU
SELECT * FROM #TEMPTABLE
DROP TABLE #TEMPTABLE
DROP TABLE #TEMO
GO



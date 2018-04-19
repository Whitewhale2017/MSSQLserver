/*
	获取SQL Profiler的事件信息
*/
SELECT  tcat.name AS EventCategoryName ,
tevent.name AS EventClassName ,
tcolumn.name AS EventColumn ,
tevent.trace_event_id AS EventID ,
tbinding.trace_column_id AS ColumnID ,
tcolumn.type_name AS DataType
FROM   sys.trace_categories AS tcat
JOIN sys.trace_events AS tevent
ON tevent.category_id = tcat.category_id
JOIN sys.trace_event_bindings AS tbinding
ON tbinding.trace_event_id = tevent.trace_event_id
JOIN sys.trace_columns AS tcolumn
ON tcolumn.trace_column_id = tbinding.trace_column_id
ORDER BY tcat.name ,
EventClassName ,
 EventColumn ;
 

/*
	手动开启并设置Sql Profiler
*/

/*
	创建追踪
*/
DECLARE @return_code INT;
DECLARE @TraceID INT;
DECLARE @maxfilesize BIGINT;
SET @maxfilesize = 5;
--step 1: create a new empty trace definition
EXEC sp_trace_create
@traceid OUTPUT
, @options = 2
, @tracefile = N'D:\Test_Trace\1.trc'
, @maxfilesize = @maxfilesize
, @stoptime =NULL
, @filecount = 2;

/*
	加入追踪信息字段
*/
-- step 2: add the events and columns

EXEC sp_trace_setevent
@traceid = @TraceID
, @eventid = 10 -- RPC:Completed
, @columnid = 1 -- TextData
, @on = 1;--include this column in trace
EXEC sp_trace_setevent
@traceid = @TraceID
, @eventid = 10 -- RPC:Completed
, @columnid = 13 --Duration
, @on = 1;--include this column in trace
EXEC sp_trace_setevent
 @traceid = @TraceID
, @eventid = 10 -- RPC:Completed
, @columnid = 15 --EndTime
, @on = 1;--include this column in trace
EXEC sp_trace_setevent
@traceid = @TraceID
, @eventid = 12 -- SQL:BatchCompleted
, @columnid = 1 -- TextData
, @on = 1;--include this column in trace
EXEC sp_trace_setevent
@traceid = @TraceID
, @eventid = 12 -- SQL:BatchCompleted
, @columnid = 13 --Duration
, @on = 1;--include this column in trace
EXEC sp_trace_setevent
@traceid = @TraceID
, @eventid = 12 -- SQL:BatchCompleted
, @columnid = 15 --EndTime
, @on = 1;--include this column in trace
-- step 3: add duration filter
DECLARE @DurationFilter BIGINT;
SET @DurationFilter = 10000000; --duration in microseconds
EXEC sp_trace_setfilter
@traceid = @TraceID
, @columnid = 13
, @logical_operator = 0 --AND
, @comparison_operator = 4 -- greater than or equal to
, @value = @DurationFilter; --filter value
SELECT @TraceID AS TraceID;
go

--关闭追踪
exec sp_trace_setstatus @traceid =3,@status =0


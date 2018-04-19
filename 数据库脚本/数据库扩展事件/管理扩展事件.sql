/*扩展事件的动态视图*/

select p.name as package_name,o.name as [object_name],o.object_type ,o.description from sys.dm_xe_packages as p join sys.dm_xe_objects as o on p.guid=o.package_guid
where (p.capabilities is null or p.capabilities & 1=0)

select o.name as [object_name],oc.name as column_name,oc.column_id,oc.column_type,oc.column_value,oc.[type_name] from sys.dm_xe_objects as o
join sys.dm_xe_object_columns as oc on o.package_guid=oc.object_package_guid
and o.name=oc.[object_name]
where o.name='wait_info'

select sese.package,sese.name,sese.predicate from sys.server_event_sessions as ses
join sys.server_event_session_events as sese on ses.event_session_id=sese.event_session_id
where ses.name='system_health'

select sese.package as event_package,sese.name as event_name,sese.predicate as event_predicate ,sesa.package as action_package,sesa.name as action_name
from sys.server_event_sessions as ses
join sys.server_event_session_events as sese on ses.event_session_id=sese.event_session_id
join sys.server_event_session_actions as sesa on ses.event_session_id=sese.event_session_id and sese.event_id=sesa.event_id
where ses.name='system_health' 

select ses.name as session_name,sest.name as target_name,sesf.name as option_name,sesf.value as option_value 
from sys.server_event_sessions as ses
join sys.server_event_session_targets as sest on ses.event_session_id=sest.event_session_id
join sys.server_event_session_fields as sesf on sest.event_session_id=sesf.event_session_id and sest.target_id=sesf.[object_id]
where ses.name='system_health'


select s.name as session_name,e.event_name,e.event_predicate,ea.action_name 
from sys.dm_xe_sessions as s
join sys.dm_xe_session_events as e on s.address=e.event_session_address
join sys.dm_xe_session_event_actions as ea on e.event_session_address=ea.event_session_address and e.event_name=ea.event_name
where s.name='system_health'

select s.name as session_name,t.target_name,t.execution_count,t.execution_duration_ms,t.target_data
from sys.dm_xe_sessions as s
join sys.dm_xe_session_targets as t on s.address=t.event_session_address
where s.name='system_health'

select s.name as session_name,t.target_name,t.execution_count,t.execution_duration_ms,t.target_data
from sys.dm_xe_sessions as s
join sys.dm_xe_session_targets as t on s.address=t.event_session_address
join sys.dm_xe_session_events as e on s.address=e.event_session_address
join sys.dm_xe_session_object_columns as oc on s.address=oc.event_session_address
and ((oc.object_type='target' and t.target_name=oc.[object_name]) or (oc.object_type='event' and e.event_name=oc.[object_name] ))
where s.name='system_health'

select oc.name as column_name,oc.column_type,oc.column_value,oc.description
from sys.dm_xe_packages as p
join sys.dm_xe_objects as o on p.guid=o.package_guid
join sys.dm_xe_object_columns as oc on oc.object_name=o.name and o.package_guid=oc.object_package_guid
where (p.capabilities is null or p.capabilities & 1=0)
and o.object_type='event' and o.name='wait_info'


/*针对执行时间超过5秒的TSQL，管理扩展事件*/
create event session [long_duration_statements]
on server
add event sqlserver.sql_statement_completed
(
	action (sqlserver.tsql_stack,sqlserver.sql_text)
	where (sqlserver.session_id>50 and duration > 5000000)
)
add target package0.ring_buffer(set max_memory =1024)
with (max_dispatch_latency=15 seconds)

alter event session [long_duration_statements] on server state=start

alter event session [long_duration_statements] on server 
add target package0.asynchronous_file_target
(
	set filename='D:\sql_event_session\long_duration_statements.xel',
	metadatafile='D:\sql_event_session\long_duration_statements.mta'
)

--查看扩展事件的监控数据

declare @filename varchar(200)
set @filename='D:\sql_event_session\long_duration_statements*.xel'
declare @metadatafile varchar(200)
set @metadatafile='D:\sql_event_session\long_duration_statements*.mta'
select CONVERT(xml,event_data) as event_data
into #file_Data
from sys.fn_xe_file_target_read_file(@filename,@metadatafile,null,null)

select event_data.value('(event/@timestamp)[1]','datetime') as event_timestamp,
db_name(convert(int,event_data.value('(event/data[1]/value)[1]','varchar(100)'))) as databasename,
event_data.value('(event/data[2]/value)[1]','varchar(100)') as objectid,
event_data.value('(event/data[3]/value)[1]','varchar(100)') as object_type,
event_data.value('(event/data[4]/value)[1]','varchar(100)') as cpu,
event_data.value('(event/data[5]/value)[1]','varchar(100)') as duration,
event_data.value('(event/data[6]/value)[1]','varchar(100)') as reads,
event_data.value('(event/action[2]/value)[1]','varchar(max)') as sql_text
from #file_data

select * from #file_data
drop table #file_data

GO


/*通过扩展事件检查等待*/

select e.package,e.name,e.predicate
from sys.server_event_session_events as e
join sys.server_event_sessions as s on e.event_session_id=s.event_session_id
where s.name='system_health' and e.name like 'wait_info%'

select map_key,map_value
from sys.dm_xe_map_values
where name='wait_types'
and (
([map_key]<22) 
or ([map_key]>31 and [map_key]<38)
or ([map_key]>47 and [map_key]<54)
or ([map_key]>63 and [map_key]<70)
or ([map_key]>96 and [map_key]<100)
or ([map_key]>174 and [map_key]<177)
or ([map_key]>185 and [map_key]<188)
or [map_key]=107 or [map_key]=113
or [map_key]=120 or [map_key]=178
or [map_key]=186 or [map_key]=202
or [map_key]=207 or [map_key]=269
or [map_key]=283 or [map_key]=284)


go
create event session [trace_wait_info]
on server
add event sqlos.wait_info
(
	action
	(
		sqlserver.database_id,
		sqlserver.client_app_name,
		sqlserver.sql_text
	)
	where 
	(
		duration>1000
		and (wait_type =66 or wait_type =68 or wait_type =98 or wait_type =120 or wait_type =178 or wait_type =187)
	)
)
alter event session [trace_wait_info] on server 
add target package0.asynchronous_file_target
(
	set filename='D:\sql_event_session\trace_wait_info.xel',
	metadatafile='D:\sql_event_session\trace_wait_info.mta',
	max_file_size=10,
	max_rollover_files=10
)
alter event session [trace_wait_info] on server state=start
GO

--查看扩展事件的监控数据
declare @filename varchar(200)
set @filename='D:\sql_event_session\trace_wait_info*.xel'
declare @metadatafile varchar(200)
set @metadatafile='D:\sql_event_session\trace_wait_info*.xel'
select CONVERT(xml,event_data) as event_data
into #file_Data
from sys.fn_xe_file_target_read_file(@filename,@metadatafile,null,null)

GO


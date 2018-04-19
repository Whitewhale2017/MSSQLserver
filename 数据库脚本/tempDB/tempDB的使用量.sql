USE tempdb;
GO
--确定 tempdb 中的可用空间量
SELECT SUM(unallocated_extent_page_count) AS [free pages], 
(SUM(unallocated_extent_page_count)*1.0/128) AS [free space in MB]
FROM sys.dm_db_file_space_usage

SELECT SUM(unallocated_extent_page_count) -
(SUM(unallocated_extent_page_count)*1.0/128) AS [free space in MB]
FROM sys.dm_db_file_space_usage


--确定用户对象使用的空间量
SELECT SUM(user_object_reserved_page_count) AS [user object pages used],
(SUM(user_object_reserved_page_count)*1.0/128) AS [user object space in MB]
FROM sys.dm_db_file_space_usage

--查询数据库为查询而在tempdb中分配的总页数和总释放页数
select 
--由该会话为用户对象保留或分配的页数
SUM(user_objects_alloc_page_count)*8/1024 as total_user_objects_alloc_page_count_MB,
--由该会话释放并不再为用户对象保留的页数。 
SUM(user_objects_dealloc_page_count)*8/1024 as total_user_objects_dealloc_page_count_MB,
--由该会话为内部对象保留或分配的页数。
SUM(internal_objects_alloc_page_count)*8/1024 as total_internal_objects_alloc_page_count_MB,
--由该会话释放并不再为内部对象保留的页数。 
SUM(internal_objects_dealloc_page_count)*8/1024 as total_internal_objects_dealloc_page_count_MB
from sys.dm_db_session_space_usage 
where database_id=2
--查找版本存储区的最大使用者
select * from sys.dm_tran_top_version_generators

--
select * from sys.dm_tran_version_store

select * from sys.dm_tran_active_snapshot_database_transactions
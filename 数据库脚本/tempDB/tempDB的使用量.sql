USE tempdb;
GO
--ȷ�� tempdb �еĿ��ÿռ���
SELECT SUM(unallocated_extent_page_count) AS [free pages], 
(SUM(unallocated_extent_page_count)*1.0/128) AS [free space in MB]
FROM sys.dm_db_file_space_usage

SELECT SUM(unallocated_extent_page_count) -
(SUM(unallocated_extent_page_count)*1.0/128) AS [free space in MB]
FROM sys.dm_db_file_space_usage


--ȷ���û�����ʹ�õĿռ���
SELECT SUM(user_object_reserved_page_count) AS [user object pages used],
(SUM(user_object_reserved_page_count)*1.0/128) AS [user object space in MB]
FROM sys.dm_db_file_space_usage

--��ѯ���ݿ�Ϊ��ѯ����tempdb�з������ҳ�������ͷ�ҳ��
select 
--�ɸûỰΪ�û�������������ҳ��
SUM(user_objects_alloc_page_count)*8/1024 as total_user_objects_alloc_page_count_MB,
--�ɸûỰ�ͷŲ�����Ϊ�û���������ҳ���� 
SUM(user_objects_dealloc_page_count)*8/1024 as total_user_objects_dealloc_page_count_MB,
--�ɸûỰΪ�ڲ�������������ҳ����
SUM(internal_objects_alloc_page_count)*8/1024 as total_internal_objects_alloc_page_count_MB,
--�ɸûỰ�ͷŲ�����Ϊ�ڲ���������ҳ���� 
SUM(internal_objects_dealloc_page_count)*8/1024 as total_internal_objects_dealloc_page_count_MB
from sys.dm_db_session_space_usage 
where database_id=2
--���Ұ汾�洢�������ʹ����
select * from sys.dm_tran_top_version_generators

--
select * from sys.dm_tran_version_store

select * from sys.dm_tran_active_snapshot_database_transactions
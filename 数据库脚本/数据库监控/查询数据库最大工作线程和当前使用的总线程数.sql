--������߳�
SELECT max_workers_count FROM sys.dm_os_sys_info
--����ʹ�õ��߳���
SELECT COUNT(*) FROM [sys].[dm_exec_sessions] WHERE [session_id]>50
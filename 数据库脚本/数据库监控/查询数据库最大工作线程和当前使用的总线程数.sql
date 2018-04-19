--最大工作线程
SELECT max_workers_count FROM sys.dm_os_sys_info
--正在使用的线程数
SELECT COUNT(*) FROM [sys].[dm_exec_sessions] WHERE [session_id]>50
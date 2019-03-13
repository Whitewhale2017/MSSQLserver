SELECT * FROM sys.sysprocesses WHERE loginame='OAUser'

sp_who2

SELECT conn.session_id, host_name, program_name,
    nt_domain, login_name, connect_time, last_request_end_time 
FROM sys.dm_exec_sessions AS sess
JOIN sys.dm_exec_connections AS conn
   ON sess.session_id = conn.session_id;

select session_id,start_time,status,command,wait_type,(wait_time/60000) as waitmin,transaction_id 
from sys.dm_exec_requests where session_id=63


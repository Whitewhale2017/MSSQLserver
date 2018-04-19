SELECT  [net_ip].session_id ,
        [net_ip].connect_time ,
        [net_ip].net_transport ,
        [net_ip].client_net_address ,
        [net_ip].client_tcp_port ,
        SE.host_process_id,
        SE.status,
        [net_ip].local_net_address ,
        [net_ip].local_tcp_port ,
        [hostname].hostname ,
        [hostname].[DB_name] ,
        [hostname].net_address ,
        [hostname].loginame ,
        [hostname].program_name ,
        [net_ip].num_reads ,
        [net_ip].num_writes ,
        [hostname].text
FROM    sys.dm_exec_connections AS [net_ip]
        JOIN ( SELECT DISTINCT
                        hostname ,
                        spid ,
                        DB_NAME(sp.dbid) AS [DB_name] ,
                        net_address ,
                        loginame ,
                        program_name ,
                        text
               FROM     master..sysprocesses SP
                        CROSS APPLY sys.dm_exec_sql_text(sp.sql_handle)
               WHERE    hostname IS NOT NULL
                        AND hostname <> ''
             ) AS hostname ON [net_ip].session_id = [hostname].spid
             LEFT JOIN sys.dm_exec_sessions SE 
             ON [net_ip].session_id=SE.session_id where client_tcp_port is not null
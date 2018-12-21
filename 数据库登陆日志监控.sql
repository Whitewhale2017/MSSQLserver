USE [ecology]
GO

/****** Object:  View [dbo].[v_login_monitor]    Script Date: 2018/11/20 11:10:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[v_login_monitor]
as
SELECT 
a.[session_id],a.[login_time],a.[host_name],
a.[original_login_name],b.[client_net_address]
FROM MASTER.sys.dm_exec_sessions a 
INNER JOIN MASTER.sys.dm_exec_connections b 
ON a.session_id=b.session_id
--order by a.login_time desc
GO



--创建警报
USE [msdb]
GO
EXEC msdb.dbo.sp_add_alert @name=N'alertInfo', 
		@message_id=0, 
		@severity=1, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1
GO
--为警报添加操作员
EXEC msdb.dbo.sp_add_notification @alert_name=N'alertInfo', @operator_name=N'jack', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'alertInfo', @operator_name=N'jiangdachuan', @notification_method = 1
GO

exec sp_configure 'show advanced options',1
reconfigure;
GO
exec sp_configure 'lightweight pooling',1
reconfigure;
GO
exec sp_configure 'lightweight pooling',0
reconfigure;
GO
exec sp_configure 'show advanced options',0
reconfigure;
GO

SELECT @@VERSION
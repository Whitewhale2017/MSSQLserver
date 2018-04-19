--ÒÆ¶¯tempdb
USE master   
GO   
ALTER DATABASE tempdb modify file (name = tempdev, filename = 'D:\database_file\tempdb.mdf' )   
GO  
ALTER DATABASE tempdb modify file (name = templog, filename = 'D:\database_file\templog.ldf' )   
GO

ALTER DATABASE tempdb modify file (name = tempdev6, filename = 'D:\database_file\tempdev6.ndf' )   
GO  
ALTER DATABASE tempdb modify file (name = templog1, filename = 'D:\database_file\templog1.ldf' )   
GO
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'ecology'
GO
USE [master]
GO
ALTER DATABASE [ecology] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
/****** Object:  Database [ecology]    Script Date: 2016/6/1 15:47:19 ******/
DROP DATABASE [ecology]
GO

GO
USE [master]
GO
kill 57
USE [master]
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'tempdev', SIZE = 10240MB )
GO
ALTER DATABASE [tempdb]
ADD FILE
(
	NAME ='tempdb_2_data',
	fileName='G:\MSSQL\tempdb_2_data.ndf',
	size=10240MB
)
go
ALTER DATABASE [tempdb]
ADD FILE
(
	NAME ='tempdb_3_data',
	fileName='G:\MSSQL\tempdb_3_data.ndf',
	size=10240MB
)
go
ALTER DATABASE [tempdb]
ADD FILE
(
	NAME ='tempdb_4_data',
	fileName='G:\MSSQL\tempdb_4_data.ndf',
	size=10240MB
)
go
ALTER DATABASE [tempdb]
ADD FILE
(
	NAME ='tempdb_5_data',
	fileName='G:\MSSQL\tempdb_5_data.ndf',
	size=10240MB
)
go
ALTER DATABASE [tempdb]
ADD FILE
(
	NAME ='tempdb_6_data',
	fileName='G:\MSSQL\tempdb_6_data.ndf',
	size=10240MB
)
go

IF EXISTS(SELECT * FROM sys.objects WHERE name='PerfMonCountInfo')
DROP TABLE PerfMonCountInfo
GO
CREATE TABLE PerfMonCountInfo
(
	PerfMonCountName VARCHAR(100) not null,
	PerfMonCount_Desc nvarchar(200) null,
	PerfMon_Value_DESC nvarchar(100) null,
	PRIMARY KEY CLUSTERED 
	(
		PerfMonCountName
	)
)
GO
IF EXISTS(SELECT * FROM sys.objects WHERE name='PerfMonCountMapping')
DROP TABLE PerfMonCountMapping
GO
CREATE TABLE PerfMonCountMapping
(
	IPAddress varchar(20) not null,
	column_name varchar(100) not null,
	PRIMARY KEY CLUSTERED 
	(
		IPAddress,column_name
	)
)
GO




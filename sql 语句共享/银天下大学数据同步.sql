create table WeHelpuLog(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[workcode] [varchar](100) NULL,
	[lastname] [varchar](100) NULL,
	[signature] [varchar](50) NULL,
	[result] [varchar](100) NULL,
	[fail_text] [varchar](500) NULL,
	[timestamp] [char](50) NULL
)
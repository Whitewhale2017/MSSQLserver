USE [ecology]
GO

/****** Object:  Table [dbo].[WT_MainInfo]    Script Date: 05/24/2016 17:08:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[WT_MainInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[remark] [text] NULL,
	[xmlname] [varchar](50) NULL,
	[image] [varchar](100) NULL,
	[createrId] [int] NULL,
	[createDate] [char](10) NULL,
	[createTime] [char](8) NULL,
	[updaterId] [int] NULL,
	[updateDate] [char](10) NULL,
	[updateTime] [char](8) NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_WT_MAININFO] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [ecology]
GO

/****** Object:  Table [dbo].[WT_NodeDetail]    Script Date: 05/24/2016 17:19:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[WT_NodeDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NULL,
	[name] [varchar](100) NULL,
	[link] [varchar](200) NULL,
	[sort] [decimal](10, 2) NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_WT_NODEDETAIL] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [ecology]
GO

/****** Object:  Table [dbo].[WT_NodeInfo]    Script Date: 05/24/2016 17:19:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[WT_NodeInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[createrId] [int] NULL,
	[createDate] [char](10) NULL,
	[createTime] [char](8) NULL,
	[updaterId] [int] NULL,
	[updateDate] [char](10) NULL,
	[updateTime] [char](8) NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_WT_NODEINFO] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [ecology]
GO

/****** Object:  Table [dbo].[WT_NodeSetting]    Script Date: 05/24/2016 17:19:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[WT_NodeSetting](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mainId] [int] NULL,
	[mxId] [int] NULL,
	[nodeId] [int] NULL,
	[link] [varchar](200) NULL,
 CONSTRAINT [PK_WT_NODESETTING] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
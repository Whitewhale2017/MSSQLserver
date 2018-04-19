USE [ecology]
GO

/****** Object:  Table [dbo].[KT_KnowledgeDetail]    Script Date: 05/26/2016 11:45:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[KT_KnowledgeDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[knowledgeId] [int] NULL,
	[title] [varchar](50) NULL,
	[docIds] [varchar](50) NULL,
	[sqlstr] [text] NULL,
	[rate] [decimal](10, 2) NULL,
	[sort] [decimal](10, 2) NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_KT_KNOWLEDGEDETAIL] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [ecology]
GO

/****** Object:  Table [dbo].[KT_Knowledge]    Script Date: 05/26/2016 11:45:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[KT_Knowledge](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[remark] [text] NULL,
	[createrId] [int] NULL,
	[createDate] [char](10) NULL,
	[createTime] [char](8) NULL,
	[updaterId] [int] NULL,
	[updateDate] [char](10) NULL,
	[updateTime] [char](8) NULL,
	[supId] [int] NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_KT_KNOWLEDGE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [ecology]
GO

/****** Object:  Table [dbo].[KT_AccessLog]    Script Date: 05/26/2016 11:44:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[KT_AccessLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[mapId] [int] NULL,
	[accessIp] [varchar](50) NULL,
	[accessDate] [char](10) NULL,
	[accessTime] [char](8) NULL,
 CONSTRAINT [PK_KT_ACCESSLOG] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [ecology]
GO

/****** Object:  Table [dbo].[KT_KnowledgeHrm]    Script Date: 05/26/2016 11:47:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KT_KnowledgeHrm](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[hrmId] [int] NULL,
	[detailId] [int] NULL,
	[konwledgeId] [int] NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_KT_KNOWLEDGEHRM] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [ecology]
GO

/****** Object:  Table [dbo].[KT_Map]    Script Date: 05/26/2016 11:47:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[KT_Map](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NULL,
	[remark] [text] NULL,
	[tId] [int] NULL,
	[createrId] [int] NULL,
	[createDate] [char](10) NULL,
	[createTime] [char](8) NULL,
	[updaterId] [int] NULL,
	[updateDate] [char](10) NULL,
	[updateTime] [char](8) NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_KT_MAP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [ecology]
GO

/****** Object:  Table [dbo].[KT_MapDetail]    Script Date: 05/26/2016 11:47:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[KT_MapDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mapId] [int] NULL,
	[title] [varchar](100) NULL,
	[rate] [decimal](10, 2) NULL,
	[sort] [decimal](10, 2) NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_KT_MAPDETAIL] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [ecology]
GO

/****** Object:  Table [dbo].[KT_Template]    Script Date: 05/26/2016 11:47:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[KT_Template](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NULL,
	[page] [varchar](100) NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_KT_TEMPLATE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [ecology]
GO

/****** Object:  Table [dbo].[KT_ThemeKnowledge]    Script Date: 05/26/2016 11:47:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KT_ThemeKnowledge](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tId] [int] NULL,
	[kId] [int] NULL,
	[rate] [decimal](10, 2) NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_KT_THEMEKNOWLEDGE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



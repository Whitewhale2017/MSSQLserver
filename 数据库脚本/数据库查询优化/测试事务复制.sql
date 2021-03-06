
/****** Object:  Table [dbo].[tb_Subject]    Script Date: 06/04/2014 15:03:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Subject](
	[sub_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[sub_name] [varchar](20) NULL,
 CONSTRAINT [PK__tb_Subje__694106B030F848ED] PRIMARY KEY CLUSTERED 
(
	[sub_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Subject] ON
INSERT [dbo].[tb_Subject] ([sub_id], [sub_name]) VALUES (1, N'chinese')
INSERT [dbo].[tb_Subject] ([sub_id], [sub_name]) VALUES (2, N'mathematics')
INSERT [dbo].[tb_Subject] ([sub_id], [sub_name]) VALUES (3, N'english')
SET IDENTITY_INSERT [dbo].[tb_Subject] OFF
/****** Object:  Table [dbo].[tb_Class]    Script Date: 06/04/2014 15:03:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[tb_Class](
	[ClassID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ClassName] [varchar](10) NOT NULL,
 CONSTRAINT [PK__tb_Class__CB1927A01367E606] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Class] ON
INSERT [dbo].[tb_Class] ([ClassID], [ClassName]) VALUES (1, N'A')
INSERT [dbo].[tb_Class] ([ClassID], [ClassName]) VALUES (2, N'B')
INSERT [dbo].[tb_Class] ([ClassID], [ClassName]) VALUES (3, N'C')
INSERT [dbo].[tb_Class] ([ClassID], [ClassName]) VALUES (4, N'D')
INSERT [dbo].[tb_Class] ([ClassID], [ClassName]) VALUES (5, N'E')
INSERT [dbo].[tb_Class] ([ClassID], [ClassName]) VALUES (6, N'F')
INSERT [dbo].[tb_Class] ([ClassID], [ClassName]) VALUES (7, N'G')
INSERT [dbo].[tb_Class] ([ClassID], [ClassName]) VALUES (8, N'H')
SET IDENTITY_INSERT [dbo].[tb_Class] OFF








/****** Object:  Table [dbo].[tb_Student]    Script Date: 06/04/2014 15:03:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Student](
	[stu_no] [varchar](6) NOT NULL,
	[stu_name] [varchar](20) NOT NULL,
	[sex] [int] NOT NULL,
	[age] [int] NOT NULL,
	[telphone] [varchar](15) NOT NULL,
	[ClassID] [int] NOT NULL,
 CONSTRAINT [PK__tb_Stude__E531AE2E2C3393D0] PRIMARY KEY CLUSTERED 
(
	[stu_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tb_Student] ([stu_no], [stu_name], [sex], [age], [telphone], [ClassID]) VALUES (N'000001', N'jack', 1, 20, N'13549865445', 1)
INSERT [dbo].[tb_Student] ([stu_no], [stu_name], [sex], [age], [telphone], [ClassID]) VALUES (N'000002', N'rose', 0, 20, N'13549865855', 1)
INSERT [dbo].[tb_Student] ([stu_no], [stu_name], [sex], [age], [telphone], [ClassID]) VALUES (N'000003', N'tony', 1, 19, N'13589875484', 1)
INSERT [dbo].[tb_Student] ([stu_no], [stu_name], [sex], [age], [telphone], [ClassID]) VALUES (N'000004', N'windy', 0, 18, N'13648975645', 2)
INSERT [dbo].[tb_Student] ([stu_no], [stu_name], [sex], [age], [telphone], [ClassID]) VALUES (N'000005', N'alix', 0, 18, N'136487897552', 2)
INSERT [dbo].[tb_Student] ([stu_no], [stu_name], [sex], [age], [telphone], [ClassID]) VALUES (N'000006', N'herry', 1, 19, N'1375665454', 2)
INSERT [dbo].[tb_Student] ([stu_no], [stu_name], [sex], [age], [telphone], [ClassID]) VALUES (N'000007', N'terry', 1, 20, N'13854654524', 3)
INSERT [dbo].[tb_Student] ([stu_no], [stu_name], [sex], [age], [telphone], [ClassID]) VALUES (N'000008', N'robin', 1, 20, N'13945464574', 3)
INSERT [dbo].[tb_Student] ([stu_no], [stu_name], [sex], [age], [telphone], [ClassID]) VALUES (N'000009', N'jonas', 1, 20, N'13204546548', 3)
/****** Object:  Table [dbo].[tb_Score]    Script Date: 06/04/2014 15:03:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Score](
	[sub_id] [int] NOT NULL,
	[stu_no] [varchar](6) NOT NULL,
	[score] [float] NOT NULL,
 CONSTRAINT [PK_tbscore] PRIMARY KEY CLUSTERED 
(
	[sub_id] ASC,
	[stu_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (1, N'000001', 80)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (1, N'000002', 50)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (1, N'000003', 100)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (1, N'000004', 99)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (1, N'000005', 97)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (1, N'000007', 87)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (1, N'000008', 71)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (1, N'000009', 91)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (2, N'000001', 90)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (2, N'000002', 95)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (2, N'000003', 92)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (2, N'000004', 93)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (2, N'000005', 94)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (2, N'000006', 91)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (2, N'000007', 60)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (2, N'000008', 66)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (2, N'000009', 85)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (3, N'000001', 100)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (3, N'000002', 89)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (3, N'000003', 88)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (3, N'000004', 78)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (3, N'000005', 68)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (3, N'000006', 97)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (3, N'000007', 79)
INSERT [dbo].[tb_Score] ([sub_id], [stu_no], [score]) VALUES (3, N'000008', 90)

/****** Object:  StoredProcedure [dbo].[GetStudentScore]    Script Date: 06/04/2014 15:03:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetStudentScore]
(
	@stu_no varchar(6)
)
as
begin
select * into #temp from dbo.tb_Student where stu_no=@stu_no
select a.* ,b.score from #temp as a join (
select AVG(score) as score,stu_no from dbo.tb_Score where stu_no=@stu_no group by stu_no) as b on a.stu_no=b.stu_no
end
GO

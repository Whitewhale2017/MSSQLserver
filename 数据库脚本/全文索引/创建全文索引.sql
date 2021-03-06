--启用全文索引
exec sp_fulltext_database 'enable'
GO
/****** Object:  Table [dbo].[temp_trc]    Script Date: 05/23/2014 11:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[temp_trc_Order_five](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationName] varchar(128),
	[TextData] varchar(max) NULL,
	[DatabaseName] nvarchar(128) NULL,
	[Duration] [bigint] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Reads] [bigint] NULL,
	[Writes] [bigint] NULL,
	[CPU] [int] NULL,
	[Type] [varchar](10) NULL,
	[Type_desc] varchar(128) null
) ON [PRIMARY] 
GO
SET ANSI_PADDING OFF
GO
--创建全文目录
EXEC [sys].[sp_fulltext_catalog] @ftcat = 'FullText_Test',@action = 'create', @path = N'D:\MSSQL_FullText'
GO
--创建唯一索引
create unique index UQ_RowNumber on [dbo].[temp_trc_Order_five]([RowNumber])
go
--创建全文索引,@tabname需要创建的全文索引的表名，@action动作，如：create,drop等等，@ftcat全文目录名，@keyname唯一索引名
EXEC [sys].[sp_fulltext_table] @tabname = N'temp_trc_Order_five',@action = 'create', @ftcat = FullText_Test, @keyname = UQ_RowNumber 
--@language参数的意义在于分词，到时候会把id字段里的数据按照各个国家的语言来进行分词，具体的数字您可以自己指定
--2052代表中文，1033代表美文，2057代表英文
--@tabname需要创建的全文索引的表名，@colname需要创建全文索引的字段，@action动作，如：create,drop等等，@language分词适用的语言
EXEC [sys].[sp_fulltext_column] @tabname = N'temp_trc_Order_five',@colname = TextData,@action = 'add',@language = 2052 
GO
--设置填充计划为自动填充
ALTER FULLTEXT INDEX ON [dbo].[OutFiveMinuteSQL] ENABLE
GO
ALTER FULLTEXT INDEX ON [dbo].[OutFiveMinuteSQL] SET CHANGE_TRACKING = AUTO
GO
--设置填充为手动填充
ALTER FULLTEXT INDEX ON [dbo].[OutFiveMinuteSQL] SET CHANGE_TRACKING MANUAL
GO
--重新生成目录
ALTER FULLTEXT CATALOG [FullText_Test] REBUILD
GO
--查询全文索引碎片
SELECT * FROM  sys.fulltext_index_fragments
go
--重组全文索引目录
ALTER FULLTEXT CATALOG [FullText_Test] REORGANIZE
go
--重新生成全文索引
ALTER FULLTEXT CATALOG [FullText_Test] REBUILD
go
--关闭更改跟踪
ALTER FULLTEXT INDEX ON [dbo].[FullText_Test] SET CHANGE_TRACKING OFF
GO

--手动更新全文索引
ALTER FULLTEXT INDEX ON [dbo].[FullText_Test] SET CHANGE_TRACKING MANUAL
GO
ALTER FULLTEXT INDEX ON HumanResources.JobCandidate START UPDATE POPULATION
GO

--将监控日志导入数据库表，
--fn_trace_gettable函数的第一个参数是文件的路径
--第二个参数是需要导入多少个文件，
--比如：无标题-1.trc，之后有无标题-1_1.trc,1_2.trc等等，如果需要将1至1-30的文件导入，
--default就必须填写31，即1.trc到1_30.trc的文件个数。default默认导入该目录下所有顺序文件。
INSERT INTO dbo.temp_trc_Order([ApplicationName],TextData,[DatabaseName], Duration, StartTime, EndTime, Reads, Writes, CPU)
SELECT [ApplicationName],TextData,'数据库名', Duration, StartTime, EndTime, Reads, Writes, CPU
FROM fn_trace_gettable('E:\ProfilerTraceFile_Order\2014-07-25\无标题 - 2_100.trc', 100)
--导入数据后，全文索引需要一段时间生成，通过查看全文索引的状态，可以知道是否生成完毕。状态=0为完成。
--查看全文索引状态
EXEC sp_help_fulltext_catalogs 'FullText_Test'

--使用全文索引查询
SELECT * FROM [dbo].[temp_trc] WHERE CONTAINS([TextData],'单词名或表名或存储过程名')

GO
--针对主键创建全文索引

CREATE FULLTEXT INDEX ON [dbo].[BankPaymentInfo] KEY INDEX [PK_BANKPAYMENTINFO] ON ([FullText_Test]) WITH (CHANGE_TRACKING AUTO)
GO
ALTER FULLTEXT INDEX ON [dbo].[BankPaymentInfo] ADD ([PaymentInfo1])
GO
ALTER FULLTEXT INDEX ON [dbo].[BankPaymentInfo] ENABLE
GO


--删除全文索引
DROP FULLTEXT INDEX ON [dbo].[BankPaymentInfo]


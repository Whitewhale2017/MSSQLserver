USE [PerfMonBaseLine]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_split]    Script Date: 08/11/2014 09:34:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fun_split](@SourceSql nvarchar(max),@StrSeprate varchar(10))
returns @temp table(SplitValue nvarchar(500))
--功能: 实现split的函数
--用法：select * from dbo.fun_split('ABC:BC:C:D:E',':') 
--日期: 2005-4-20
--作者: Domino
as 
begin 
    DECLARE @i INT, @tmpStr NVARCHAR(100)
	SET @i = CHARINDEX(@StrSeprate, @SourceSql)
	WHILE @i > 0
		BEGIN
			SET @tmpStr = SUBSTRING(@SourceSql, 1, @i-1)
			SET @SourceSql = STUFF(@SourceSql, 1, @i, '')
			SET @i = CHARINDEX(@StrSeprate, @SourceSql)
			INSERT INTO @temp VALUES(@tmpStr)
		END
	INSERT INTO @temp VALUES(@SourceSql)
	RETURN

end
GO
/****** Object:  StoredProcedure [dbo].[InitPerfMonCountTable]    Script Date: 08/11/2014 09:34:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InitPerfMonCountTable]
AS
BEGIN
	DECLARE @COLUMN_NAME VARCHAR(100)
	DECLARE @SQL NVARCHAR(MAX)
	SET @SQL=N'CREATE TABLE PerfMonDataDetailInfo('
	SET @SQL=@SQL+N' CreateTime datetime not null ,'
	SET @SQL=@SQL+N' IPAddress varchar(20) not null ,'
	DECLARE CUR_1 CURSOR FOR SELECT PerfMonCountName FROM dbo.PerfMonCountInfo ORDER BY PerfMonCountName
	OPEN CUR_1
	FETCH CUR_1 INTO @COLUMN_NAME
	WHILE @@FETCH_STATUS=0
	BEGIN
		SET @SQL=@SQL+N'['+@COLUMN_NAME+N'] float NULL ,'
		FETCH CUR_1 INTO @COLUMN_NAME
	END
	CLOSE CUR_1
	DEALLOCATE CUR_1
	SET @SQL=@SQL+N'
	PRIMARY KEY CLUSTERED
	(
		CreateTime,IPAddress
	)
	'
	SET @SQL=@SQL+N')'
	PRINT @SQL
	--EXEC(@SQL)
END
GO
/****** Object:  StoredProcedure [dbo].[InitPerfMonCountMappingData]    Script Date: 08/11/2014 09:34:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InitPerfMonCountMappingData]
(
	@tb_name varchar(100),
	@column_string varchar(max)
)
AS
BEGIN
	INSERT INTO PerfMonCountMapping
	SELECT @tb_name,SplitValue,'float' FROM dbo.fun_split(@column_string,',')
END
GO

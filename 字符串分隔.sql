USE [ecology8]
GO

/****** Object:  UserDefinedFunction [dbo].[F_split]    Script Date: 2017/10/24 17:09:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 ALTER FUNCTION [dbo].[F_split](@ids   VARCHAR(2000),@split VARCHAR(2)) 
 returns @t_split TABLE(col INT) 
 AS 
 BEGIN 
 WHILE( Charindex(@split, @ids) <> 0 ) 
 BEGIN 
 INSERT @t_split (col) VALUES(Substring(@ids, 1, Charindex(@split, @ids) - 1)) SET @ids=Stuff(@ids, 1, Charindex(@split, @ids), '') 
 END 
 INSERT @t_split (col) VALUES(@ids) RETURN END
GO

USE [ecology8]
GO

/****** Object:  UserDefinedFunction [dbo].[SplitStr]    Script Date: 2017/10/24 16:39:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 ALTER function [dbo].[SplitStr] ( @RowData nvarchar(4000), @SplitOn nvarchar(4000) ) 
 RETURNS @RtnValue table ( data nvarchar(4000) ) 
 AS 
 BEGIN 
 Declare @Cnt int 
 Set @Cnt = 1 
 While (Charindex(@SplitOn,@RowData)>0) 
 Begin 
 Insert Into @RtnValue (data) Select Data = ltrim(rtrim(Substring(@RowData,1,Charindex(@SplitOn,@RowData)-1)))  
 Set @RowData = Substring(@RowData,Charindex(@SplitOn,@RowData)+1,len(@RowData)) Set @Cnt = @Cnt + 1 
 End 
 Insert Into @RtnValue (data) Select Data = ltrim(rtrim(@RowData)) 
 Return END
GO


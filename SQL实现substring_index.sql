IF OBJECT_ID('dbo.SubstringIndex') IS NOT NULL
    DROP  FUNCTION dbo.SubstringIndex

GO

CREATE FUNCTION dbo.SubstringIndex(
    @SourceString varchar(8000),
    @delim char(1),
    @idx int
)
RETURNS TABLE WITH SCHEMABINDING
RETURN
WITH 
E(n) AS(
    SELECT n FROM (VALUES(0),(0),(0),(0),(0),(0),(0),(0),(0),(0))E(n)
),
E2(n) AS(
    SELECT a.n FROM E a, E b
),
E4(n) AS(
    SELECT a.n FROM E2 a, E2 b
),
cteTally(n) AS(
    SELECT TOP(LEN(@SourceString)) ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM E4
),
ctePosition(n) AS(
    SELECT TOP( @idx) n
    FROM cteTally
    WHERE SUBSTRING(@SourceString, n, 1) = @delim
)
SELECT LEFT( @SourceString, MAX(n) - 1) String
FROM ctePosition;       
----------测试调用-----------
declare @SourceStr varchar(8000) = 'www.mytestpage.info',
        @delim char(1) = '.',
        @idx int = 2;

select string from dbo.SubstringIndex(@SourceStr,@delim,@idx);
---------------------------实现完全等价于mysql的substring_index--------------------
IF OBJECT_ID('dbo.substring_index') IS NOT NULL
    DROP  FUNCTION dbo.Substring_Index
GO

CREATE FUNCTION dbo.Substring_Index(
    @SourceString varchar(8000),
    @delim char(1),
    @idx int
)
RETURNS varchar(8000) 
AS
begin
declare @return varchar(8000)

select @return=case  
/*针对空值进行处理*/ 
when @SourceString is null or @idx is null then null 
/*字符串中无分割符的情况*/
when len(@SourceString)=len(replace(@SourceString,@delim,'')) then @SourceString 
/*有分隔符，但是分隔符定位数>字符串中的分隔符计数*/
when abs(@idx)>(len(@SourceString)-len(replace(@SourceString,@delim,''))) then @SourceString 
/*负值处理*/
when @idx<0 then replace(@SourceString,(select top 1 string from dbo.SubstringIndex(@SourceString,@delim,len(@SourceString)+1-len(replace(@SourceString,@delim,''))+@idx))+@delim,'')  
/*正值处理*/
  else (select top 1 string from dbo.SubstringIndex(@SourceString,@delim,@idx)) end
return(@return) 
end;
-----------调用测试------------------
declare @str varchar(100)
set @str='上海三思>第一营销中心>工程售后部>售后技术支持组';

select replace(dbo.substring_index(@str,'>',2),dbo.substring_index(@str,'>',1)+'>','')



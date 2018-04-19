--declare @ret varchar(8000)
--select @ret = 'APR-11,APR12,APR06,APR-11,APR12,APR06'
 
--select @ret = 'select '''+replace(@ret,',',''' union select ''')+''''
 
--exec(@ret)
---×Ö·û´®È¥ÖØ

alter function GetDistinct(@str varchar(1000))
returns varchar(1000)
as
begin
    declare @temp varchar(1000)
	declare @res varchar(1000)
    select @temp=(
    select ','+cast(col as varchar) from(
    select distinct col from dbo.F_split(@str,',')) t for xml path('')
	)
    set @res=SUBSTRING(@temp,2,len(@temp))
	return @res
end
go




----×Ö·û´®·Ö¸î
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

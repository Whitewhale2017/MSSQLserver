---按指定符号分割字符串，返回分割后的元素个数，方法很简单，就是看字符串中存在多少个分隔符号，然后再加一，就是要求的结果。----
CREATE function Get_StrArrayLength
(
  @str varchar(1024),  --要分割的字符串
  @split varchar(10)  --分隔符号
)
returns int
as
begin
  declare @location int
  declare @start int
  declare @length int

  set @str=ltrim(rtrim(@str))
  set @location=charindex(@split,@str)
  set @length=1
  while @location<>0
  begin
    set @start=@location+1
    set @location=charindex(@split,@str,@start)
    set @length=@length+1
  end
  return @length
end

select dbo.Get_StrArrayLength('asd,sd,as,a',',')

--sp_help Get_StrArrayLength

---按指定符号分割字符串，返回分割后指定索引的第几个元素，象数组一样方便---
CREATE function Get_StrArrayStrOfIndex
(
  @str varchar(1024),  --要分割的字符串
  @split varchar(10),  --分隔符号
  @index int --取第几个元素
)
returns varchar(1024)
as
begin
  declare @location int
  declare @start int
  declare @next int
  declare @seed int
  set @str=ltrim(rtrim(@str))
  set @start=1
  set @next=1
  set @seed=len(@split)
  set @location=charindex(@split,@str)
  while @location<>0 and @index>@next
  begin
    set @start=@location+@seed
    set @location=charindex(@split,@str,@start)
    set @next=@next+1
  end
  if @location =0 select @location =len(@str)+1
 --这儿存在两种情况：1、字符串不存在分隔符号 2、字符串中存在分隔符号，跳出while循环后，@location为0，那默认为字符串后边有一个分隔符号。
  return substring(@str,@start,@location-@start)
end

--------------------测试-----------
select dbo.Get_StrArrayStrOfIndex('asd,sd,as,a',',',1)

---结合上边两个函数，象数组一样遍历字符串中的元素---
create function  f_splitstr(@SourceSql varchar(8000),@StrSeprate varchar(100))   
  returns   @temp   table(F1   varchar(100))   
  as     
  begin   
  declare   @ch   as   varchar(100)   
  set   @SourceSql=@SourceSql+@StrSeprate     
  while(@SourceSql<>'')   
                  begin   
                  set   @ch=left(@SourceSql,charindex(',',@SourceSql,1)-1)   
  insert   @temp   values(@ch)   
  set   @SourceSql=stuff(@SourceSql,1,charindex(',',@SourceSql,1),'')   
                  end   
  return   
  end

--drop function f_splitstr

select * from dbo.f_splitstr('asd,sd,as,a',',')
---��ָ�����ŷָ��ַ��������طָ���Ԫ�ظ����������ܼ򵥣����ǿ��ַ����д��ڶ��ٸ��ָ����ţ�Ȼ���ټ�һ������Ҫ��Ľ����----
CREATE function Get_StrArrayLength
(
  @str varchar(1024),  --Ҫ�ָ���ַ���
  @split varchar(10)  --�ָ�����
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

---��ָ�����ŷָ��ַ��������طָ��ָ�������ĵڼ���Ԫ�أ�������һ������---
CREATE function Get_StrArrayStrOfIndex
(
  @str varchar(1024),  --Ҫ�ָ���ַ���
  @split varchar(10),  --�ָ�����
  @index int --ȡ�ڼ���Ԫ��
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
 --����������������1���ַ��������ڷָ����� 2���ַ����д��ڷָ����ţ�����whileѭ����@locationΪ0����Ĭ��Ϊ�ַ��������һ���ָ����š�
  return substring(@str,@start,@location-@start)
end

---����ϱ�����������������һ�������ַ����е�Ԫ��---
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

create function Get_plus(@a float,@b float)
returns float
as
begin
    declare @result float
	set @result=@a+@b
	return @result
end

select dbo.Get_plus(12,13.6)
CREATE function dbo.toUppercaseRMB ( @LowerMoney decimal(18,4))  
returns varchar(200)   
as      
begin      
   declare @lowerStr varchar(200)      
   declare @UpperStr varchar(200)      
   declare @UpperPart varchar(200)     --����      
   declare @i int       
         
   set @lowerStr=ltrim(rtrim(convert(decimal(18,2),round(@LowerMoney,2))))      
   set @i=1      
   set @UpperStr=''      
         
   while(@i<=len(@lowerStr))      
   begin      
        select @UpperPart=  
        case substring(@lowerStr,len(@lowerStr)-@i+1,1)--ȡ���һλ��  
            when  '.' then 'Ԫ'      
            when  '0' then '��'      
            when  '1' then 'Ҽ'      
            when  '2' then '��'      
            when  '3' then '��'      
            when  '4' then '��'      
            when  '5' then '��'      
            when  '6' then '½'      
            when  '7' then '��'      
            when  '8' then '��'      
            when  '9' then '��'      
        end      
        +      
        case @i       
            when 1 then  '��'      
            when 2 then  '��'      
            when 3 then  ''      
            when 4 then  ''      
            when 5 then  'ʰ'      
            when 6 then  '��'      
            when 7 then  'Ǫ'      
            when 8 then  '��'      
            when 9 then  'ʰ'      
            when 10 then '��'      
            when 11 then 'Ǫ'      
            when 12 then '��'      
            when 13 then 'ʰ'      
            when 14 then '��'      
            when 15 then 'Ǫ'      
            when 16 then '��'      
            else ''      
        end      
        set @UpperStr=@UpperPart+@UpperStr      
        set @i=@i+1      
    end       
    set @UpperStr = REPLACE(@UpperStr,'��ʰ','��')       
    set @UpperStr = REPLACE(@UpperStr,'���','��')       
    set @UpperStr = REPLACE(@UpperStr,'��Ǫ�����ʰ','��')       
    set @UpperStr  = REPLACE(@UpperStr,'��Ǫ','��')      
    set @UpperStr = REPLACE(@UpperStr,'������','��')      
    set @UpperStr = REPLACE(@UpperStr,'����','��')      
    set @UpperStr = REPLACE(@UpperStr,'������','')      
    set @UpperStr = REPLACE(@UpperStr,'���','')      
    set @UpperStr = REPLACE(@UpperStr,'���','��')      
    set @UpperStr = REPLACE(@UpperStr,'����������Ԫ','��Ԫ')      
    set @UpperStr = REPLACE(@UpperStr,'��������Ԫ','��Ԫ')      
    set @UpperStr = REPLACE(@UpperStr,'��������','��')      
    set @UpperStr = REPLACE(@UpperStr,'������Ԫ','��Ԫ')      
    set @UpperStr = REPLACE(@UpperStr,'����Ԫ','��Ԫ')      
    set @UpperStr = REPLACE(@UpperStr,'����','��')      
    set @UpperStr = REPLACE(@UpperStr,'����','��')      
    set @UpperStr = REPLACE(@UpperStr,'��Ԫ','Ԫ')      
    set @UpperStr = REPLACE(@UpperStr,'����','��')      
    if left(@UpperStr,1)='Ԫ'      
        set @UpperStr = REPLACE(@UpperStr,'Ԫ','��Ԫ')      
  
  return @UpperStr+'��'      
end      
  

CREATE FUNCTION dbo.szL2U (@n_LowerNum numeric(15,2))  --ת��������2λ
RETURNS VARCHAR(200) AS  
BEGIN 
declare @v_Str VARCHAR(200)
set  @v_Str=replace(replace(replace((replace(dbo.L2U(@n_LowerNum,0),'Ԫ','��')),'��',''),'��',''),'��','')
IF '��'=right(@v_Str,1)
begin
     set @v_Str=replace(@v_Str,'��','')
end
if 0=left(@n_LowerNum,1)
begin
    set @v_Str='���'+@v_Str
end
return @v_Str
END

drop function dbo.szL2U 

select right((select replace(replace(replace((replace(dbo.L2U(66.12,0),'Ԫ','��')),'��',''),'��',''),'��','')),1)

select dbo.szL2U(0.01)

select dbo.L2U(0.23,0)


------------------����Сдת��д�Ż�----------
USE [ecology]
GO
/****** Object:  UserDefinedFunction [dbo].[szL2U]    Script Date: 2016/9/14 15:25:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[szL2U] (@n_LowerNum numeric(15,2))  --ת��������2λ
RETURNS VARCHAR(200) AS  
BEGIN 
declare @v_Str VARCHAR(200)
set  @v_Str=replace(replace(replace((replace(dbo.L2U(@n_LowerNum,0),'Ԫ','��')),'��',''),'��',''),'��','')
IF '��'=right(@v_Str,1)
begin
     set @v_Str=replace(@v_Str,'��','')
end
IF '��'=right(@v_Str,1)
begin
     set @v_Str=replace(replace(@v_Str,'��',''),'��','')
end
if 0=left(@n_LowerNum,1)
   begin
    if 0.0=left(@n_LowerNum,3)
      set @v_Str='�����'+@v_Str
	else
	  set @v_Str='���'+@v_Str
	end

if 0=@n_LowerNum
begin
    set @v_Str='��'
end
return @v_Str
END
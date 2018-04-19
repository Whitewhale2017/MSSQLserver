CREATE FUNCTION dbo.L2U (@n_LowerMoney numeric(15,2),@v_TransType int)  
RETURNS VARCHAR(200) AS  
BEGIN 
Declare @v_LowerStr VARCHAR(200) -- Сд��� 
Declare @v_UpperPart VARCHAR(200) 
Declare @v_UpperStr VARCHAR(200) -- ��д���
Declare @i_I int

set @v_LowerStr = LTRIM(RTRIM(ROUND(@n_LowerMoney,2))) --��������Ϊָ���ľ��Ȳ�ɾ���������ҿո�
set @i_I = 1
set @v_UpperStr = ''

while ( @i_I <= len(@v_LowerStr))
begin
      select @v_UpperPart = case substring(@v_LowerStr,len(@v_LowerStr) - @i_I + 1,1)
                            WHEN  '.' THEN  'Ԫ'
                            WHEN  '0' THEN  '��'
                            WHEN  '1' THEN  'Ҽ'
                            WHEN  '2' THEN  '��'
                            WHEN  '3' THEN  '��'
                            WHEN  '4' THEN  '��'
                            WHEN  '5' THEN  '��'
                            WHEN  '6' THEN  '½'
                            WHEN  '7' THEN  '��'
                            WHEN  '8' THEN  '��'
                            WHEN  '9' THEN  '��'
                            END
                          + 
                            case @i_I
                            WHEN  1  THEN  '��'
                            WHEN  2  THEN  '��'
                            WHEN  3  THEN  ''
                            WHEN  4  THEN  ''
                            WHEN  5  THEN  'ʰ'
                            WHEN  6  THEN  '��'
                            WHEN  7  THEN  'Ǫ'
                            WHEN  8  THEN  '��'
                            WHEN  9  THEN  'ʰ'
                            WHEN  10  THEN  '��'
                            WHEN  11  THEN  'Ǫ'
                            WHEN  12  THEN  '��'
                            WHEN  13  THEN  'ʰ'
                            WHEN  14  THEN  '��'
                            WHEN  15  THEN  'Ǫ'
                            WHEN  16  THEN  '��'
                            ELSE ''
                            END
set @v_UpperStr = @v_UpperPart + @v_UpperStr
set @i_I = @i_I + 1
end
if ( 0 = @v_TransType)
begin
set @v_UpperStr = REPLACE(@v_UpperStr,'��ʰ','��') 
set @v_UpperStr = REPLACE(@v_UpperStr,'���','��') 
set @v_UpperStr = REPLACE(@v_UpperStr,'��Ǫ','��') 
set @v_UpperStr = REPLACE(@v_UpperStr,'������','��')
set @v_UpperStr = REPLACE(@v_UpperStr,'����','��')
set @v_UpperStr = REPLACE(@v_UpperStr,'������','��')
set @v_UpperStr = REPLACE(@v_UpperStr,'���','��')
set @v_UpperStr = REPLACE(@v_UpperStr,'���','��')
set @v_UpperStr = REPLACE(@v_UpperStr,'����������Ԫ','��Ԫ')
set @v_UpperStr = REPLACE(@v_UpperStr,'��������Ԫ','��Ԫ')
set @v_UpperStr = REPLACE(@v_UpperStr,'��������','��')
set @v_UpperStr = REPLACE(@v_UpperStr,'������Ԫ','��Ԫ')
set @v_UpperStr = REPLACE(@v_UpperStr,'����Ԫ','��Ԫ')
set @v_UpperStr = REPLACE(@v_UpperStr,'����','��')
set @v_UpperStr = REPLACE(@v_UpperStr,'����','��')
set @v_UpperStr = REPLACE(@v_UpperStr,'��Ԫ','Ԫ')
set @v_UpperStr = REPLACE(@v_UpperStr,'����','��')
end
-- ��ҼԪ���µĽ��Ĵ��� 
if ( 'Ԫ' = substring(@v_UpperStr,1,1))
begin
     set @v_UpperStr = substring(@v_UpperStr,2,(len(@v_UpperStr) - 1))
end

if ( '��' = substring(@v_UpperStr,1,1))
begin
     set @v_UpperStr = substring(@v_UpperStr,2,(len(@v_UpperStr) - 1))
end

if ( '��' = substring(@v_UpperStr,1,1))
begin
     set @v_UpperStr = substring(@v_UpperStr,2,(len(@v_UpperStr) - 1))
end

if ( '��' = substring(@v_UpperStr,1,1))
begin
     set @v_UpperStr = substring(@v_UpperStr,2,(len(@v_UpperStr) - 1))
end

if ('��' = substring(@v_UpperStr,1,1))
begin
     set @v_UpperStr = '��Ԫ��'
end
return @v_UpperStr
END


CREATE FUNCTION dbo.szL2U (@n_LowerNum numeric(15,2))  --ת��������2λ
RETURNS VARCHAR(200) AS  
BEGIN 
declare @v_Str VARCHAR(200)
set  @v_Str=replace(replace(replace((replace(dbo.L2U(@n_LowerNum,0),'Ԫ','��')),'��',''),'��',''),'��','')
IF '��'=right(@v_Str,1)
begin
     set @v_Str=replace(@v_Str,'��','')
end
return @v_Str
END

drop function dbo.szL2U 

select right((select replace(replace(replace((replace(dbo.L2U(66.12,0),'Ԫ','��')),'��',''),'��',''),'��','')),1)

select dbo.szL2U(1005.23)

select dbo.L2U(1005.23123,0)
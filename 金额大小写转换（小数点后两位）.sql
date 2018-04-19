CREATE FUNCTION dbo.L2U (@n_LowerMoney numeric(15,2),@v_TransType int)  
RETURNS VARCHAR(200) AS  
BEGIN 
Declare @v_LowerStr VARCHAR(200) -- 小写金额 
Declare @v_UpperPart VARCHAR(200) 
Declare @v_UpperStr VARCHAR(200) -- 大写金额
Declare @i_I int

set @v_LowerStr = LTRIM(RTRIM(ROUND(@n_LowerMoney,2))) --四舍五入为指定的精度并删除数据左右空格
set @i_I = 1
set @v_UpperStr = ''

while ( @i_I <= len(@v_LowerStr))
begin
      select @v_UpperPart = case substring(@v_LowerStr,len(@v_LowerStr) - @i_I + 1,1)
                            WHEN  '.' THEN  '元'
                            WHEN  '0' THEN  '零'
                            WHEN  '1' THEN  '壹'
                            WHEN  '2' THEN  '贰'
                            WHEN  '3' THEN  '叁'
                            WHEN  '4' THEN  '肆'
                            WHEN  '5' THEN  '伍'
                            WHEN  '6' THEN  '陆'
                            WHEN  '7' THEN  '柒'
                            WHEN  '8' THEN  '捌'
                            WHEN  '9' THEN  '玖'
                            END
                          + 
                            case @i_I
                            WHEN  1  THEN  '分'
                            WHEN  2  THEN  '角'
                            WHEN  3  THEN  ''
                            WHEN  4  THEN  ''
                            WHEN  5  THEN  '拾'
                            WHEN  6  THEN  '佰'
                            WHEN  7  THEN  '仟'
                            WHEN  8  THEN  '万'
                            WHEN  9  THEN  '拾'
                            WHEN  10  THEN  '佰'
                            WHEN  11  THEN  '仟'
                            WHEN  12  THEN  '亿'
                            WHEN  13  THEN  '拾'
                            WHEN  14  THEN  '佰'
                            WHEN  15  THEN  '仟'
                            WHEN  16  THEN  '万'
                            ELSE ''
                            END
set @v_UpperStr = @v_UpperPart + @v_UpperStr
set @i_I = @i_I + 1
end
if ( 0 = @v_TransType)
begin
set @v_UpperStr = REPLACE(@v_UpperStr,'零拾','零') 
set @v_UpperStr = REPLACE(@v_UpperStr,'零佰','零') 
set @v_UpperStr = REPLACE(@v_UpperStr,'零仟','零') 
set @v_UpperStr = REPLACE(@v_UpperStr,'零零零','零')
set @v_UpperStr = REPLACE(@v_UpperStr,'零零','零')
set @v_UpperStr = REPLACE(@v_UpperStr,'零角零分','整')
set @v_UpperStr = REPLACE(@v_UpperStr,'零分','整')
set @v_UpperStr = REPLACE(@v_UpperStr,'零角','零')
set @v_UpperStr = REPLACE(@v_UpperStr,'零亿零万零元','亿元')
set @v_UpperStr = REPLACE(@v_UpperStr,'亿零万零元','亿元')
set @v_UpperStr = REPLACE(@v_UpperStr,'零亿零万','亿')
set @v_UpperStr = REPLACE(@v_UpperStr,'零万零元','万元')
set @v_UpperStr = REPLACE(@v_UpperStr,'万零元','万元')
set @v_UpperStr = REPLACE(@v_UpperStr,'零亿','亿')
set @v_UpperStr = REPLACE(@v_UpperStr,'零万','万')
set @v_UpperStr = REPLACE(@v_UpperStr,'零元','元')
set @v_UpperStr = REPLACE(@v_UpperStr,'零零','零')
end
-- 对壹元以下的金额的处理 
if ( '元' = substring(@v_UpperStr,1,1))
begin
     set @v_UpperStr = substring(@v_UpperStr,2,(len(@v_UpperStr) - 1))
end

if ( '零' = substring(@v_UpperStr,1,1))
begin
     set @v_UpperStr = substring(@v_UpperStr,2,(len(@v_UpperStr) - 1))
end

if ( '角' = substring(@v_UpperStr,1,1))
begin
     set @v_UpperStr = substring(@v_UpperStr,2,(len(@v_UpperStr) - 1))
end

if ( '分' = substring(@v_UpperStr,1,1))
begin
     set @v_UpperStr = substring(@v_UpperStr,2,(len(@v_UpperStr) - 1))
end

if ('整' = substring(@v_UpperStr,1,1))
begin
     set @v_UpperStr = '零元整'
end
return @v_UpperStr
END


CREATE FUNCTION dbo.szL2U (@n_LowerNum numeric(15,2))  --转换浮点数2位
RETURNS VARCHAR(200) AS  
BEGIN 
declare @v_Str VARCHAR(200)
set  @v_Str=replace(replace(replace((replace(dbo.L2U(@n_LowerNum,0),'元','点')),'整',''),'角',''),'分','')
IF '点'=right(@v_Str,1)
begin
     set @v_Str=replace(@v_Str,'点','')
end
return @v_Str
END

drop function dbo.szL2U 

select right((select replace(replace(replace((replace(dbo.L2U(66.12,0),'元','点')),'整',''),'角',''),'分','')),1)

select dbo.szL2U(1005.23)

select dbo.L2U(1005.23123,0)
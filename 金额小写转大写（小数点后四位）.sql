SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON 
GO
Create Function LowerToUpper(@LowerMoney Decimal(38,4)) 
Returns Varchar(200) --返回的大写金额的字符 
As 
Begin 
Declare @LowerStr Varchar(50) --小写金额 
Declare @UpperStr Varchar(200) --大写金额 
Declare @UpperTmp Varchar(15) --大写金额的临时字符串 
Declare @i Int --递增量 
Declare @LowerLen Int --小写金额的总长度
Set @LowerStr = @LowerMoney --把Decimal型的值全部赋给字符串变量 注:(赋值过去的话如8 在字符串变量中是显示8.0000 因为小数位精确到四位,没有的话，它会自动补0) 
Set @LowerStr = Replace(@LowerStr,'.','') --把小数点替换成空字符 --精确到小数点的四位 角分厘毫
Set @LowerLen = Len(@LowerStr) --获取小写金额的总长度(包括四个小数位) 
Select @i = 1,@UpperStr = '',@UpperTmp = '' --设置默认初始值
While @i <= @LowerLen 
Begin 
Set @UpperTmp = Case
When SubString(@LowerStr,@LowerLen - @i + 1,1) = '0' And @i = 5 And (Convert(Int,Right(@LowerStr,4)) = 0 Or @LowerLen > 5) Then '元' --注：如果个位为0的话,并且四位小数都是0或者它的长度超过5(也就是超过元)，则为元 
--When SubString(@LowerStr,@LowerLen - @i + 1,1) = '0' Then '' 
Else 
+ Case SubString(@LowerStr,@LowerLen - @i + 1,1) --看当前位是数字几,就直接替换成汉字繁体大写 
When '0' Then '零' 
When '1' Then '壹' 
When '2' Then '贰' 
When '3' Then '叁' 
When '4' Then '肆' 
When '5' Then '伍' 
When '6' Then '陆' 
When '7' Then '柒' 
When '8' Then '捌' 
When '9' Then '玖' 
End 
+ Case @i 
When 1 Then '毫' 
When 2 Then '厘' 
When 3 Then '分' 
When 4 Then '角' 
When 5 Then '元' 
When 9 Then '萬' 
When 13 Then '亿' 
When 17 Then '兆' 
When 21 Then '京' 
When 25 Then '垓' 
When 29 Then '杼' 
When 33 Then '穰' 
When 37 Then '沟' --Decimal型最大长度是38 后面的就不用再考虑了 
Else+ Case @i%4 
When 2 Then '拾' --拾 6 10 14 18 22 26 30 34 38 ………… 
When 3 Then '佰' --佰 7 11 15 19 23 27 31 35 39 ………… 
When 0 Then '仟' --仟 8 12 16 20 24 28 32 36 40 ………… 
End 
End 
End 
Set @UpperStr = Isnull(@UpperTmp,'') + Isnull(@UpperStr,'') 
Set @i = @i + 1 
End 
If Convert(Int,Right(@LowerStr,4)) = 0 Set @UpperStr = Left(@UpperStr,Len(@UpperStr)-8) + '整' --判断小数位数是不是都是0,是0就可以取整 
While Patindex('%零[仟佰拾角分厘毫零]%',@UpperStr) <> 0 --把零拾或零佰或零零变成一个零 
Begin 
Set @UpperStr = stuff(@UpperStr,patindex('%零[仟佰拾角分厘毫零]%',@UpperStr),2,'零') 
End 
While Patindex('%[沟穰杼垓京兆亿萬]零[沟穰杼垓京兆亿萬]%',@UpperStr) <> 0 --把零萬或零亿的清空掉 
Begin 
Select @UpperStr = Stuff(@UpperStr,Patindex('%[沟穰杼垓京兆亿萬]零[沟穰杼垓京兆亿萬]%',@UpperStr)+1,2,'') 
End 
While Patindex('%[仟佰拾]零[沟穰杼垓京兆亿萬]%',@UpperStr) <> 0 --把类似拾零萬或佰零萬或仟零萬中间的零清空掉 
Begin 
Select @UpperStr = Stuff(@UpperStr,Patindex('%[仟佰拾]零[沟穰杼垓京兆亿萬]%',@UpperStr)+1,1,'') 
End 
If Patindex('%_零[元]%',@UpperStr) <> 0 --把类似拾零元或百零元中间的零清空掉 
Begin 
Select @UpperStr = Stuff(@UpperStr,Patindex('%_零[元]%',@UpperStr) + 1,1,'') 
End 
Else If (Patindex('零[元]%',@UpperStr) <> 0) And (Convert(Int,Right(@LowerStr,4)) <> 0) --判断当前否是零元开头，并且后面的四个小数不为0 
Begin 
Select @UpperStr = Stuff(@UpperStr,Patindex('零[元]%',@UpperStr),2,'') --把零元清空掉 
End 
If Right(@UpperStr,1) = '零' Set @UpperStr = Left(@UpperStr,Len(@UpperStr)-1) --如果最后一位是零也清空掉 
If @UpperStr = '元整' Set @UpperStr = '零' + @UpperStr --如果只是0的话，就显示零元整 
Return @UpperStr --返回大写金额 
End
--GO 
--SET QUOTED_IDENTIFIER OFF 
--GO 
--SET ANSI_NULLS ON 
--GO
--调用方法 
--Select dbo.LowerToUpper(120000000) --壹亿贰仟萬元整 
--Select dbo.LowerToUpper(102000000) --壹亿零贰佰萬元整 
--Select dbo.LowerToUpper(100200000) --壹亿零贰拾萬元整 
--Select dbo.LowerToUpper(100020000) --壹亿零贰萬元整 
--Select dbo.LowerToUpper(100002000) --壹亿贰仟元整


USE [ecology]
GO
/****** Object:  UserDefinedFunction [dbo].[szL2U]    Script Date: 2016/9/14 15:25:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[szL2U] (@n_LowerNum numeric(15,4))  --转换浮点数2位
RETURNS VARCHAR(200) AS  
BEGIN 
declare @v_Str VARCHAR(200)
set  @v_Str=replace(replace(replace(replace(replace((replace(dbo.LowerToUpper(@n_LowerNum),'元','点')),'整',''),'角',''),'分',''),'厘',''),'毫','')
IF '点'=right(@v_Str,1)
begin
     set @v_Str=replace(@v_Str,'点','')
end
IF '零'=right(@v_Str,1)
begin
     set @v_Str=replace(replace(@v_Str,'点',''),'零','')
end
if 0=left(@n_LowerNum,1)
   begin
    if 0.0=left(@n_LowerNum,3)
      set @v_Str='零点零'+@v_Str
	else
	  set @v_Str='零点'+@v_Str
	end

if 0=@n_LowerNum
begin
    set @v_Str='零'
end
return @v_Str
END

--------调试-------



select replace(replace(replace(replace(replace((replace(dbo.LowerToUpper(563.0002),'元','点')),'整',''),'角',''),'分',''),'厘',''),'毫','')

select dbo.szL2U(0)
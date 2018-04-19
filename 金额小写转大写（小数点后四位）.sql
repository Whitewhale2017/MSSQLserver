SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON 
GO
Create Function LowerToUpper(@LowerMoney Decimal(38,4)) 
Returns Varchar(200) --���صĴ�д�����ַ� 
As 
Begin 
Declare @LowerStr Varchar(50) --Сд��� 
Declare @UpperStr Varchar(200) --��д��� 
Declare @UpperTmp Varchar(15) --��д������ʱ�ַ��� 
Declare @i Int --������ 
Declare @LowerLen Int --Сд�����ܳ���
Set @LowerStr = @LowerMoney --��Decimal�͵�ֵȫ�������ַ������� ע:(��ֵ��ȥ�Ļ���8 ���ַ�������������ʾ8.0000 ��ΪС��λ��ȷ����λ,û�еĻ��������Զ���0) 
Set @LowerStr = Replace(@LowerStr,'.','') --��С�����滻�ɿ��ַ� --��ȷ��С�������λ �Ƿ����
Set @LowerLen = Len(@LowerStr) --��ȡСд�����ܳ���(�����ĸ�С��λ) 
Select @i = 1,@UpperStr = '',@UpperTmp = '' --����Ĭ�ϳ�ʼֵ
While @i <= @LowerLen 
Begin 
Set @UpperTmp = Case
When SubString(@LowerStr,@LowerLen - @i + 1,1) = '0' And @i = 5 And (Convert(Int,Right(@LowerStr,4)) = 0 Or @LowerLen > 5) Then 'Ԫ' --ע�������λΪ0�Ļ�,������λС������0�������ĳ��ȳ���5(Ҳ���ǳ���Ԫ)����ΪԪ 
--When SubString(@LowerStr,@LowerLen - @i + 1,1) = '0' Then '' 
Else 
+ Case SubString(@LowerStr,@LowerLen - @i + 1,1) --����ǰλ�����ּ�,��ֱ���滻�ɺ��ַ����д 
When '0' Then '��' 
When '1' Then 'Ҽ' 
When '2' Then '��' 
When '3' Then '��' 
When '4' Then '��' 
When '5' Then '��' 
When '6' Then '½' 
When '7' Then '��' 
When '8' Then '��' 
When '9' Then '��' 
End 
+ Case @i 
When 1 Then '��' 
When 2 Then '��' 
When 3 Then '��' 
When 4 Then '��' 
When 5 Then 'Ԫ' 
When 9 Then '�f' 
When 13 Then '��' 
When 17 Then '��' 
When 21 Then '��' 
When 25 Then '��' 
When 29 Then '��' 
When 33 Then '�' 
When 37 Then '��' --Decimal����󳤶���38 ����ľͲ����ٿ����� 
Else+ Case @i%4 
When 2 Then 'ʰ' --ʰ 6 10 14 18 22 26 30 34 38 �������� 
When 3 Then '��' --�� 7 11 15 19 23 27 31 35 39 �������� 
When 0 Then 'Ǫ' --Ǫ 8 12 16 20 24 28 32 36 40 �������� 
End 
End 
End 
Set @UpperStr = Isnull(@UpperTmp,'') + Isnull(@UpperStr,'') 
Set @i = @i + 1 
End 
If Convert(Int,Right(@LowerStr,4)) = 0 Set @UpperStr = Left(@UpperStr,Len(@UpperStr)-8) + '��' --�ж�С��λ���ǲ��Ƕ���0,��0�Ϳ���ȡ�� 
While Patindex('%��[Ǫ��ʰ�Ƿ������]%',@UpperStr) <> 0 --����ʰ����ۻ�������һ���� 
Begin 
Set @UpperStr = stuff(@UpperStr,patindex('%��[Ǫ��ʰ�Ƿ������]%',@UpperStr),2,'��') 
End 
While Patindex('%[������������f]��[������������f]%',@UpperStr) <> 0 --�����f�����ڵ���յ� 
Begin 
Select @UpperStr = Stuff(@UpperStr,Patindex('%[������������f]��[������������f]%',@UpperStr)+1,2,'') 
End 
While Patindex('%[Ǫ��ʰ]��[������������f]%',@UpperStr) <> 0 --������ʰ���f������f��Ǫ���f�м������յ� 
Begin 
Select @UpperStr = Stuff(@UpperStr,Patindex('%[Ǫ��ʰ]��[������������f]%',@UpperStr)+1,1,'') 
End 
If Patindex('%_��[Ԫ]%',@UpperStr) <> 0 --������ʰ��Ԫ�����Ԫ�м������յ� 
Begin 
Select @UpperStr = Stuff(@UpperStr,Patindex('%_��[Ԫ]%',@UpperStr) + 1,1,'') 
End 
Else If (Patindex('��[Ԫ]%',@UpperStr) <> 0) And (Convert(Int,Right(@LowerStr,4)) <> 0) --�жϵ�ǰ������Ԫ��ͷ�����Һ�����ĸ�С����Ϊ0 
Begin 
Select @UpperStr = Stuff(@UpperStr,Patindex('��[Ԫ]%',@UpperStr),2,'') --����Ԫ��յ� 
End 
If Right(@UpperStr,1) = '��' Set @UpperStr = Left(@UpperStr,Len(@UpperStr)-1) --������һλ����Ҳ��յ� 
If @UpperStr = 'Ԫ��' Set @UpperStr = '��' + @UpperStr --���ֻ��0�Ļ�������ʾ��Ԫ�� 
Return @UpperStr --���ش�д��� 
End
--GO 
--SET QUOTED_IDENTIFIER OFF 
--GO 
--SET ANSI_NULLS ON 
--GO
--���÷��� 
--Select dbo.LowerToUpper(120000000) --Ҽ�ڷ�Ǫ�fԪ�� 
--Select dbo.LowerToUpper(102000000) --Ҽ���㷡���fԪ�� 
--Select dbo.LowerToUpper(100200000) --Ҽ���㷡ʰ�fԪ�� 
--Select dbo.LowerToUpper(100020000) --Ҽ���㷡�fԪ�� 
--Select dbo.LowerToUpper(100002000) --Ҽ�ڷ�ǪԪ��


USE [ecology]
GO
/****** Object:  UserDefinedFunction [dbo].[szL2U]    Script Date: 2016/9/14 15:25:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[szL2U] (@n_LowerNum numeric(15,4))  --ת��������2λ
RETURNS VARCHAR(200) AS  
BEGIN 
declare @v_Str VARCHAR(200)
set  @v_Str=replace(replace(replace(replace(replace((replace(dbo.LowerToUpper(@n_LowerNum),'Ԫ','��')),'��',''),'��',''),'��',''),'��',''),'��','')
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

--------����-------



select replace(replace(replace(replace(replace((replace(dbo.LowerToUpper(563.0002),'Ԫ','��')),'��',''),'��',''),'��',''),'��',''),'��','')

select dbo.szL2U(0)
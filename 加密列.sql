use OAView;

----------��������ʱ��ѡ�������� Column Encryption Setting=Enabled--------
--��Ϊ���С���ѯ�༭�����������úͽ��� Always Encrypted ֮������л���
--�Ҽ���������ѯ�༭���������е�����λ�á�
--ѡ�����ӡ� > ���������ӡ��� ��
--������ѡ� >>��
--ѡ�С��������ԡ� ѡ���Ȼ����� Column Encryption Setting=Enabled ������ Always Encrypted ��Ϊ��ɾ���������Խ��� Always Encrypted ��Ϊ��
--���� �����ӡ� ��

------------------------------���� Always Encrypted ������--------------------------------------------
--����/���� Always Encrypted ������
--Ĭ������£������� Always Encrypted��
--Ϊ��ǰ�ġ���ѯ�༭������������/���� Always Encrypted ��������
--�����˵��У�ѡ�񡰲�ѯ�� ��
--ѡ�񡰲�ѯѡ��� ��
--��������ִ�С� > ���߼��� ��
--ѡ���ȡ��ѡ������ Always Encrypted �������� ��
--������ȷ���� ��
--Ϊ�Ժ�ġ���ѯ�༭������������/���� Always Encrypted ��������
--�����˵��У�ѡ�񡰹��ߡ� ��
--ѡ��ѡ��...�� ��
--����������ѯִ�С� > ��SQL Server�� > ���߼��� ��
--ѡ���ȡ��ѡ������ Always Encrypted �������� ��
--������ȷ���� ��

---------Always Encrypted ��Կ �������ü��ܵĿͻ��˵������ַ�����Ҫ�鿴�Ŀͻ���--------------
--------��IE�е�������֤��--------------------------

  select * from [dbo].[Test0823] --������-----

  
  select * from [dbo].[Test0823] where test1='00'

  ---truncate table [Test0823]

 select * from [dbo].[Test0823] where cardnum = N'123456' -----����--
 ---------------------------------------------------
begin
 declare @cnum nvarchar(100) =N'123456'       --ע�ⲻ��ʹ���ȶ�����setʵ�ֲ�����                                                                               
 select * from [dbo].[Test0823] where cardnum = @cnum 
end
 -------------------------------------------- 
 begin
 declare @T1 nvarchar(10) =N'00'    
 declare @T2 nvarchar(10) =N'A00' 
 declare @cnum nvarchar(100) =N'023456'
 insert into [Test0823] values(@T1,@T2,@cnum)   
 end

insert into [Test0823] values('01','AA1','12345678') ---����

---�鿴��Կ�ļ�-----
select * from sys.column_master_keys;
select * from sys.column_encryption_keys;
select * from sys.column_encryption_key_values;
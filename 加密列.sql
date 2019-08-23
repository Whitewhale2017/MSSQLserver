use OAView;

----------创建链接时，选项中新增 Column Encryption Setting=Enabled--------
--在为现有“查询编辑器”窗口启用和禁用 Always Encrypted 之间进行切换：
--右键单击“查询编辑器”窗口中的任意位置。
--选择“连接” > “更改连接…” ，
--单击“选项” >>，
--选中“其他属性” 选项卡，然后键入 Column Encryption Setting=Enabled 以启用 Always Encrypted 行为或删除该设置以禁用 Always Encrypted 行为。
--单击 “连接” 。

------------------------------启用 Always Encrypted 参数化--------------------------------------------
--启用/禁用 Always Encrypted 参数化
--默认情况下，将禁用 Always Encrypted。
--为当前的“查询编辑器”窗口启用/禁用 Always Encrypted 参数化：
--在主菜单中，选择“查询” 。
--选择“查询选项…” 。
--导航到“执行” > “高级” 。
--选择或取消选择“启用 Always Encrypted 参数化” 。
--单击“确定” 。
--为以后的“查询编辑器”窗口启用/禁用 Always Encrypted 参数化：
--在主菜单中，选择“工具” 。
--选择“选项...” 。
--导航到“查询执行” > “SQL Server” > “高级” 。
--选择或取消选择“启用 Always Encrypted 参数化” 。
--单击“确定” 。

---------Always Encrypted 密钥 需在设置加密的客户端导出并分发给需要查看的客户端--------------
--------在IE中导、导出证书--------------------------

  select * from [dbo].[Test0823] --不报错-----

  
  select * from [dbo].[Test0823] where test1='00'

  ---truncate table [Test0823]

 select * from [dbo].[Test0823] where cardnum = N'123456' -----报错--
 ---------------------------------------------------
begin
 declare @cnum nvarchar(100) =N'123456'       --注意不能使用先定义再set实现参数化                                                                               
 select * from [dbo].[Test0823] where cardnum = @cnum 
end
 -------------------------------------------- 
 begin
 declare @T1 nvarchar(10) =N'00'    
 declare @T2 nvarchar(10) =N'A00' 
 declare @cnum nvarchar(100) =N'023456'
 insert into [Test0823] values(@T1,@T2,@cnum)   
 end

insert into [Test0823] values('01','AA1','12345678') ---报错

---查看密钥文件-----
select * from sys.column_master_keys;
select * from sys.column_encryption_keys;
select * from sys.column_encryption_key_values;
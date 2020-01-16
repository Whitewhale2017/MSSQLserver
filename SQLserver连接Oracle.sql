 
 
-- 准备工作：
--本地安装Oracle客户端后，配置远程Oracle服务的tnsnames.ora记录：
--找到本地文件tnsnames.ora（文件位置为Oracle安装目录*\network\admin下），新增远程服务如：
--OADB=
--  (DESCRIPTION =
--    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.4.172)(PORT = 1521))
--    (CONNECT_DATA =
--      (SERVER = DEDICATED)
--      (SERVICE_NAME = orcl)
--    )
 
 ----ODBC中配置TNS service name
 
 
 --建立数据库链接服务器
EXEC sp_addlinkedserver
@server =N'DW', --要创建的链接服务器别名
@srvproduct=N'Oracle', --产品名称
@provider=N'OraOLEDB.Oracle', --OLE DB 驱动名称
@datasrc=N'DWDB' --数据源oracle"ora10g"network"admin"tnsnames.ora查看

EXEC sp_addlinkedsrvlogin
 'DW', --已建立的链接服务器名
'false', -- 固定 */ 
NULL, --为每个登陆SQL SERVER的用户使用此链接服务器,则写用户名*/
'DW_OA', --帐号(oracle)
'Sansi1280' --密码

SELECT * FROM openquery(DW,'select * from sap_acdoca');

exec sp_serveroption 'DW','rpc out','true' 
exec sp_serveroption 'DW','rpc','true' 
--这两个是打开rpc,rpc out的，默认为False,打开后可以支持远程更改分布式事务。（如有分布式事务操作必须要设置）


-----------------------不配置ODBC可如下配置---------------------

EXEC master.dbo.sp_addlinkedserver 
@server = N'PLM PRD', 
@srvproduct=N'Oracle', 
@provider=N'OraOLEDB.Oracle',
 @datasrc=N'192.168.4.135:1521/orcl' --------数据源直接写地址
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin 
@rmtsrvname=N'PLM PRD',
@useself=N'False',
@locallogin=NULL,
@rmtuser=N'SSPLM',
@rmtpassword='########'

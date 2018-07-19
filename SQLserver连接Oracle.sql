 
 
-- 准备工作：
--本地安装Oracle客户端后，配置远程Oracle服务的tnsnames.ora记录：
--找到本地文件tnsnames.ora（文件位置为Oracle安装目录*\network\admin下），新增远程服务如：
--OADB=
--  (DESCRIPTION =
--    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.254.41.52)(PORT = 1521))
--    (CONNECT_DATA =
--      (SERVER = DEDICATED)
--      (SERVICE_NAME = oadb)
--    )
 
 
 
 --建立数据库链接服务器
EXEC sp_addlinkedserver
@server =N'OracleEcology', --要创建的链接服务器别名
@srvproduct=N'Oracle', --产品名称
@provider=N'OraOLEDB.Oracle', --OLE DB 驱动名称
@datasrc=N'oadb' --数据源oracle"ora10g"network"admin"tnsnames.ora查看

EXEC sp_addlinkedsrvlogin
 'OracleEcology', --已建立的链接服务器名
'false', -- 固定 */ 
NULL, --为每个登陆SQL SERVER的用户使用此链接服务器,则写用户名*/
'ecology', --帐号(oracle)
'ecology' --密码

SELECT * FROM openquery(OracleEcology,'SELECT * FROM hrmresource')

exec sp_serveroption 'OraclePolice','rpc out','true' 
exec sp_serveroption 'OraclePolice','rpc','true' 
--这两个是打开rpc,rpc out的，默认为False,打开后可以支持远程更改分布式事务。（如有分布式事务操作必须要设置）


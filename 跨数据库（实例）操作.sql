---服务器实例内查询
select a.lastname,b.departmentname from ecology.dbo.HrmResource a
left join ecology8.dbo.HrmDepartment b
on a.departmentid=b.id


----------------跨服务器实例查询--------------------
----------------------------------------------------
---临时操作(1)
--------------
--select * from openrowset('SQLOLEDB', 'sql服务器名（地址）'; '用户名'; '密码', 数据库名.dbo.表名)
select * from openrowset('SQLOLEDB', '192.168.19.203'; 'sa'; 'Ytx@zjb13f', ecology.dbo.Hrmdepartment)
--导入示例
select * into 表 from openrowset('SQLOLEDB' ,'sql服务器名（地址）';'用户名';'密码' ,数据库名.dbo.表名)

---临时操作(2)
--------------
--下面的示例访问来自某个表的数据，该表在 SQL Server 的另一个实例中。
--SELECT *FROM OPENDATASOURCE('SQLOLEDB','Data Source=ServerName;User ID=MyUID;Password=MyPass').Northwind.dbo.Categories
SELECT * FROM OPENDATASOURCE('SQLOLEDB','Data Source=192.168.19.203;User ID=sa;Password=Ytx@zjb13f').ecology.dbo.hrmdepartment
--下面是个查询的示例，它通过用于 Jet 的 OLE DB 提供程序查询 Excel 电子表格。
--SELECT *FROM OpenDataSource( 'Microsoft.Jet.OLEDB.4.0','Data Source="c:Financeaccount.xls";User ID=Admin;Password=;Extended properties=Excel 5.0')...xactions


----创建链接服务器-------------------------------
--在跨库查询时需要启用Ad Hoc Distributed Queries---默认已开，不用执行以下语句
--启用Ad Hoc Distributed Queries：
exec sp_configure 'show advanced options',1
reconfigure
exec sp_configure 'Ad Hoc Distributed Queries',1
reconfigure
--使用完成后，关闭Ad Hoc Distributed Queries：
--exec sp_configure 'Ad Hoc Distributed Queries',0
--reconfigure
--exec sp_configure 'show advanced options',0
--reconfigure 




--exec sp_addlinkedserver   'srv_lnk', '', 'SQLOLEDB','远程服务器名或ip地址'
exec sp_addlinkedserver   'srv_lnk', '', 'SQLOLEDB','192.168.19.203'
--exec sp_addlinkedsrvlogin 'srv_lnk','false',null,'用户名','密码'
exec sp_addlinkedsrvlogin 'srv_lnk','false',null,'sa','Ytx@zjb13f'

--go
--查询示例
--select * from srv_lnk.数据库名.dbo.表名
select * from srv_lnk.ecology.dbo.hrmresource

--导入示例
--select * into 表 from srv_lnk.数据库名.dbo.表名

--以后不再使用时删除链接服务器
--exec sp_dropserver 'srv_lnk','droplogins'
exec sp_dropserver 'srv_lnk','droplogins'



select * from openquery（srv_lnk,'select * from hrmresource'）


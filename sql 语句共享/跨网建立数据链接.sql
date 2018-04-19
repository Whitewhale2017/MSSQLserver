exec sp_addlinkedserver   'srv_lnk', '', 'SQLOLEDB','192.168.19.46'
--exec sp_addlinkedsrvlogin 'srv_lnk','false',null,'用户名','密码'
exec sp_addlinkedsrvlogin 'srv_lnk','false',null,'sa','ytx@12345'


exec sp_addlinkedserver   'srv_lnk', '', 'SQLOLEDB','192.168.150.245'
--exec sp_addlinkedsrvlogin 'srv_lnk','false',null,'用户名','密码'
exec sp_addlinkedsrvlogin 'srv_lnk','false',null,'sa','Ytx@123456'


USE [master]
GO

/****** Object:  LinkedServer [srv_lnk]    Script Date: 2018/1/5 10:21:44 ******/
EXEC master.dbo.sp_dropserver @server=N'srv_lnk', @droplogins='droplogins'
GO
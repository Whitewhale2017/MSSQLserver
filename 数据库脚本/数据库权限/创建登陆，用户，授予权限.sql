--创建读写，更新删除，执行存储过程的登录账户
exec sp_addlogin 'php_user','User$2014','ecology'
go
--创建数据库用户
exec sp_adduser 'php_user','php_user'
go
--将读的权限赋予用户
exec sp_addrolemember 'db_datareader','php_user'
go
--将写，删除，更新的权限授予账户
exec sp_addrolemember 'db_datawriter','php_user'
go
--赋予定义权限
exec sp_addrolemember 'db_ddladmin','php_user'
go
--赋予账户dbo架构下执行的权限
grant execute on schema :: dbo to php_user
go

--创建只读账户
exec sp_addlogin 'oa_reader','hofan123','ecology'
go
--创建数据库用户
exec sp_adduser 'oa_reader','oa_reader'
go
--将读的权限赋予用户
exec sp_addrolemember 'db_datareader','oa_reader'
go

--授予账户使用SQL Profiler的权限
use master
go
exec sp_addlogin 'oa_trace','Trace$123','master'
go
exec sp_adduser 'oa_trace','oa_trace'
go
grant alter trace to oa_trace
go

--赋予账户某个表的查询权限
grant select on GetMulProccessSql to oa_trace
go
--赋予数据库所有者权限
exec sp_addrolemember 'db_owner','php_user'
go
--授予账户对某个表的查询权限
GRANT SELECT ON [oa_user].[formtable_main_export] TO [read_export]
GO
--赋予账户对表值函数定义权限
use [ecology]
GO
GRANT VIEW DEFINITION ON [dbo].[fun_split] TO [read_export]
GO
--赋予账户对表值函数修改权限
use [ecology]
GO
GRANT ALTER ON [dbo].[fun_split] TO [read_export]
GO
--赋予账户对表值函数接管所有权限
use [ecology]
GO
GRANT TAKE OWNERSHIP ON [dbo].[fun_split] TO [read_export]
GO
--赋予账户对表值函数控制权限
use [ecology]
GO
GRANT CONTROL ON [dbo].[fun_split] TO [read_export]
GO
--赋予账户对表值函数查看权限
use [ecology]
GO
GRANT SELECT ON [dbo].[fun_split] TO [read_export]
GO
--赋予账户对表值函数引用权限
use [ecology]
GO
GRANT REFERENCES ON [dbo].[fun_split] TO [read_export]
GO
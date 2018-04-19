--数据库出现孤立用户时
--孤立用户是指只用用户名没有登录名的用户（只存在于某个数据库》安全性》用户》节点下）。


--获取当前数据库架构所有者
select * from sys.schemas
GO
--通过孤立用户名获取principal_id
SELECT DATABASE_PRINCIPAL_ID('DEV-LILING\Repplication');
GO
--把孤立用户所拥有的架构赋予另一个用户
--实例为把test1的架构db_datareader赋予给dbo
ALTER AUTHORIZATION ON SCHEMA::db_datareader TO dbo
GO
--删除孤立用户
exec sp_dropuser 'test1'
GO

--将数据库的所有者架构赋予DEV-LILING\Repplication
ALTER AUTHORIZATION ON SCHEMA::db_datareader TO [DEV-LILING\Repplication]
GO
--将数据库的[DEV-LILING\Repplication]架构赋予dbo
ALTER AUTHORIZATION ON SCHEMA::[DEV-LILING\Repplication] TO dbo
go
--删除架构
drop schema [DEV-LILING\Repplication]
go
--将数据库的所有者赋予DEV-LILING\Repplication
EXEC sp_changedbowner [DEV-LILING\Repplication]
GO

/*
----------------------------实验场景-------------------------------
1、使用windows账户([Hofan-sz\liling])登陆服务器后，建立一个数据库，把数据库的所有者赋予给这个用户
2、在服务器级别删除windows账户的登录权限，使得数据库中的dbo用户孤立
*/

/*
----------------------------准备阶段-------------------------------
1、创建一个新的windows账户([DEV-LILING\Repplication])，加入管理员组
2、使用sa登陆SQLSERVER，在服务器级别的安全节点下的登录名节点下加入新账户，并使其服务器角色为sysadmin
*/

/*
----------------------------实际操作-------------------------------
选择数据库》安全性》用户 ，选择dbo,右键属性可以看到dbo的所有者为最初的windows账户
*/
--将用户[DEV-LILING\Repplication]数据库的默认架构
ALTER USER [DEV-LILING\Repplication] WITH DEFAULT_SCHEMA=[dbo]
GO
--将用户dbo的所有架构赋予给DEV-LILING\Repplication
ALTER AUTHORIZATION ON SCHEMA::db_datareader TO [DEV-LILING\Repplication]
GO
ALTER AUTHORIZATION ON SCHEMA::db_owner TO [DEV-LILING\Repplication]
GO
--再将用户的所有架构赋予给dbo
ALTER AUTHORIZATION ON SCHEMA::db_datareader TO dbo
GO
ALTER AUTHORIZATION ON SCHEMA::db_owner TO dbo
GO
--如果用户存在数据库角色，需要删除角色
exec sp_droprolemember 'db_datareader','[Hofan-sz\liling]'
go
--删除用户DEV-LILING\Repplication
exec sp_dropuser 'DEV-LILING\Repplication'
go
--将数据库的所有者赋予DEV-LILING\Repplication
EXEC sp_changedbowner [DEV-LILING\Repplication]
GO
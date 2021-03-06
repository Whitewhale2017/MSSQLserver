/****** Script for SelectTopNRows command from SSMS  ******/
--配置：已复制的事务不保存
exec sp_changepublication @publication='ToDELATED_01',@property='allow_anonymous', @value='FALSE'
exec sp_changepublication @publication='ToDELATED_01',@property='immediate_sync', @value='FALSE'
exec sp_changepublication @publication='ToDELAYED',@property='allow_anonymous', @value='FALSE' 
exec sp_changepublication @publication='ToDELAYED',@property='immediate_sync', @value='FALSE'
exec sp_changepublication @publication='ProductPropertyTransaction',@property='allow_anonymous', @value='FALSE' 
exec sp_changepublication @publication='ProductPropertyTransaction',@property='immediate_sync', @value='FALSE'
exec sp_changepublication @publication='ProductBaseInfoTransaction',@property='allow_anonymous', @value='FALSE' 
exec sp_changepublication @publication='ProductBaseInfoTransaction',@property='immediate_sync', @value='FALSE'

exec sp_changepublication @publication='AmazonProductDeliveryFee_To_Order',@property='allow_anonymous', @value='FALSE'
exec sp_changepublication @publication='AmazonProductDeliveryFee_To_Order',@property='immediate_sync', @value='FALSE'

--查看复制命令日志记录
SELECT TOP 10 * FROM [distribution].[dbo].[MSrepl_commands] WITH (NOLOCK)
SELECT TOP 100 * FROM [distribution].[dbo].[MSrepl_commands] WITH (NOLOCK)
--查看复制事务日志记录
SELECT TOP 10 *  FROM [distribution].dbo.MSrepl_transactions WITH (NOLOCK)
SELECT TOP 100 *  FROM [distribution].dbo.MSrepl_transactions WITH (NOLOCK)
/*
	场景：
	代理删除历史记录作业执行成功，，但在MSrepl_commands，MSrepl_transactions表记录根本没有删除，
	会造成distribution过度膨胀，只有通过手动删除，或者建立代理作业进行删除。
	MSrepl_commands，MSrepl_transactions表删除的比例为2:1，
	下面是每次删除100W和50W记录
*/
use msdb
go
DELETE TOP (1000000) FROM dbo.MSrepl_commands
DELETE TOP (500000) FROM dbo.MSrepl_transactions
GO

--建立代理计划,定时删除历史日志，步骤执行代码：
declare @c int
declare @t int
select @c=count(*) from msdb.dbo.MSrepl_commands with(nolock)
select @t=count(*) from msdb.dbo.MSrepl_transactions with(nolock)
set @c=@c-1000000
set @t=@t-500000
declare @sql varchar(max)
set @sql=N'DELETE TOP ('+convert(varchar(10),@c)+N') FROM msdb.dbo.MSrepl_commands'
exec sp_sqlexec @sql
set @sql=N'DELETE TOP ('+convert(varchar(10),@t)+N') FROM msdb.dbo.MSrepl_transactions'
exec sp_sqlexec @sql
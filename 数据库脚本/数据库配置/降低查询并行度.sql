--开启配置
sp_configure 'show advanced options', 1;

GO

RECONFIGURE WITH OVERRIDE;

GO
--为服务器限制最大并行查询用到6颗CPU，当前服务器为24核CPU
sp_configure 'max degree of parallelism', 6;--假如是8个(核)cpu

GO
RECONFIGURE WITH OVERRIDE;

GO
--当查询分析器预估查询超过10秒则启动并行查询，其中5秒为系统默认
sp_configure 'cost threshold for parallelism', 10;--将此时间增加

GO

RECONFIGURE WITH OVERRIDE;

GO
--关闭配置
sp_configure 'show advanced options', 0;

GO
RECONFIGURE WITH OVERRIDE;

GO


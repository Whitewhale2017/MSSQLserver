SELECT CONVERT(DATE,[CreateTime]) AS '时间',
      ROUND(avg([PhysicalDisk\Avg. Disk Read Queue Length]),2) as '平均读取队列'
      ,ROUND(max([PhysicalDisk\Avg. Disk Read Queue Length]),2) as '最大读取队列'
      ,ROUND(AVG([PhysicalDisk\Avg. Disk Write Queue Length]),2) as '平均写入队列'
      ,ROUND(max([PhysicalDisk\Avg. Disk Write Queue Length]),2) as '最大写入队列'
      ,ROUND(avg([Processor\% Processor Time]),2) as '平均CPU占用率'
      ,ROUND(max([Processor\% Processor Time]),2) as '最大CPU占用率'
      ,ROUND(AVG([SQLServer:Buffer Manager\Buffer cache hit ratio]),2) as '平均缓存命中率'
      ,ROUND(min([SQLServer:Buffer Manager\Buffer cache hit ratio]),2) as '最小缓存命中率'
      ,ROUND(max([SQLServer:Buffer Manager\Buffer cache hit ratio]),2) as '最大缓存命中率'
      ,ROUND(avg([SQLServer:Buffer Manager\Page life expectancy]),2) as '平均页面生存周期'
      ,ROUND(min([SQLServer:Buffer Manager\Page life expectancy]),2) as '最小页面生存周期'
      ,ROUND(max([SQLServer:Buffer Manager\Page life expectancy]),2) as '最大页面生存周期'
      ,ROUND(avg([SQLSERVER:General Statistics\User Connections]),2) as '平均连接数'
      ,ROUND(max([SQLSERVER:General Statistics\User Connections]),2) as '最大连接数'
      ,ROUND(avg([System\Context Switches/sec]),2) as '平均上下文切换次数'
      ,ROUND(max([System\Context Switches/sec]),2) as '最大上下文切换次数'
      ,ROUND(AVG([System\Processor Queue Length]),2) as '平均CPU请求队列'
      ,ROUND(max([System\Processor Queue Length]),2) as '最大CPU请求队列'
  FROM [PerfMonBaseLine].[dbo].PerfMonDataDetailInfo
  where IPAddress='192.168.1.19'
  GROUP BY CONVERT(DATE,[CreateTime])
  order by  CONVERT(DATE,[CreateTime])
  
  select * from #temp

select SUM(case when [时间]='2014-07-08' then [平均读取队列] end) as '平均读取队列'
from #temp


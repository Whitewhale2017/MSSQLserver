SELECT CONVERT(DATE,[CreateTime]) AS 'ʱ��',
      ROUND(avg([PhysicalDisk\Avg. Disk Read Queue Length]),2) as 'ƽ����ȡ����'
      ,ROUND(max([PhysicalDisk\Avg. Disk Read Queue Length]),2) as '����ȡ����'
      ,ROUND(AVG([PhysicalDisk\Avg. Disk Write Queue Length]),2) as 'ƽ��д�����'
      ,ROUND(max([PhysicalDisk\Avg. Disk Write Queue Length]),2) as '���д�����'
      ,ROUND(avg([Processor\% Processor Time]),2) as 'ƽ��CPUռ����'
      ,ROUND(max([Processor\% Processor Time]),2) as '���CPUռ����'
      ,ROUND(AVG([SQLServer:Buffer Manager\Buffer cache hit ratio]),2) as 'ƽ������������'
      ,ROUND(min([SQLServer:Buffer Manager\Buffer cache hit ratio]),2) as '��С����������'
      ,ROUND(max([SQLServer:Buffer Manager\Buffer cache hit ratio]),2) as '��󻺴�������'
      ,ROUND(avg([SQLServer:Buffer Manager\Page life expectancy]),2) as 'ƽ��ҳ����������'
      ,ROUND(min([SQLServer:Buffer Manager\Page life expectancy]),2) as '��Сҳ����������'
      ,ROUND(max([SQLServer:Buffer Manager\Page life expectancy]),2) as '���ҳ����������'
      ,ROUND(avg([SQLSERVER:General Statistics\User Connections]),2) as 'ƽ��������'
      ,ROUND(max([SQLSERVER:General Statistics\User Connections]),2) as '���������'
      ,ROUND(avg([System\Context Switches/sec]),2) as 'ƽ���������л�����'
      ,ROUND(max([System\Context Switches/sec]),2) as '����������л�����'
      ,ROUND(AVG([System\Processor Queue Length]),2) as 'ƽ��CPU�������'
      ,ROUND(max([System\Processor Queue Length]),2) as '���CPU�������'
  FROM [PerfMonBaseLine].[dbo].PerfMonDataDetailInfo
  where IPAddress='192.168.1.19'
  GROUP BY CONVERT(DATE,[CreateTime])
  order by  CONVERT(DATE,[CreateTime])
  
  select * from #temp

select SUM(case when [ʱ��]='2014-07-08' then [ƽ����ȡ����] end) as 'ƽ����ȡ����'
from #temp


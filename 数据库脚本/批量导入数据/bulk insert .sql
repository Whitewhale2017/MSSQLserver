--使用bulk insert 批量导入数据
bulk insert TestDB.[dbo].[1] from 'E:\Perfmon_Data_Ad\54.csv' with (fieldterminator=',',FIRSTROW =2)
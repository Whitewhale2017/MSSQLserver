
SELECT 
name ,
max(case [date_time] when '2014-06-03' then [size(MB)] else 0 end)  ,
max(case [date_time] when '2014-06-04' then [size(MB)] else 0 end)  ,
max(case [date_time] when '2014-06-05' then [size(MB)] else 0 end)  
from [TestDB].[dbo].[database_file_growth] group by name
order by name

SELECT [name], [2014-06-03] as '2014-06-03 Size(MB)',[2014-06-04] as '2014-06-04 Size(MB)',[2014-06-05] as '2014-06-05 Size(MB)' 
FROM [TestDB].[dbo].[database_file_growth] AS A
PIVOT
(
	MAX([size(MB)]) FOR [date_time] IN ([2014-06-03],[2014-06-04],[2014-06-05])
) AS P
order by [name]
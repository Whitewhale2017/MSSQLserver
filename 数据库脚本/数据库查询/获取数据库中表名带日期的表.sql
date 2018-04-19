select sche.name +N'.'+obj.name as fullname,SUM(pa.rows)/(select COUNT(*) from sys.indexes as i where i.[object_id]=obj.[object_id]) AS sumrows,obj.modify_date 
from sys.objects obj
join sys.schemas as sche on obj.[schema_id] =sche.[schema_id] 
join sys.partitions as pa on pa.[object_id] =obj.[object_id] 
where obj.type_desc='USER_TABLE' 
and obj.is_ms_shipped=0
and obj.name like '%[0-9][0-9][0-9][0-9]%'
group by sche.name +N'.'+obj.name,obj.modify_date,obj.[object_id]
order by sumrows desc




SELECT OBJECT_NAME(a.[object_id]) as tablename,
a.name as indexname ,b.user_lookups,b.user_scans,b.user_seeks 
FROM sys.indexes as a 
join sys.dm_db_index_usage_stats as b on a.index_id=b.index_id and a.[object_id] =b.[object_id] 
where database_id=DB_ID('HofanDW_DW')
order by b.user_lookups desc



--查询表的索引丢失情况
select OBJECT_NAME([object_id]) as tbname,equality_columns, 
included_columns,inequality_columns 
,statement
from sys.dm_db_missing_index_details where database_id=DB_ID('CSOS_NEW_2')
order by statement



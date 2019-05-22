select  (select selectname from workflow_SelectItem where fieldid=12891 and selectvalue=d.fkgs) as fkgs_name,d.*
from formtable_main_206_dt1 d

select * from formtable_main_206_dt1

select cast(cwkj as varchar) from formtable_main_206_dt1 where fkgs in (0,1,2)

declare @cwkjhz varchar(100)
set @cwkjhz=(select cwkj from formtable_main_206_dt1 where fkgs in (0,1,2))
select @cwkjhz

use ecology
go
if exists(select * from sysobjects where name='str_union') drop function dbo.str_union
go
create function dbo.str_union(@col varchar(100)) 
returns varchar(1000)  
as  
begin  
  declare @str varchar(1000)  
  select @str = isnull(@str + ',' , '') + cast(@col as varchar) from formtable_main_206_dt1
  return @str  
end  

select * from formtable_main_206_dt1
SELECT STUFF((SELECT ','+ cast(cwkj as varchar) FROM formtable_main_206_dt1 FOR XML PATH('')),1,1,'') --ºÏ²¢×Ö·û´®



SELECT ',' +workcode FROM HrmResource FOR XML PATH('')

SELECT workcode FROM HrmResource FOR XML PATH('')

SELECT STUFF((SELECT ','+ workcode FROM dbo.HrmResource FOR XML PATH('')),1,1,'') 

select id,lastname from hrmresource where id in (select ('9,3,46'))

select ('9,3,46')

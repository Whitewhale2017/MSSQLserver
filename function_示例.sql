--select count(*) from sysobjects where id = object_id('数据库名.Owner.表名/函数名/进程名等')判断对象是否存在
--标量值函数
use ecology
go
if exists(select * from sysobjects where name='ecology.dbo.WorkYearWage') drop function dbo.WorkYearWage
go
create function WorkYearWage(@hiredate datetime,@today datetime,@per_wage money)
returns money
as 
begin
    declare @WorkYearWage money
	set @WorkYearWage=(year(@today)-year(@hiredate))*@per_wage
	return (@WorkYearWage)
end
go
select dbo.WorkYearWage(datefield1,getdate(),8000) as work_year_wage,datefield1
from HrmResource

go
drop function dbo.WorkYearWage

--表值函数,中间不需要begin和end
use ecology
go
if exists(select count(*) from sysobjects where id='ecology.dbo.Desc_empnianjia') drop function dbo.Desc_empnianjia
go
create function Desc_empnianjia(@njhours int)
returns table
as
   return (select * from empnianjia
           where njhours<=@njhours 
   )
go 
select * from Desc_empnianjia(40) 

--聚合函数
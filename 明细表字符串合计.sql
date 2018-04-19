select * from uf_formtable_rwtz

select mainid,dbo.GetDistinct(right(fkr,len(fkr)-1))as fkrhj
from
(
select mainid,dbo.f_zhifuchuanheji(mainid) as fkr 
from uf_formtable_rwtz_dt2 group by mainid
) t

create function f_zhifuchuanheji(@mainid int)
returns varchar(200)
as
begin
declare @res varchar(200)
set @res=(select ','+cast(fkr as varchar) from uf_formtable_rwtz_dt2 where mainid=@mainid for xml path(''))
return @res
end


alter function f_cwcnhz(@mainid int)
returns varchar(1000)
as
begin
declare @res varchar(1000),@temp varchar(1000)
set @temp=(select ','+cast(cwcn as varchar) from formtable_main_295_dt1 where mainid=@mainid for xml path(''))
set @res=dbo.GetDistinct(right(@temp,len(@temp)-1))
return @res
end




--declare @mid int
select ','+cast(fkr as varchar) from uf_formtable_rwtz_dt2 for xml path('')

declare cur_mainid cursor scroll for
(select mainid from uf_formtable_rwtz_dt2 group by mainid)
open cur_mainid
declare @mainid int
fetch next from cur_mainid into @mainid
while @@FETCH_STATUS=0
begin
select SUBSTRING(fkr,2,len(fkr)) as fkr,maind from
(select (
select ','+cast(fkr as varchar) from uf_formtable_rwtz_dt2 where mainid=@mainid for xml path('')) as fkr,@mainid as maind) t
fetch next from cur_mainid into @mainid
end
close cur_mainid
deallocate cur_mainid


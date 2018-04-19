select dpcsfcg,* from formtable_main_62

update formtable_main_62 set dpcsfcg=null

alter proc prc_dpcsfcg(@rqid varchar(30))
as
begin 
--declare @rqid varchar(20)
if exists(select b.ysxj from formtable_main_62 a,formtable_main_62_dt1 b where a.id=b.mainid and requestId=@rqid)
update formtable_main_62 set dpcsfcg=(case when dpc>0 then 0 else 1 end) 
from 
(select mainid,sum(case when ysxj>10000 then 1 else 0 end) as dpc  from formtable_main_62_dt1 
group by mainid
) t
where formtable_main_62.id=t.mainid and requestid=@rqid
else
update formtable_main_62 set dpcsfcg=1 where requestId=@rqid
end


select t.dpc,formtable_main_62.* from formtable_main_62
left join 
(select mainid,sum(case when ysxj>10000 then 1 else 0 end) as dpc  from formtable_main_62_dt1 
group by mainid
) t
on formtable_main_62.id=t.mainid

if exists(select * from  formtable_main_62_dt1 where mainid=19
) 
select 1

declare cur_temp cursor scroll
for (select id,requestId from formtable_main_62)
open cur_temp
declare @id int
declare @rid varchar(20)
fetch next from cur_temp into @id,@rid
while @@FETCH_STATUS=0
 begin
 exec prc_dpcsfcg @rid
 fetch next from cur_temp into @id,@rid
 end
close cur_temp
deallocate cur_temp


 

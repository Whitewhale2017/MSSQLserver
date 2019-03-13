select ZLC,* from formtable_main_352 where ZLC in (select requestId from formtable_main_353) --‘º∂®

select c.id as zlcid,b.ZLC,b.requestId,a.* from formtable_main_352_dt1 a
left join  formtable_main_352 b
on a.mainid=b.id
left join formtable_main_353 C
on b.ZLC=c.requestId
where mainid in (34,35,36,37,38)

--select * from formtable_main_353 --∆¿…Û

select * from formtable_main_353_dt1
delete from formtable_main_353_dt1 where mainid='34'


insert into formtable_main_353_dt1(mainid,jxkhzb,qz,jxmbzjpjfs) select t.zlcid,t.jxkhzb,t.qz,t.jxmbzjpjfs1 
from (
select c.id as zlcid,b.ZLC,b.requestId,a.* from formtable_main_352_dt1 a
left join  formtable_main_352 b
on a.mainid=b.id
left join formtable_main_353 C
on b.ZLC=c.requestId
where mainid in (38)
) t


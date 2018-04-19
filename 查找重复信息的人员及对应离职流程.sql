create view view_cfxm
as
select id,a.lastname,a.birthday from HrmResource a 
where a.lastname in(
	select lastname from Hrmresource 
	group by lastname
	having count(lastname)>1
	) and a.lastname in (
			select ( select lastname from hrmresource where id=xm) as xm from formtable_main_104
			union
			select (select lastname from hrmresource where id=xm) as xm from formtable_main_219
			union
			select (select lastname from hrmresource where id=xm) as xm from formtable_main_148_dt1
) and a.lastname in (select lastname from HrmResource where lastname in(
select lastname from Hrmresource 
group by lastname
having count(lastname)>1
) and lastname in (
        select ( select lastname from hrmresource where id=xm) as xm from formtable_main_104
        union
		select (select lastname from hrmresource where id=xm) as xm from formtable_main_219
		union
        select (select lastname from hrmresource where id=xm) as xm from formtable_main_148_dt1
) group by lastname,birthday having count(1) > 1 )

and a.birthday in(
select birthday from HrmResource where lastname in(
select lastname from Hrmresource 
group by lastname
having count(lastname)>1
) and lastname in (
        select ( select lastname from hrmresource where id=xm) as xm from formtable_main_104
        union
		select (select lastname from hrmresource where id=xm) as xm from formtable_main_219
		union
        select (select lastname from hrmresource where id=xm) as xm from formtable_main_148_dt1
) group by lastname,birthday having count(1) > 1
)
--order by a.lastname


select * from view_cfxm order by lastname





create view view_lzlc
as
select requestId,( select lastname from hrmresource where id=xm) as xm,xm as id from formtable_main_104
        union
select requestId,(select lastname from hrmresource where id=xm) as xm,xm as id from formtable_main_219
		union
select (select requestId from formtable_main_148 where id=mainid) as requestid,
       (select lastname from hrmresource where id=xm) as xm,xm as id 
from formtable_main_148_dt1 where xm is not null 

drop view  view_lzlc
select * from view_lzlc

select *,(select requestname from workflow_requestbase where requestid=view_lzlc.requestid) as requestname from view_lzlc where id in(
select id from view_cfxm)
order by xm



select requestname from workflow_requestbase where requestid='50227'
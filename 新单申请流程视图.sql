create view view_xdsqlc 
as 
select a.requestId,(select requestname from workflow_requestbase where requestid=a.requestId) as lcm,
(select lastname from hrmresource where sqr=id) as sqr,dbo.f_gsqc(sssyb) as syb,
dbo.f_bmqc(ssbm) as bm,a.tbrq,'二次开发' as xdsqlx,b.cus_id,b.jyzh,b.khxm,b.jhzb,b.jhtg,
(select selectname from workflow_SelectItem where fieldid='16141' and selectvalue=b.xdgsn) as xdgsn,
(select selectname from workflow_SelectItem where fieldid='16142' and selectvalue=b.xdgsy) as xdgsy,
null as sqhsjz,null as sqyy,
null as bblzrq,null as bblzsj,null as bblzsjm,
case when c.currentnodetype=3 then '归档' else '审批中' end as 'sjlx'
from formtable_main_289 a
left join formtable_main_289_dt1 b
on a.id=b.mainid
left join workflow_requestbase c
on a.requestId=c.requestid
union all
select a.requestId,(select requestname from workflow_requestbase where requestid=a.requestId) as lcm,
(select lastname from hrmresource where sqr=id) as sqr,dbo.f_gsqc(sssyb) as syb,
dbo.f_bmqc(ssbm) as bm,a.tbrq,'特殊新单申请（机制内容以外）' as xdsqlx,b.cus_id,b.jyzh,b.khxm,b.jhzb,b.jhtg,
(select selectname from workflow_SelectItem where fieldid='16141' and selectvalue=b.xdgsn) as xdgsn,
(select selectname from workflow_SelectItem where fieldid='16142' and selectvalue=b.xdgsy) as xdgsy,
b.sqhsjz,b.sqyy,
null as bblzrq,null as bblzsj,null as bblzsjm,
case when c.currentnodetype=3 then '归档' else '审批中' end as 'sjlx'
from formtable_main_290 a
left join formtable_main_290_dt1 b
on a.id=b.mainid
left join workflow_requestbase c
on a.requestId=c.requestid
union all
select a.requestId,(select requestname from workflow_requestbase where requestid=a.requestId) as lcm,
(select lastname from hrmresource where sqr=id) as sqr,dbo.f_gsqc(sssyb) as syb,
dbo.f_bmqc(ssbm) as bm,a.tbrq,'符合机制规则，提交核算报备' as xdsqlx,b.cus_id,b.jyzh,b.khxm,null as jhzb,b.jhtg,
(select selectname from workflow_SelectItem where fieldid='16141' and selectvalue=b.xdgsn) as xdgsn,
(select selectname from workflow_SelectItem where fieldid='16142' and selectvalue=b.xdgsy) as xdgsy,
null as sqhsjz,null as sqyy,
b.bblzrq,b.bblzsj,b.bblzsjm,
case when c.currentnodetype=3 then '归档' else '审批中' end as 'sjlx'
from formtable_main_291 a
left join formtable_main_291_dt1 b
on a.id=b.mainid
left join workflow_requestbase c
on a.requestId=c.requestid

select * from view_xdsqlc

select * from formtable_main_289_dt1
select * from formtable_main_290_dt1
select * from formtable_main_291_dt1
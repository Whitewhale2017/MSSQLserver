select * from (
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
 from formtable_main_179 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
 from formtable_main_166 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_177 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_170 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_171 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_181 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_175 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_180 f
) t
where  t.HTBH like '%3031'

create view temp_htbh
as 
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
 from formtable_main_179 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
 from formtable_main_166 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_177 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_170 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_171 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_181 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_175 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_180 f


create view temp_htxx
as 
select htbh,requestId,htlb,htlx,htjelx,htzje,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
 from formtable_main_179 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
 from formtable_main_166 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_177 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_170 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_171 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_181 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_175 f
union
select htbh,requestId,
(select (select formid from workflow_base where id=r.workflowid) as formid from workflow_requestbase r where requestid=f.requestId) as formid
from formtable_main_180 f


select * from temp_htxx 
order by requestId

drop view temp_htbh

select * from temp_htbh where HTBH like 'ZD%3024'

select  * from temp_htbh where HTBH is null or htbh=''



update formtable_main_171 set htbh='RJGF201508241199' where requestId=34659



update formtable_main_166 set htbh='QZS201603281008' where requestId=75476
update formtable_main_166 set htbh='QZS201603291006' where requestId=73961
update formtable_main_171 set htbh='QZS201603011005' where requestId=69123
update formtable_main_171 set htbh='RJ201603181323' where requestId=76809
update formtable_main_171 set htbh='RJ201603291322' where requestId=77113
update formtable_main_177 set htbh='RJ201603161321' where requestId=77386
update formtable_main_171 set htbh='LJ201603141134' where requestId=77112
update formtable_main_171 set htbh='LJ201603141133' where requestId=77155
update formtable_main_166 set htbh='YD201601140001' where requestId=65475
update formtable_main_171 set htbh='LJ201602251132' where requestId=72352
update formtable_main_171 set htbh='QHSY201602251065' where requestId=73173
update formtable_main_171 set htbh='HYTX201603021125' where requestId=72706
update formtable_main_171 set htbh='LJ201603021131' where requestId=74996
update formtable_main_171 set htbh='QHSYSF201603031041' where requestId=73351
update formtable_main_171 set htbh='LJ201603101130' where requestId=76899
update formtable_main_171 set htbh='LJ201603111129' where requestId=77175
update formtable_main_170 set htbh='LJ201603111128' where requestId=76207

select * from formtable_main_204 where requestId=84627
update formtable_main_204 set lcbh='PX-FW-2016-0003' where requestId=84627
 
 select * from formtable_main_210 where requestId=85066
 update formtable_main_210 set pxbh='PX-FW-2016-0003' where requestId=85066





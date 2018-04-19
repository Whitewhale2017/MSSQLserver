select s.htqszt,
t.htqszt,count(1) as 'num' 
from
(select requestId,htmc,htbh,htqszt,tbrq from formtable_main_2
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_5
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_17
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_18
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_19
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_20
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_21
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_22 
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_144 
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_175
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_152
union all
select requestId,'' as htmc,htbh,htqszt,'' as tbrq from formtable_main_178
union all
select requestId,htmc,htbh,htqszt,tbrq from formtable_main_256
) t
left join uf_formtable_htqszt s
on t.htqszt=s.id
where t.tbrq>='2018-02-24' and t.tbrq<='2018-03-23'
group by t.htqszt,s.htqszt


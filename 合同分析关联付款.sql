create view view_htfk
as
select a.requestId,(select lastname from hrmresource where id=sqe) as 'shenqingren',(case htjelx when '0' then  '无明确总金额' when '1' then '开口合同约定结算条款据实结算'  when '2' then '有明确金额'  when '3' then '免费'end) as htjelx, requestname,a.HTBH,a.htmc,a.TBRQ,(select lastname from hrmresource where id=a.HTJBR) as 'htjbr',(select (select selectname from workflow_SelectItem where fieldid=10540 and selectvalue=gsmc) from formtable_main_167_dt1 where id=a.htssgs) as 'htssgs',
a.htzje,g.selectname,a.gysmc as 'gysmc-sx',i.gysmc as 'gysmc-ll',htssgsqt,h.htssgsmc as 'htssgs1',f.htssgsmc as 'htssgs2',isnull(b.HJJE,0) as zfje,
substring(b.cw_requestid,1,len(b.cw_requestid)-1) as cwrequestid
from( 
SELECT requestId,htjelx,gysmc,gys,HTBH,htmc,TBRQ,HTJBR,htssgs,htzje,htzt,htlx,htssgsqt,htssgsnew,sqe   FROM formtable_main_166 
UNION ALL 
SELECT requestId,htjelx,gyssx as gysmc,gysmc as gys,HTBH,htmc
,TBRQ,HTJBR,htssgs,htzje,htzt,htlx,htssgsqt,htssgsnew,sqe   FROM formtable_main_170
UNION ALL 
SELECT requestId,htjelx,gyssx as gysmc,gysmc as gys,HTBH,htmc,TBRQ,HTJBR,htssgs,htzje,htzt,htlx,htssgsqt,htssgsnew,sqe   FROM formtable_main_171 
UNION ALL 
SELECT requestId,htjelx,gysmc,gys,HTBH,htmc,TBRQ,HTJBR,htssgs,htzje,htzt,htlx,htssgsqt,htssgsnew,sqe   FROM formtable_main_175
UNION ALL
SELECT requestId,htjelx,gysmc,gys,HTBH,htmc,TBRQ,HTJBR,htssgs,htzje,htzt,htlx,htssgsqt,htssgsnew,sqe   FROM formtable_main_177
UNION ALL
SELECT requestId,htjelx,gysmc,gys,HTBH,htmc,TBRQ,HTJBR,htssgs,htzje,htzt,htlx,htssgsqt,htssgsnew,sqe   FROM formtable_main_179
UNION ALL
SELECT requestId,htjelx,gysmc,gys,HTBH,htmc,TBRQ,HTJBR,htssgs,htzje,htzt,htlx,htssgsqt,htssgsnew,sqe   FROM formtable_main_180
UNION ALL
SELECT requestId,htjelx,gysmc,gys,HTBH,htmc,TBRQ,HTJBR,htssgs,htzje,htzt,htlx,htssgsqt,htssgsnew,sqe   FROM formtable_main_181
) a 
left join (
	select 
	(select convert(varchar,t.requestid)+',' from
	(
		select requestId,HTBH,HTFKJE,HJJE from formtable_main_189 
		UNION ALL
		select requestId,HTBH,HTFKJE,HJJE from formtable_main_190
		UNION ALL
		select requestId,HTBH,HTFKJE,HJJE  from formtable_main_78
	) t
	where t.htbh=c.htbh
	for xml path('')) as cw_requestid,HTBH,sum(HJJE) as HJJE from
	(
		select requestId,HTBH,HTFKJE,HJJE from formtable_main_189 
		UNION ALL
		select requestId,HTBH,HTFKJE,HJJE from formtable_main_190
		UNION ALL
		select requestId,HTBH,HTFKJE,HJJE  from formtable_main_78
	) c 
	where c.htbh!=''
	group by c.htbh
)b ON a.HTBH = b.HTBH 
left join formtable_main_216 f on a.htssgsnew = f.id
left join workflow_requestbase d on a.requestId = d.requestid
left join workflow_base e on d.workflowid = e.id 
left join workflow_SelectItem g on a.htlx = g.selectvalue and g.fieldid = '11208'
left join formtable_main_216 h on a.htssgsnew = h.id
left join formtable_main_163 i on a.gys = i.id

select * from view_htfk
drop view view_htfk

select workflowname,formid,replace(('formtable_main_'+convert(varchar,formid)),'-','') as form from workflow_base

select workflowname,formid,'formtable_main_'+substring(convert(varchar,formid),2,LEN(convert(varchar,formid))-1) as formtable 
from workflow_base 

-----------for xml path------------------
select convert(varchar,requestId)+',' from
	(
		select requestId,HTBH,HTFKJE,HJJE from formtable_main_189 
		UNION ALL
		select requestId,HTBH,HTFKJE,HJJE from formtable_main_190
		UNION ALL
		select requestId,HTBH,HTFKJE,HJJE  from formtable_main_78
	) c 
for xml path('')



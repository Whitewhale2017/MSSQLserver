
USE [ecology8]
GO

/****** Object:  View [dbo].[v_htxx_cw]    Script Date: 2018/1/31 10:32:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
ALTER view [dbo].[v_htxx_ht]
as
select requestId,htmc,htbh,htzje,htlx,htjelx,htsxrq,htyxq,htqslx,'formtable_main_2' as 'formtable' from formtable_main_2 --集团管理
union all
select requestId,htmc,htbh,htzje,htlx,htjelx,htsxrq,htyxq,htqslx,'formtable_main_5' as 'formtable' from formtable_main_5 --IT
union all
select requestId,htmc,htbh,htzje,htlx,htjelx,htsxrq,htyxq,htqslx,'formtable_main_17' as 'formtable' from formtable_main_17 --媒体广告
where htlb=0
union all
select requestId,htmc,htbh,htzje,htlx,htjelx,htsxrq,htyxq,htqslx,'formtable_main_18' as 'formtable' from formtable_main_18 --人力资源
union all
select requestId,htmc,htbh,htzje,htlx,htjelx,htsxrq,htyxq,htqslx,'formtable_main_19' as 'formtable' from formtable_main_19 --行政活动
union all
select requestId,htmc,htbh,htzje,htlx,htjelx,htsxrq,htyxq,htqslx,'formtable_main_175' as 'formtable' from formtable_main_175 --财务
union all
select requestId,htmc,htbh,htzje,htlx,htjelx,htsxrq,htyxq,htqslx,'formtable_main_256' as 'formtable' from formtable_main_256 --行政活动



ALTER view [dbo].[v_htxx_cw] ----合同及财务信息集合
as
select t2.requestname,t.*,(case when t1.fkzje is null then 0 else t1.fkzje end) as fkzje,
(t.htzje-(case when t1.fkzje is null then 0 else fkzje end)) as wfkje,
case when t1.fkcs is null or t1.fkcs='' then 0 else t1.fkcs end as fkcs,
case 
when t.htqslx<>2 and htyxq>=CONVERT(varchar(100), GETDATE(), 23) then 0
when t.htqslx<>2 and htyxq<CONVERT(varchar(100), GETDATE(), 23)  then 1
when t.htqslx=2  then 2
end
as 'htzt',
case when t.htbh is not null and dbo.f_glhtcx(t.requestId) is not null and t.htbh<>'' then 0 else 1 end  as 'bqgg',
case when t.htbh is null or t.htbh='' then null else dbo.f_glhtcx(t.requestId) end  as 'xght'
from v_htxx_ht t
inner join workflow_requestbase b
on t.requestId=b.requestid  and b.currentnodetype=3

left join (
 select htbhcx,sum(fkje) as fkzje,count(1) as fkcs from uf_htfkxx
 group by htbhcx
) t1
on t.requestId=t1.htbhcx   ---htbhcx字段值为requestid
left join workflow_requestbase t2
on t.requestId=t2.requestid
GO

select * from [v_htxx_cw] where requestId='50666'


alter function f_glhtcx(@rid varchar(20)) --关联合同查询,合同补签或终止
returns varchar(200)
as
begin
    declare @res varchar(200)
    set @res=(select ','+cast(requestid as varchar(20)) from v_htxx_ht where htbh in (
               select htbh from v_htxx_ht t
               where  htbh in (select htbh from v_htxx_ht where requestId=@rid ) and t.htqslx<>0) and requestId<>@rid for xml path(''))
return right(@res,(len(@res)-1))
end


drop function f_glhtcx

select dbo.f_glhtcx('120280')


select * from v_htxx_ht
where htbh in (
select htbh from v_htxx_ht 
group by htbh
having count(1)>1
) 
order by htbh

 select * from uf_htfkxx
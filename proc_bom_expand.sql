SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER procedure [dbo].[proc_bom_expand]
@matnr varchar(200),@werks varchar(50)='1001',@pno varchar(200)='',@cno varchar(200)=''
as
begin
SET NOCOUNT ON;
declare @level int
declare @endlevel int
set @level=1

if @werks is null begin
   set @werks=(select min(werks) from sap_mast where matnr=@matnr)
end;

drop table if exists #t_mast_stpo;
select a.matnr as pno,b.idnrk as cno,a.werks,cast(b.menge/1000 as numeric(18,5))as menge
into #t_mast_stpo
from sap_mast a
left join 
sap_stpo b
on a.stlnr=b.stlnr;


drop table if exists #bom_expand;
with cte(level,pno,cno,werks,menge,ljsl)
as
(
select 1 as level,pno,cno,werks,menge,cast(menge as numeric(18,5)) as ljsl from #t_mast_stpo
where pno=@matnr and werks=@werks 
union all
select cte.level+1,a.pno,a.cno,a.werks,a.menge,cast((cte.ljsl*a.menge) as numeric(18,5)) as ljsl 
from #t_mast_stpo a
inner join cte
on a.pno=cte.cno
)
select level,pno,cno,werks,menge,ljsl into #bom_expand from cte;

--select level,pno,cno,werks,menge,ljsl from  #bom_expand order by level;


select a.level,a.pno,a.cno,a.werks,a.menge,a.ljsl,@matnr as topno,
b.hwges/b.menge as dj
into #temp_bom_expand
from  #bom_expand a
left join sap_matnrinfo b
on a.cno=b.matnr;

drop table if exists #res_bom_zk;
select a.topno,a.level,a.pno,a.cno,a.werks,a.menge,a.ljsl,a.dj
       ,b.matkl,b.maktx
       ,case when c.wlz is null then 1 else 0 end as cno_zk1
           ,case when e.wlz is null then 1 else 0 end as pno_zk1
           ,case when exists (select top 1 1 from #temp_bom_expand where pno=a.cno) then 0 else 1 end as buttom
           into #res_bom_zk
from #temp_bom_expand a
left join sap_matnrinfo b
on a.cno=b.matnr
left join qtn_wlz c
on b.matkl=c.wlz
left join sap_matnrinfo d
on a.pno=d.matnr
left join qtn_wlz e
on d.matkl=e.wlz;

drop table if exists #res_bom_zk1;
with cte(topno,level,pno,cno,maktx,werks,menge,buttom,ljsl,dj,matkl,cno_zk1,pno_zk1,lj_zk)
as
(
select topno,level,pno,cno,maktx,werks,menge,buttom,ljsl,dj,matkl,cno_zk1,pno_zk1,cno_zk1 as lj_zk from #res_bom_zk
where pno=@matnr
union all
select a.topno,a.level,a.pno,a.cno,a.maktx,a.werks,a.menge,a.buttom,a.ljsl,a.dj,a.matkl,a.cno_zk1,a.pno_zk1,lj_zk*a.cno_zk1 as lj_zk
from #res_bom_zk a
inner join cte
on a.pno=cte.cno
)
select topno,level,pno,cno,maktx,werks,menge,ljsl,dj,matkl,cno_zk1,pno_zk1,lj_zk,buttom into #res_bom_zk1 from cte order by level;

truncate table res_bom_expand;

insert into res_bom_expand(topno,level,pno,cno,maktx,werks,menge,ljsl,dj,matkl,cno_zk1,pno_zk1,lj_zk,buttom,qj,jg)
select a.topno,a.level,a.pno,a.cno,a.maktx,a.werks,a.menge,a.ljsl,a.dj,a.matkl,a.cno_zk1,a.pno_zk1,b.lj_zk,a.buttom,
case when b.lj_zk=0 then 0
     when a.cno_zk1=1 and a.buttom=0 then 0
	 else 1 end as qj,
case when b.lj_zk=0 then 0
     when a.cno_zk1=1 and a.buttom=0 then 0
	 else a.dj*a.ljsl end as jg
from #res_bom_zk1 a
left join #res_bom_zk1 b
on a.pno=b.cno
order by a.level;




if  @pno='' and @cno=''
begin
select topno,level,pno,cno,maktx,werks,menge,ljsl,dj,matkl,cno_zk1,pno_zk1,lj_zk,buttom,qj,jg 
from 
res_bom_expand 
where 1=1 order by level
end;

if @pno<>'' and @cno<>''
begin
  select topno,level,pno,cno,maktx,werks,menge,ljsl,dj,matkl,cno_zk1,pno_zk1,lj_zk,buttom,qj,jg 
  from res_bom_expand 
  where 1=1 and pno like @pno and cno like @cno order by level
end;


if @pno<>'' and @cno=''
begin
  select topno,level,pno,cno,maktx,werks,menge,ljsl,dj,matkl,cno_zk1,pno_zk1,lj_zk,buttom,qj,jg 
  from res_bom_expand 
  where 1=1 and pno like @pno order by level
end;

if @pno='' and @cno<>''
begin
  select topno,level,pno,cno,maktx,werks,menge,ljsl,dj,matkl,cno_zk1,pno_zk1,lj_zk,buttom,qj,jg 
  from res_bom_expand 
  where 1=1 and cno like @cno order by level
end;

end


GO

USE [DataWare]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[proc_bom_expand]
@matnr varchar(200),@werks varchar(50)='1001'
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
select @endlevel=max(level) from  #bom_expand 
select @endlevel

while @level<@endlevel
  begin
  select a.level,a.pno,a.cno,a.werks,a.menge,a.ljsl,t.wlz
  from #bom_expand a
  left join 
  (  select a.matnr,a.matkl,b.wlz
      from sap_matnrinfo a
      inner join qtn_wlz b
      on a.matkl=b.wlz
  ) t
  on a.cno=t.matnr
  where a.level= 1 --@level

    continue;
  end


end
GO

execute [dbo].[proc_bom_expand] '1190000026X002'
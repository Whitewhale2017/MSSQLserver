select gsdm,kcwl
,sum(case when sc<=30 then jg else 0 end) as '30Ìì' 
,sum(case when sc>30 and sc<=60 then jg else 0 end) as '60Ìì' 
,sum(case when sc>60 and sc<=60 then jg else 0 end) as '60Ìì' 
from 
(
select *
,case when kcsl>=0 and jz+cz<=0 then 0
      when kcsl>=0 and jz+cz>0 and jz+cz<kcsl then jz+cz
	  when kcsl>=0 and jz+cz>=kcsl then kcsl
	  else 0
	  end as jg,
	  DATEDIFF(day,guozrq,CONVERT(varchar(100), GETDATE(), 23))  as sc   
from
(
select *,dbo.f_gzqhz(gsdm,kcwl,guozrq) as jz,dbo.f_gzqhf(gsdm,kcwl) as cz
from [dbo].[mtrinfo] 
) t
) t
where kcwl='1100105178'
group by gsdm,kcwl

------------------------------------------------------
select *
,case when kcsl>=0 and jz+cz<=0 then 0
      when kcsl>=0 and jz+cz>0 and jz+cz<kcsl then jz+cz
	  when kcsl>=0 and jz+cz>=kcsl then kcsl
	  else 0
	  end as jg,
	  DATEDIFF(day,guozrq,CONVERT(varchar(100), GETDATE(), 23))  as sc   
from
(
select *,dbo.f_gzqhz(gsdm,kcwl,guozrq) as jz,dbo.f_gzqhf(gsdm,kcwl) as cz
from [dbo].[mtrinfo] 
) t
where  kcwl='1100105178'
order by kcwl

------------------------------------------------------------

alter function f_gzqhz(@gsdm varchar(20),@kcwl varchar(50),@guozrq date)
returns int
as
begin
  declare @res int
  set @res=(select sum(case when kcsl>=0 then kcsl else 0 end) from mtrinfo where gsdm=@gsdm and kcwl=@kcwl and guozrq<=@guozrq)
  return @res
end

---------------------------------------
alter function f_gzqhf(@gsdm varchar(20),@kcwl varchar(50))
returns int
as
begin
  declare @res int
  set @res=(select sum(case when kcsl<0 then kcsl else 0 end) from mtrinfo where gsdm=@gsdm and kcwl=@kcwl)
  return @res
end



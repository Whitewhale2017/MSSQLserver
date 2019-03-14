--CREATE VIEW "SANGREAD"."V_MATRINFO_GZJL" ( "KEYINFO",
--	 "KCWL",
--	 "GSDM",
--	 "KCSL",
--	 "GZRQ" ) AS select
--	 concat(concat(concat(concat(concat(key1,
--	key2),
--	key3),
--	key4),
--	key5),
--	key6) as keyinfo ,
--	MATBF AS kcwl,
--	BUKRS as gsdm,
--	to_int(STOCK_QTY) as kcsl,
--	to_char(BUDAT,
--	'YYYY-MM-DD') as gzrq 
--from SAPABAP1.MATDOC 
--where mandt='800' 
--and MATBF<>''


select * into T_SAP_matinfo from openquery([NEWQAS],'select * from V_MATRINFO_GZJL')
---------------------------------------------------------------

CREATE VIEW V_MATRINFO_GZJL_T 
AS SELECT KEYINFO,KCWL,GSDM,KCSL,GZRQ
from T_SAP_matinfo A 
where exists (select 1 from ( select gsdm,kcwl,sum(kcsl) as js 
		                       from T_SAP_matinfo 
		                       group by gsdm,kcwl ) t 
	where t.js<>0 and A.gsdm=t.gsdm and A.kcwl=t.kcwl)
----------------------------------------------
create view V_MATRINFO_GZJL_T1
as
select  gsdm,kcwl,gzrq
,sum(case when kcsl>=0 then kcsl else 0 end) as drjz
,sum(case when kcsl<0 then kcsl else 0 end) as drcz 
from V_MATRINFO_GZJL_T
group by gsdm,kcwl,gzrq

---------------------------------------------------
drop table ZDY_T_MATRINFO_GZJL_T1


CREATE TABLE [dbo].[ZDY_T_MATRINFO_GZJL_T1](
	[gsdm] [nvarchar](4) NOT NULL,
	[kcwl] [nvarchar](40) NOT NULL,
	[gzrq] [varchar](5000) NULL,
	[drjz] bigint NULL,
	[drcz] bigint NULL
) ON [PRIMARY]

insert into ZDY_T_MATRINFO_GZJL_T1 select * from V_MATRINFO_GZJL_T1

--select count(*) from V_MATRINFO_GZJL_T1
--select count(*) from ZDY_T_MATRINFO_GZJL_T1
-------------------------------------------------
select gsdm,kcwl,gzrq,drjz,drcz,jz as ljjz,cz as ljcz,
case when drjz>=0 and jz+cz<=0 then 0 
when drjz>=0 and jz+cz>0 and jz+cz<drjz then jz+cz 
when drjz>=0 and jz+cz>=drjz then drjz 
else 0 
end as jg, 
DATEDIFF(day,gzrq,'2019-03-14') as sc 
 from (
select gsdm,kcwl,gzrq,drjz,drcz
,(select sum(case when drjz>=0 then drjz else 0 end) from ZDY_T_MATRINFO_GZJL_T1 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl and B.gzrq<=A.gzrq) as jz
,(select sum(case when drcz<0 then drcz else 0 end) from ZDY_T_MATRINFO_GZJL_T1 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl) as cz
from ZDY_T_MATRINFO_GZJL_T1 A
) T
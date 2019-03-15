truncate table material_history_item_log
insert into material_history_item_log select * from openquery([RF],'select * from v_material_history_item_log where createDate<=''2019-03-14 08:00''')

select * into material_history_item_log from openquery([RF],'select * from v_material_history_item_log where createDate<=''2019-03-15 08:00''')


select werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate from [dbo].[material_history_item_log] 
group by werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate
having count(*)>1

select gesme,quantity,verme from [material_history_item_log] where matnr='1100101302' and createDate='2019-03-07 19:29:39.0000000'

select * from [dbo].[stomtr]
------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

select  r.*,(盘平+盘亏+盘盈)/(需盘总量*1.0) as 盘点进度
from 
(
select  工厂,sum(条目) as 需盘总量,sum(case when 盘点结果='盘平' then 条目 else 0 end) as  盘平
,sum(case when 盘点结果='盘亏' then 条目 else 0 end) as  盘亏
,sum(case when 盘点结果='盘盈' then 条目 else 0 end) as  盘盈
,sum(case when 盘点结果='未盘' then 条目 else 0 end) as  未盘
from
(
select t.工厂,t.盘点结果,count(t.盘点结果) as 条目 from 
(
select t.*,case when 库存数量=盘点数量 then '盘平'
                when 库存数量>盘点数量 then '盘亏'
			    when 库存数量<盘点数量 then '盘盈'
			    else '未盘'
			    end as '盘点结果'
from
(
-----------------------------明细------------------------------------------
select A.werks as '工厂',A.lgort as '库存地点',A.lgpla as '仓位',A.matnr as '物料号',A.maktx as '物料描述',A.类  as '仓储类型'
,A.charg as '批次',A.sonum_ex as '特殊库存编码',A.bestq as '库存类型',B.verme as '库存数量',B.quantity as '盘点数量',B.盘点时间
from [dbo].[stomtr] A
left join (

select left(createDate,19) as '盘点时间',werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,verme,quantity
from (
select * from  material_history_item_log A
where createDate=(select max(createDate) from material_history_item_log B where A.werks=B.werks and A.lgort=B.lgort 
and A.lgpla=B.lgpla and A.matnr=B.matnr and A.charg=B.charg and A.sonum_ex=B.sonum_ex and A.bestq=B.bestq)
) t
where createDate>'2019-03-08 00:00:00.0000000'

) B
on A.werks=B.werks and A.lgort=B.lgort 
and A.lgpla=B.lgpla and A.matnr=B.matnr and A.charg=B.charg and A.sonum_ex=B.sonum_ex and A.bestq=B.bestq and A.类=B.lgtyp
-------------------------------------------------------------------------------------------------------------
) t
) t
group by 工厂,盘点结果
) t
group by 工厂
) r
----------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------








select * from 
material_history_item_log 
where (werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate) 
in
(
select werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate 
from material_history_item_log
group by werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate
having count(*)>1
)

and id not in (
select max(id)
from material_history_item_log
group by werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate
having count(*)>1
)





select 工厂,库存地点,仓位,物料号,仓储类型,批次,特殊库存编码,库存类型 
from (
select left(createDate,19) as '盘点时间',werks as '工厂',lgort as '库存地点',lgpla as '仓位',matnr as '物料号',maktx as '物料描述',lgtyp as '仓储类型'
,charg as '批次',sonum_ex as '特殊库存编码',bestq as '库存类型',gesme as '库存数量',quantity as '盘点数量'
from (
select * from  material_history_item_log A
where createDate=(select max(createDate) from material_history_item_log B where A.werks=B.werks and A.lgort=B.lgort 
and A.lgpla=B.lgpla and A.matnr=B.matnr and A.charg=B.charg and A.sonum_ex=B.sonum_ex and A.bestq=B.bestq)
) t
where createDate>'2019-03-08 00:00:00.0000000'
) t
group by 工厂,库存地点,仓位,物料号,仓储类型,批次,特殊库存编码,库存类型
having count(*)>1
       

select *
from (
select left(createDate,19) as '盘点时间',werks as '工厂',lgort as '库存地点',lgpla as '仓位',matnr as '物料号',maktx as '物料描述',lgtyp as '仓储类型'
,charg as '批次',sonum_ex as '特殊库存编码',bestq as '库存类型',gesme as '库存数量',quantity as '盘点数量'
from (
select * from  material_history_item_log A
where createDate=(select max(createDate) from material_history_item_log B where A.werks=B.werks and A.lgort=B.lgort 
and A.lgpla=B.lgpla and A.matnr=B.matnr and A.charg=B.charg and A.sonum_ex=B.sonum_ex and A.bestq=B.bestq)
) t
where createDate>'2019-03-08 00:00:00.0000000'
) t
where 物料号='1100002041' 
select * from PDJL

select * from v_pdjg

alter view v_pdjg
as
select 地点,工厂,库存地点,仓位,物料编码,物料描述,批次,特殊库存编码
,cast(库存数量 as numeric(20,2)) as 库存数量
,cast(盘点数量 as numeric(20,2)) as 盘点数量
,盘点结果
,盘点日期
,盘点时间
from PDJL  a where a.盘点时间 =(
select max(b.盘点时间) 
from PDJL b 
where a.仓位=b.仓位 
and a.地点=b.地点
and a.工厂=b.工厂
and a.物料编码=b.物料编码
and a.批次=b.批次
and a.特殊库存编码=b.特殊库存编码 
and a.库存地点=b.库存地点
)

select * from v_pdjg 
where --盘点数量=0 and 
地点 like '%浦江%'
order by 盘点日期 

select * from v_pdjg 
where --盘点数量=0 and 
地点 like '%嘉善%'
order by 盘点日期 

select 仓位,地点,工厂,物料编码,批次,特殊库存编码,库存地点
 from v_pdjg group by 仓位,地点,工厂,物料编码,批次,特殊库存编码,库存地点 
 having count(1)>1

select 地点,工厂,库存地点,count(1) as 条数
,sum(case when 盘点数量 = 库存数量 then 1 else 0 end) as 盘平
,sum(case when 盘点数量 > 库存数量 then 1 else 0 end) as 盘盈
,sum(case when 盘点数量 < 库存数量 then 1 else 0 end) as 盘亏
,sum(case when 盘点数量 = 0 then 1 else 0 end) as 盘点数量为零
from v_pdjg
group by 地点,工厂,库存地点
order by 地点

select 地点,count(1) as 条数
,sum(case when 盘点数量 = 库存数量 then 1 else 0 end) as 盘平
,sum(case when 盘点数量 > 库存数量 then 1 else 0 end) as 盘盈
,sum(case when 盘点数量 < 库存数量 then 1 else 0 end) as 盘亏
,sum(case when 盘点数量 = 0 then 1 else 0 end) as 盘点数量为零
from v_pdjg
group by 地点
order by 地点

select * from PDJL
select * from CWPDJL where 仓位='23 209 52'
select * from v_pdjg where 特殊库存编码='DA1840355N18010100'

select count(*) from PDJL
select * from CWPDJL 

select t.* 
,case when 差异类别复盘='无差异' and 掌机盘点结果='盘平' then '一致'
      when 差异类别复盘='正差' and 掌机盘点结果='盘盈' then '一致'
	  when 差异类别复盘='负差' and 掌机盘点结果='盘亏' then '一致'
	  when 掌机库存数量 is null or 掌机盘点数量 is null or 掌机盘点结果 is null then  '掌机无数据'
	 else '差异'
  end as 线下与掌机结果
from 
(
select a.地点,a.工厂代码 as 工厂,a.仓库代码 as 仓库,a.仓位,a.物料编码,a.物料名称 as 物料描述,a.批次,a.特殊库存编码
,a.账面数量,a.实盘数量,a.复盘数量
,a.数量差异实盘,a.数量差异复盘
,a.差异类别实盘,a.差异类别复盘
,a.类别 as '仓位类别'
,b.库存数量 as 掌机库存数量,b.盘点数量 as 掌机盘点数量
,b.盘点结果 as 掌机盘点结果
from cwpdjl a
left join v_pdjg b
on a.工厂代码=b.工厂 and a.仓库代码=b.库存地点 and a.仓位=b.仓位 and a.物料编码=b.物料编码 and a.批次=b.批次 and a.特殊库存编码=b.特殊库存编码
) t

select 仓位 from [dbo].[ZJWSJPDJL] where 掌机可盘='是' group by 仓位

select * from [ZJWSJPDJL] where 
仓位='SHSYK2201'

 update [ZJWSJPDJL] set 掌机可盘='否' where 
仓位='SHSYK2201'



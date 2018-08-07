select * from [dbo].[订单列表$] where 订单编号 is null
delete from [dbo].[订单列表$] where 订单编号 is null

select * from [订单列表$] order by 下单时间,用户名


select * from [订单列表$] where 用户名 in (
(select 用户名 from [订单列表$] group by 用户名 having count(1)>1))
order by 用户名
 
 select distinct 下单时间 from [订单列表$] 

 create view v_mrmtje
 as
 select [用户名],sum([实付金额]) as 单日金额汇总,[下单时间] from [dbo].[订单列表$] group by [用户名],[下单时间]

alter view v_jfjcxx
as
select t.*,
(case
     when 累计金额<=5000 then 1 
	 when  累计金额>5000 and 累计金额<=10000 then 1.2 
	 when  累计金额>10000 and 累计金额<=20000 then 2
	  when  累计金额>20000 then 3 end
	 ) as 积分倍率,round(单日金额汇总/100,0) as 积分
from (
select a.*,dbo.f_ljje(a.下单时间,a.用户名) as 累计金额 
from v_mrmtje a
) t


alter function f_ljje(@xdrq varchar(30),@yhm varchar(30))
returns float
as
begin
declare @res float
    set @res=(select (case when sum(单日金额汇总) is null then 0 else sum(单日金额汇总) end) as a from v_mrmtje where [下单时间]<@xdrq and 用户名=@yhm)
return @res
end

select  t.*,t1.姓名 from (
select 用户名,round(sum(积分倍率*积分),0) as 累计积分,sum(单日金额汇总) as 累计金额,
(case when sum(单日金额汇总)<=5000 then '银卡'
      when sum(单日金额汇总)>5000 and sum(单日金额汇总)<=10000 then '金卡'
	  when  sum(单日金额汇总)>10000 and sum(单日金额汇总)<20000 then '铂金卡'
	  when  sum(单日金额汇总)>20000 then '黑卡' end) as 会员等级
from v_jfjcxx group by 用户名) t 
left join (select distinct 用户名,姓名 from [订单列表$]) t1
on t.用户名=t1.用户名



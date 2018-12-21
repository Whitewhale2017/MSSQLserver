

declare @MON int = DATENAME(MONTH,GETDATE())
declare @YEAR int = DATENAME(YEAR,GETDATE())
select @MON,@YEAR
--------------应收账款帐龄 s为正 h为负-------------------
alter function f_jscwzl(@year int,@month int,@beginmon int,@endmon int,@gs varchar(100))
returns float
as    
begin
   declare @res float
   set @res=(select sum(ABS_HSL) from OAView.[dbo].[b_sap_cwsj]
   where (GJAHR=@year) and (MONAT between (@month-@endmon) and (@month-@beginmon)) and (KUNNR=@gs) and (DRCRK='s'))
   return @res
end

create function f_jscwzl2(@year int,@month int,@beginmon int,@endmon int,@gs varchar(100))
returns float
as    
begin
   declare @res float
   set @res=(select sum(ABS_HSL) from OAView.[dbo].[b_sap_cwsj]
   where (GJAHR=@year) and (MONAT between (@month-@endmon) and (@month-@beginmon)) and (KUNNR=@gs) and (DRCRK='h'))
   return @res
end


drop function f_jscwzl

 create view v_sap_cwyszks
 as
 select KUNNR,
isnull(dbo.f_jscwzl(2018,12,1,3,KUNNR),0) as S1,
isnull(dbo.f_jscwzl(2018,12,4,6,KUNNR),0) as S2,
isnull(dbo.f_jscwzl(2018,12,7,9,KUNNR),0) as S3,
isnull(dbo.f_jscwzl(2018,12,10,12,KUNNR),0) as S4,
isnull(0-dbo.f_jscwzl2(2018,12,1,3,KUNNR),0) as y1,
isnull(0-dbo.f_jscwzl2(2018,12,4,6,KUNNR),0) as y2,
isnull(0-dbo.f_jscwzl2(2018,12,7,9,KUNNR),0) as y3,
isnull(0-dbo.f_jscwzl2(2018,12,10,12,KUNNR),0) as y4
from OAView.[dbo].[b_sap_cwsj] 
group by KUNNR

alter view v_sap_cw_yszk_jdjsas
as
select KUNNR,case when (s1+s2+s3+s4+y1+y2+y3+y4)<=0 then 0
				     when (s1+s2+s3+s4+y1+y2+y3+y4)>=s1 then s1
					 when  (s1+s2+s3+s4+y1+y2+y3+y4)<s1 and (s1+s2+s3+s4+y1+y2+y3+y4)>0 then (s1+s2+s3+s4+y1+y2+y3+y4)
					 end
			         as s1,
				case when (s2+s3+s4+y1+y2+y3+y4)<=0 then 0
				     when (s2+s3+s4+y1+y2+y3+y4)>=s2 then s2
					 when  (s2+s3+s4+y1+y2+y3+y4)<s2 and (s2+s3+s4+y1+y2+y3+y4)>0 then (s2+s3+s4+y1+y2+y3+y4)
					 end
			         as s2,
				case when (s3+s4+y1+y2+y3+y4)<=0 then 0
				     when (s3+s4+y1+y2+y3+y4)>=s3 then s3
					 when  (s3+s4+y1+y2+y3+y4)<s3 and (s3+s4+y1+y2+y3+y4)>0 then (s3+s4+y1+y2+y3+y4)
					 end
			         as s3,
				case when (s4+y1+y2+y3+y4)>=0 then (s4+y1+y2+y3+y4) 
                    when  (s4+y1+y2+y3+y4)<0 then 0
					end as s4,
			   case when (y4+s1+s2+s3+s4)<=0 then (y4+s1+s2+s3+s4)
                    when  (y4+s1+s2+s3+s4)>0 then 0
					end as y4,
			   case when (y3+y4+s1+s2+s3+s4)<=y3 then y3
                    when  (y3+y4+s1+s2+s3+s4)>y3 and (y3+y4+s1+s2+s3+s4) <=0 then (y3+y4+s1+s2+s3+s4)
					when  (y3+y4+s1+s2+s3+s4)>0 then 0
					end as y3,
				case when (y2+y3+y4+s1+s2+s3+s4)<=y2 then y2
                    when  (y2+y3+y4+s1+s2+s3+s4)>y2 and (y2+y3+y4+s1+s2+s3+s4) <=0 then (y2+y3+y4+s1+s2+s3+s4)
					when  (y2+y3+y4+s1+s2+s3+s4)>0 then 0
					end as y2,
				case when (y1+y2+y3+y4+s1+s2+s3+s4)<=y1 then y1
                    when  (y1+y2+y3+y4+s1+s2+s3+s4)>y1 and (y1+y2+y3+y4+s1+s2+s3+s4) <=0 then (y1+y2+y3+y4+s1+s2+s3+s4)
					when  (y1+y2+y3+y4+s1+s2+s3+s4)>0 then 0
					end as y1
from v_sap_cwyszks




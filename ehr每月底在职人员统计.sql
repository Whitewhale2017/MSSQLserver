--SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(2019 as varchar(4))+'-01-01'),120)+'1') 

--select EmpNo,Title,WorkRegion,(dbo.oFN_FindOrgLine(a.orgid,4,1)) as OrgLineTitle
--,CreateDate,DisabledDate, isnull(a.Disabled,0) as status
-- from md_employee a
-- where CreateDate<='2020-01-31 00:00:00.000' and (DisabledDate is null or DisabledDate>'2019-01-31 00:00:00.000')
-- --isnull(a.Disabled,0)=1 
  
 --select * from md_codes where xtype='WorkRegion'

-- select dateadd(Day,0,convert(char(10),getdate(),121)) --2020-03-05 00:00:00.000
-- select convert(char(7),getdate(),121)

 DECLARE @dt integer
SET @dt=2020
select t.uf_year,t.uf_month,t.uf_LastDayOfMonth,(select title from md_codes where t.id=ID and Xtype='WorkRegion') as uf_WorkRegion
,
case when t.uf_year+'-'+uf_month<convert(char(8),getdate(),121) then
    (select COUNT(EmpNo) from md_employee 
	where CreateDate<=t.uf_LastDayOfMonth 
	and (DisabledDate is null or DisabledDate>t.uf_LastDayOfMonth)
	and WorkRegion=t.ID
	)
	when t.uf_year+'-'+uf_month=convert(char(8),getdate(),121) then
    (select COUNT(EmpNo) from md_employee 
	where CreateDate<=dateadd(Day,0,convert(char(10),getdate(),121)) 
	and (DisabledDate is null or DisabledDate>dateadd(Day,0,convert(char(10),getdate(),121)))
	and WorkRegion=t.ID
	)
	else
	 null
	 end as uf_EmpInWork
from 
(
select DateName(year,a.uf_LastDayOfMonth) as uf_year
,DateName(month,a.uf_LastDayOfMonth) as uf_month
,a.uf_LastDayOfMonth,b.ID,b.Title from 
(
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-01-01'),120)+'1') as uf_LastDayOfMonth
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-02-01'),120)+'1')
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-03-01'),120)+'1')
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-04-01'),120)+'1')
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-05-01'),120)+'1')
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-06-01'),120)+'1')
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-07-01'),120)+'1')
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-08-01'),120)+'1')
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-09-01'),120)+'1')
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-10-01'),120)+'1')
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-11-01'),120)+'1')
union all
SELECT DATEADD(Day,-1,CONVERT(char(8),DATEADD(Month,1,CAST(@dt as varchar(4))+'-12-01'),120)+'1')
) a,(select ID,Title from md_Codes where Xtype='WorkRegion') b
) t




select EmpNo from md_Employee where EmpNo collate Chinese_PRC_CI_AI_WS  in (
select b.workcode 
from (
 select distinct data from dbo.SplitStr('150,1644',',')
	) a
left join  
(select * from openquery([OA],'select id,workcode from ecology.dbo.hrmresource')) b
on a.data=b.id 
)  

select * from [dbo].[md_Organization]
---------------------------------------------------
update md_Organization set Emp1=dbo.GetDistinctEmp(t.bmjl)
from (
select * from openquery([OA],'select b.departmentcode,
a.bmjl,a.zxzj ,a.zjj2 ,a.bmfg ,a.gsld 
from ecology.dbo.Matrixtable_2 a
left join ecology.dbo.HrmDepartment b on a.id = b.id')
) t 
where md_Organization.OrgCode collate Chinese_PRC_CI_AI_WS =t.departmentcode
-------------------------------------------------------
select * from md_Employee
------------------------------------
alter function GetDistinctEmp(@str varchar(1000))
returns varchar(1000)
as
begin
    declare @temp varchar(1000)
	declare @res varchar(1000)
    select @temp=(
    select ','+cast(EmpID as varchar) from(
	select Empid from md_Employee where EmpNo collate Chinese_PRC_CI_AI_WS  in (
    select b.workcode 
    from (
    select distinct data from dbo.SplitStr(@str,',')
	 ) a
    left join  
    (select * from openquery([OA],'select id,workcode from ecology.dbo.hrmresource')) b
     on a.data=b.id 
     )  
	) t
	for xml path('')
	)
    set @res=SUBSTRING(@temp,2,len(@temp))
	return @res
end

select dbo.GetDistinctEmp('150,1644')
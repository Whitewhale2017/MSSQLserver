select EmpID,EmpNo,Title,ParentID from md_Employee
where Title like N'%欧文利%'
----------------递归查询下级员工----------------------
create function f_getEmployee(@empid int)
returns @RtnValue table(empid int) 
as
begin
    with CTE as
	(
	select EmpID,EmpNo,Title,ParentID from md_Employee where EmpID=@empid
	union all
	select a.EmpID,a.EmpNo,a.Title,a.ParentID from CTE 
	inner join md_Employee a 
	on CTE.EmpID=a.ParentID
	)
	insert into @RtnValue select EmpID from CTE where EmpID<>@empid
	return 
end 

select * from dbo.f_getEmployee(2396)
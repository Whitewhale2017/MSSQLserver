create function f_bmqc(@id int) --查询部门全称
returns varchar(300)
as 
begin 
declare @res varchar(300)
declare @supdepid int
set @res=(select departmentname from HrmDepartment where id=@id)
set @supdepid=(select supdepid from HrmDepartment where id=@id)
while  @supdepid!=0
begin
set @res=(select departmentname from HrmDepartment where id=@supdepid)+'>'+@res
set @supdepid=(select supdepid from HrmDepartment where id=@supdepid)
end 
return @res
end 

create function f_gsqc(@id int) --查询公司全称
returns varchar(300)
as 
begin 
declare @res varchar(300)
declare @supsubcomid int
set @res=(select subcompanyname from HrmSubCompany where id=@id)
set @supsubcomid=(select supsubcomid from HrmSubCompany where id=@id)
while  @supsubcomid!=0
begin
set @res=(select subcompanyname from HrmSubCompany where id=@supsubcomid)+'>'+@res
set @supsubcomid=(select supsubcomid from HrmSubCompany where id=@supsubcomid)
end 
return @res
end 

select dbo.f_gsqc(id),id,subcompanyname from HrmSubCompany

select dbo.f_gsqc(subcompanyid1)+'||'+dbo.f_bmqc(id),id from HrmDepartment
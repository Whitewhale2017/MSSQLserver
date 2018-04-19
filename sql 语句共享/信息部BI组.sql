create or alter view view_employeeinfo as
select workcode as 工号,lastname as 姓名,a.subcompanyid1 as 公司ID,subcompanyname as 公司名称,departmentid as 部门ID,departmentname as 部门名称,d.jobtitlename as 岗位,sex as 性别,birthday as 出生日期,certificatenum as 身份证,e.name as educationlevel(学历),status as 员工状态 from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
left join HrmJobTitles d on a.jobtitle = d.id
left join HrmEducationLevel e on a.educationlevel = e.id


CREATE view view_LeaveEmployeeInfo as
select a.id,workcode as 工号,lastname as 姓名,b.subcompanyname as 公司,c.departmentname as 部门,f.jobtitlename as 岗位,a.certificatenum as 身份证,mobile as 手机号,e.name as 学历,startdate as 入职日期,enddate as 离职日期
from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
left join HrmEducationLevel e on a.educationlevel = e.id 
left join HrmJobTitles f on a.jobtitle = f.id
where 1=1 and status  = 5 

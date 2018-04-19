
select * from HrmSubCompany

--**事业部
select id,departmentname,canceled,ehrcode from HrmDepartment where subcompanyid1 ='9' order by departmentname
--一级部门
select id,departmentname,canceled from HrmDepartment where subcompanyid1 ='9' and supdepid = '0' order by departmentname
--二级部门
select a.id,a.departmentname,b.ehrcode,a.canceled from HrmDepartment a
left join HrmDepartment b on a.supdepid = b.id
where a.supdepid in (select id from HrmDepartment where subcompanyid1 ='9'and supdepid = '0') 
order by departmentname
--三级部门
select a.id,a.departmentname,b.ehrcode,a.canceled from HrmDepartment a
left join HrmDepartment b on a.supdepid = b.id
where a.supdepid in (
	select id from HrmDepartment where supdepid in (select id from HrmDepartment where subcompanyid1 ='9' and supdepid = '0')
)
order by departmentname
--四级部门
select id,departmentname,supdepid,subcompanyid1,canceled from HrmDepartment where supdepid in (
	select id from HrmDepartment where supdepid in (
		select id from HrmDepartment where supdepid in (select id from HrmDepartment where subcompanyid1 ='9' and supdepid = '0')
	)
)
order by departmentname
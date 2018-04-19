select a.id,b.subcompanyname as 公司,a.departmentname as 一级部门,a.departmentcode,c.departmentname as 二级部门,c.departmentcode,d.departmentname as 三级部门,d.departmentcode from HrmDepartment a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on c.supdepid = a.id and (c.canceled is null or c.canceled = '0')
left join HrmDepartment d on d.supdepid = c.id and (d.canceled is null or d.canceled = '0')
where a.supdepid = '0' and (a.canceled is null or a.canceled = '0')
order by b.id
select a.id,b.subcompanyname as ��˾,a.departmentname as һ������,a.departmentcode,c.departmentname as ��������,c.departmentcode,d.departmentname as ��������,d.departmentcode from HrmDepartment a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on c.supdepid = a.id and (c.canceled is null or c.canceled = '0')
left join HrmDepartment d on d.supdepid = c.id and (d.canceled is null or d.canceled = '0')
where a.supdepid = '0' and (a.canceled is null or a.canceled = '0')
order by b.id
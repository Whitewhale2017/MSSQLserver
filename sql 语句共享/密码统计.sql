--密码为1 的 358
select lastname,b.subcompanyname,c.departmentname,seclevel from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
where status in (0,1) and password = 'C4CA4238A0B923820DCC509A6F75849B'
--密码为11 的 49
select lastname,b.subcompanyname,c.departmentname,seclevel from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
where status in (0,1) and password = '6512BD43D9CAA6E02C990B0A82652DCA'
--密码为123456 的 73
select lastname,b.subcompanyname,c.departmentname,seclevel from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
where status in (0,1) and password = 'E10ADC3949BA59ABBE56E057F20F883E'
--密码为123 的 15
select lastname,b.subcompanyname,c.departmentname,seclevel from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
where status in (0,1) and password = '202CB962AC59075B964B07152D234B70'

--密码为111111 的 97
select lastname,b.subcompanyname,c.departmentname,seclevel from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
where status in (0,1) and password = '96E79218965EB72C92A549DD5A330112'

--����Ϊ1 �� 358
select lastname,b.subcompanyname,c.departmentname,seclevel from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
where status in (0,1) and password = 'C4CA4238A0B923820DCC509A6F75849B'
--����Ϊ11 �� 49
select lastname,b.subcompanyname,c.departmentname,seclevel from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
where status in (0,1) and password = '6512BD43D9CAA6E02C990B0A82652DCA'
--����Ϊ123456 �� 73
select lastname,b.subcompanyname,c.departmentname,seclevel from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
where status in (0,1) and password = 'E10ADC3949BA59ABBE56E057F20F883E'
--����Ϊ123 �� 15
select lastname,b.subcompanyname,c.departmentname,seclevel from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
where status in (0,1) and password = '202CB962AC59075B964B07152D234B70'

--����Ϊ111111 �� 97
select lastname,b.subcompanyname,c.departmentname,seclevel from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
where status in (0,1) and password = '96E79218965EB72C92A549DD5A330112'

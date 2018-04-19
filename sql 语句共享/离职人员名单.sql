select a.id,workcode as 工号,lastname as 姓名,a.subcompanyid1 as 公司,a.departmentid as 部门,g.jobtitlename as 岗位,a.certificatenum as 身份证,mobile as 手机号,HGSchool as 毕业学校,f.selectname as 学历,datefield1 as 入职日期,LeaveDate as 离职日期,e.selectname as  离职原因
from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
left join workflow_SelectItem e on cast(a.LeavingReason as int) = cast(e.selectvalue as int) and e.fieldid = '13649'
left join Workflow_Selectitem f on a.HGEducationLevel = f.selectvalue and f.fieldid = '10021'
left join HrmJobTitles g on a.jobtitle = g.id
where 1=1 and status  = 5 and a.LeavingReason <>4
order by LeaveDate desc
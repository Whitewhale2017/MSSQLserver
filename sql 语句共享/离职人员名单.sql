select a.id,workcode as ����,lastname as ����,a.subcompanyid1 as ��˾,a.departmentid as ����,g.jobtitlename as ��λ,a.certificatenum as ���֤,mobile as �ֻ���,HGSchool as ��ҵѧУ,f.selectname as ѧ��,datefield1 as ��ְ����,LeaveDate as ��ְ����,e.selectname as  ��ְԭ��
from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
left join workflow_SelectItem e on cast(a.LeavingReason as int) = cast(e.selectvalue as int) and e.fieldid = '13649'
left join Workflow_Selectitem f on a.HGEducationLevel = f.selectvalue and f.fieldid = '10021'
left join HrmJobTitles g on a.jobtitle = g.id
where 1=1 and status  = 5 and a.LeavingReason <>4
order by LeaveDate desc
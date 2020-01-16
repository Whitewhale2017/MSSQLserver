select * from (
select * from (
select a.workcode,a.lastname,c.departmentcode as oadeptcode
,'上海三思电子工程有限公司'+'>'+dbo.f_gsqc(a.subcompanyid1)+'>'+dbo.f_bmqc(a.departmentid) as oabmlj
,d.jobtitlecode,d.jobtitlename
,a.status,b.workcode as oazjsj 
from HrmResource a
inner join HrmResource b 
on a.managerid=b.id
left join HrmDepartment c
on  a.departmentid=c.id
left join HrmJobTitles d
on a.jobtitle=d.id
) oa
left join (
select * from openquery([192.168.43.50,1488],'select a.EmpNo,a.Title,c.OrgCode
,mchr.dbo.oFN_FindOrgLine(a.OrgID,4,1) as mcbmlj
,d.PostCode,d.Title as jotitle,a.JobStatus,b.EmpNo  as mczjsj
from mchr.dbo.md_Employee a
inner join mchr.dbo.md_Employee b
on a.ParentID=b.EmpID
left join mchr.dbo.md_Organization c
on a.OrgID=c.OrgID
left join mchr.dbo.md_Position d
on a.PostID=d.PostID
')
) mc
on oa.workcode=mc.EmpNo collate Chinese_PRC_CI_AI_WS
) t
where t.status<>5



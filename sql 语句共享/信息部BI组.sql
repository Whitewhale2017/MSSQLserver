create or alter view view_employeeinfo as
select workcode as ����,lastname as ����,a.subcompanyid1 as ��˾ID,subcompanyname as ��˾����,departmentid as ����ID,departmentname as ��������,d.jobtitlename as ��λ,sex as �Ա�,birthday as ��������,certificatenum as ���֤,e.name as educationlevel(ѧ��),status as Ա��״̬ from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
left join HrmJobTitles d on a.jobtitle = d.id
left join HrmEducationLevel e on a.educationlevel = e.id


CREATE view view_LeaveEmployeeInfo as
select a.id,workcode as ����,lastname as ����,b.subcompanyname as ��˾,c.departmentname as ����,f.jobtitlename as ��λ,a.certificatenum as ���֤,mobile as �ֻ���,e.name as ѧ��,startdate as ��ְ����,enddate as ��ְ����
from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
left join HrmEducationLevel e on a.educationlevel = e.id 
left join HrmJobTitles f on a.jobtitle = f.id
where 1=1 and status  = 5 

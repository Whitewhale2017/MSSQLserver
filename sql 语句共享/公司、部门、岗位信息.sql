--��˾
select a.id as һ����˾ID,a.subcompanyname as һ����˾����,a.subcompanydesc as һ����˾���,
       b.id as ������˾ID,b.subcompanyname as ������˾����,b.subcompanydesc as ������˾���,
(case a.canceled when '1' then '���' when '' then 'δ���' end) as �Ƿ��� from HrmSubCompany a
left join HrmSubCompany b on a.id = b.supsubcomid
where a.id <>1 
order by a.url
					
--���� 	
select b.subcompanyname as ��˾,
a.id as һ��id,a.departmentname as һ������,(case a.canceled when '1' then '���' when '' then 'δ���' end) as �Ƿ���,
c.id as ����id,c.departmentname as ��������,(case c.canceled when '1' then '���' when '' then 'δ���' end) as �Ƿ���,
d.id as ����id,d.departmentname as ��������,(case d.canceled when '1' then '���' when '' then 'δ���' end) as �Ƿ���,
e.id as �ļ�id,e.departmentname as �ļ�����,(case e.canceled when '1' then '���' when '' then 'δ���' end) as �Ƿ���
from HrmDepartment a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on c.supdepid = a.id 
left join HrmDepartment d on d.supdepid = c.id
left join HrmDepartment e on e.supdepid = d.id
where a.id <>1
order by b.url

--��λ
select a.id as ��λID,a.jobtitlename as ��λ,a.jobtitlemark as ��λ���,b.departmentname as ��������,c.subcompanyname as ������˾ from HrmJobTitles a 
left join HrmDepartment b on a.jobdepartmentid = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.id <>1 
order by c.url,a.id

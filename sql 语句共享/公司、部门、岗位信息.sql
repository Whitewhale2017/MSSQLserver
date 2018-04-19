--公司
select a.id as 一级公司ID,a.subcompanyname as 一级公司名称,a.subcompanydesc as 一级公司简称,
       b.id as 二级公司ID,b.subcompanyname as 二级公司名称,b.subcompanydesc as 二级公司简称,
(case a.canceled when '1' then '封存' when '' then '未封存' end) as 是否封存 from HrmSubCompany a
left join HrmSubCompany b on a.id = b.supsubcomid
where a.id <>1 
order by a.url
					
--部门 	
select b.subcompanyname as 公司,
a.id as 一级id,a.departmentname as 一级部门,(case a.canceled when '1' then '封存' when '' then '未封存' end) as 是否封存,
c.id as 二级id,c.departmentname as 二级部门,(case c.canceled when '1' then '封存' when '' then '未封存' end) as 是否封存,
d.id as 三级id,d.departmentname as 三级部门,(case d.canceled when '1' then '封存' when '' then '未封存' end) as 是否封存,
e.id as 四级id,e.departmentname as 四级部门,(case e.canceled when '1' then '封存' when '' then '未封存' end) as 是否封存
from HrmDepartment a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on c.supdepid = a.id 
left join HrmDepartment d on d.supdepid = c.id
left join HrmDepartment e on e.supdepid = d.id
where a.id <>1
order by b.url

--岗位
select a.id as 岗位ID,a.jobtitlename as 岗位,a.jobtitlemark as 岗位简称,b.departmentname as 所属部门,c.subcompanyname as 所属公司 from HrmJobTitles a 
left join HrmDepartment b on a.jobdepartmentid = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.id <>1 
order by c.url,a.id

select * from ytx.dbo.cus_view_company order by org_id
--**事业部
select org_id,org_desc,Archive from ytx.dbo.cus_view_dept where superior_company_id = '9C6F14DD-64AF-4B87-AB51-18BB3EF05C44' 
order by org_desc

--一级部门
select org_id,org_desc,Archive from ytx.dbo.cus_view_dept 
where superior_company_id = '9C6F14DD-64AF-4B87-AB51-18BB3EF05C44' and superior_id is null
order by org_desc
--二级部门
select org_id,org_desc,superior_id,Archive from ytx.dbo.cus_view_dept 
where superior_id in (
select org_id from ytx.dbo.cus_view_dept where superior_company_id = '9C6F14DD-64AF-4B87-AB51-18BB3EF05C44' and superior_id is null)
order by org_desc
--三级部门
select org_id,org_desc,superior_id,Archive from ytx.dbo.cus_view_dept where superior_id in 
(
	select org_id from ytx.dbo.cus_view_dept where superior_id in 
	(select org_id from ytx.dbo.cus_view_dept where superior_company_id = '9C6F14DD-64AF-4B87-AB51-18BB3EF05C44' and superior_id is null)
)
order by org_desc
--四级部门
select org_id,org_desc,superior_id,superior_company_id,Archive from ytx.dbo.cus_view_dept where superior_id in 
(
	select org_id from ytx.dbo.cus_view_dept where superior_id in 
	(
		select org_id from ytx.dbo.cus_view_dept where superior_id in 
		(select org_id from ytx.dbo.cus_view_dept where superior_company_id = '9C6F14DD-64AF-4B87-AB51-18BB3EF05C44' and superior_id is null)
	)
)
order by org_desc


--部门流程退回前十统计--

select top 10 d.departmentname+'('+e.subcompanydesc+')' as bm,thcs 
from (
select count(b.requestid) as thcs,c.departmentid,c.subcompanyid1 
from workflow_requestbase a 		 	
left join workflow_requestLog b 
on a.requestid = b.requestid 		 	
left join HrmResource c 
on a.creater = c.id 		 	 	
Where 1=1 and logtype = '3' and a.createdate >= '2015-06-08' and a.createdate <= '2015-06-14'			 	
group by c.departmentid,c.subcompanyid1	 ) a 
left join HrmDepartment d 
on a.departmentid = d.id		 
left join HrmSubCompany e 
on a.subcompanyid1 = e.id	  
order by thcs desc+
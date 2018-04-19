--待办事宜前十排名-[员工]-

select top 10 lastname,dbsy 
from 
(select COUNT(a.requestid) as dbsy,a.userid as id,c.lastname,c.subcompanyid1,c.departmentid,c.seclevel 
from workflow_currentoperator a  
left join workflow_base b 
on a.workflowid = b.id  
left join HrmResource c 
on a.userid = c.id 
Where 1=1 and b.isvalid = '1'and islasttimes = '1' and isremark in (0,1,5,7,8,9) and a.userid <> '1'  and c.seclevel <= '30'   
group by a.userid,c.lastname,c.subcompanyid1,c.departmentid,c.seclevel ) a 
order by a.dbsy desc
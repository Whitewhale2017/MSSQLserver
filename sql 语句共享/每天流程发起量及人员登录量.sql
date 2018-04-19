select c.typename,b.workflowname,COUNT(requestid) from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where a.createdate ='2016-12-08'
group by c.typename,b.workflowname

select distinct relatedid from HrmSysMaintenanceLog where operatedate = '2016-12-08' group by relatedid


select COUNT(*) from HrmSysMaintenanceLog where operatedate = '2016-12-08' 

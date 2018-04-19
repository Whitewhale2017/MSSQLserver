
select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where isvalid = '1' and lastoperatedate !='' and lastoperatedate !='0' and a.createdate >= '2016-01-01' and a.createdate <='2016-12-31'
and DATEDIFF(DAY,a.createdate+' '+a.createtime,a.lastoperatedate+' '+a.lastoperatetime)>='0'
and DATEDIFF(DAY,a.createdate+' '+a.createtime,a.lastoperatedate+' '+a.lastoperatetime)<='5'
group by c.typename

select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where isvalid = '1' and lastoperatedate !='' and lastoperatedate !='0' and a.createdate >= '2016-01-01' and a.createdate <='2016-12-31'
and DATEDIFF(DAY,a.createdate+' '+a.createtime,a.lastoperatedate+' '+a.lastoperatetime)>'5'
and DATEDIFF(DAY,a.createdate+' '+a.createtime,a.lastoperatedate+' '+a.lastoperatetime)<='10'
group by c.typename

select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where isvalid = '1' and lastoperatedate !='' and lastoperatedate !='0' and a.createdate >= '2016-01-01' and a.createdate <='2016-12-31'
and DATEDIFF(DAY,a.createdate+' '+a.createtime,a.lastoperatedate+' '+a.lastoperatetime)>'10'
group by c.typename

select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where isvalid = '1' and lastoperatedate !='' and lastoperatedate !='0'
and DATEDIFF(DAY,a.createdate+' '+a.createtime,a.lastoperatedate+' '+a.lastoperatetime)>='0'
and DATEDIFF(DAY,a.createdate+' '+a.createtime,a.lastoperatedate+' '+a.lastoperatetime)<='5'
group by c.typename

select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where isvalid = '1' and lastoperatedate !='' and lastoperatedate !='0'
and DATEDIFF(DAY,a.createdate+' '+a.createtime,a.lastoperatedate+' '+a.lastoperatetime)>'5'
and DATEDIFF(DAY,a.createdate+' '+a.createtime,a.lastoperatedate+' '+a.lastoperatetime)<='10'
group by c.typename

select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where isvalid = '1' and lastoperatedate !='' and lastoperatedate !='0'
and DATEDIFF(DAY,a.createdate+' '+a.createtime,a.lastoperatedate+' '+a.lastoperatetime)>'10'
group by c.typename


select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where isvalid = '1' and a.currentnodetype = '3'
group by c.typename

select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where isvalid = '1' and a.createdate >= '2016-01-01' and a.createdate <='2016-12-31'
group by c.typename


select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where isvalid = '1' and a.currentnodetype = '3' and a.createdate >= '2016-01-01' and a.createdate <='2016-12-31'
group by c.typename
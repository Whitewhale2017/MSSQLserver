----------------当前月各事业部流程类型数量统计
select c.subcompanyname,e.typename,count(requestid) as amount from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_base d on a.workflowid = d.id
left join workflow_type e on d.workflowtype = e.id
where a.createdate >= '2016-06-01' and a.createdate <= '2016-06-30' 
group by c.subcompanyname,e.typename

-----------六月
----------------各事业部流程类型数量统计(决策类:签呈、合同) 总数 
select c.subcompanyname,count(requestid) as amount from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_base d on a.workflowid = d.id
where a.createdate >= '2016-06-01' and a.createdate <= '2016-06-30' and a.workflowid in (122,204,342,352,353,354,350,341,339,355)
group by c.subcompanyname
----------------各事业部流程类型数量统计(决策类:签呈、合同) 办结
select c.subcompanyname,count(requestid) as amount from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_base d on a.workflowid = d.id
where a.createdate >= '2016-06-01' and a.createdate <= '2016-06-30' 
and a.lastoperatedate >= '2016-06-01' and a.lastoperatedate <= '2016-06-31'  
and a.workflowid in (122,204,342,352,353,354,350,341,339,355)
and a.currentnodetype = '3'
group by c.subcompanyname

---当前月所创建流程审批超过15天的统计
select c.subcompanyname,a.requestid,a.requestname,currentnodetype,a.createdate,a.lastoperatedate  from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_base d on a.workflowid = d.id
where a.createdate >= '2016-06-01' and a.createdate <= '2016-06-31' and a.workflowid in (122,204,342,352,353,354,350,341,339,355) --and c.id = '13'
and DATEDIFF(DAY,a.createdate+' '+createtime,lastoperatedate+' '+lastoperatetime) >=15
order by c.subcompanyname

--------5月
----------------各事业部流程类型数量统计(决策类:签呈、合同) 总数
select c.subcompanyname,count(requestid) as amount from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_base d on a.workflowid = d.id
where a.createdate >= '2016-05-01' and a.createdate <= '2016-05-31' and a.workflowid in (122,204,342,352,353,354,350,341,339,355)
group by c.subcompanyname
----------------当前月各事业部流程类型数量统计(决策类:签呈、合同) 办结 
select c.subcompanyname,count(a.requestid)  from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_base d on a.workflowid = d.id
where  a.createdate >= '2016-05-01' and a.createdate <= '2016-05-31' 
and a.lastoperatedate >= '2016-05-01' and a.lastoperatedate <= '2016-05-31' 
and a.workflowid in (122,204,342,352,353,354,350,341,339,355)
and a.currentnodetype ='3'
group by c.subcompanyname

---当前月所创建流程审批超过15天的统计
select c.subcompanyname,a.requestid,a.requestname,currentnodetype,a.createdate,a.lastoperatedate  from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_base d on a.workflowid = d.id
where a.createdate >= '2016-05-01' and a.createdate <= '2016-05-31' and a.workflowid in (122,204,342,352,353,354,350,341,339,355) --and c.id = '13'
and DATEDIFF(DAY,a.createdate+' '+createtime,lastoperatedate+' '+lastoperatetime) >=15
order by c.subcompanyname


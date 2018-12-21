------月度流程审批量（经理以下）-----------------
select operator,max(h.lastname) as name,max(d.departmentname) as departmentname ,count(distinct  l.requestid) as sum,
max(b.jobtitlename) as gw
from workflow_requestlog l 
inner join hrmresource h on  l.operator = h.id 
inner join OA_HrmDepartmentView d on h.departmentid = d.id
inner join workflow_nodebase n on l.nodeid = n.id
left join HrmJobTitles b on h.jobtitle=b.id
where l.workflowid!=1 and n.isend = 0 and n.isstart = 0 
and l.operatedate like '2018-11%' and h.seclevel<40
group by operator 
order by sum desc

------月度流程审批量（经理及以上）-----------------
select operator,max(h.lastname) as name,max(d.departmentname) as departmentname ,count(distinct  l.requestid) as sum,
max(b.jobtitlename) as gw
from workflow_requestlog l 
inner join hrmresource h on  l.operator = h.id 
inner join OA_HrmDepartmentView d on h.departmentid = d.id
inner join workflow_nodebase n on l.nodeid = n.id
left join HrmJobTitles b on h.jobtitle=b.id
where l.workflowid!=1 and n.isend = 0 and n.isstart = 0 
and l.operatedate like '2018-11%' and h.seclevel>=40
group by operator 
order by sum desc

----根据发起人所属公司按月统计发起流程数量、归档数量、被退回过流程数量、审批超过15天
select t.companyid,
       (select workflowname from workflow_base where id = workflowid) as 流程名,
       (select subcompanyname from HrmSubCompany where id = t.companyid) as 公司名,
       count(requestid) as 发起,
       sum(case
             when currentnodetype = 3 then
              1
             else
              0
           end) as 归档,
       sum(case
             when currentnodetype = 3 then
              0
             else
              1
           end) as 未归档,
       sum(case
             when hours >= 15 * 24 then
              1
             else
              0
           end) as 超过15天,
       sum(case
             when thcs = 0 or thcs is null then
              0
             else
              1
           end) as 退回流程数量,
       sum(thcs) as 退回次数
  from (select (select workflowtype from workflow_base where id = workflowid) as workflowtype,
               workflowid,
               (select id
                  from HrmSubCompany
                 where id = (select subcompanyid1
                               from hrmresource
                              where id = creater)) as companyid,
               createdate,
               lastoperatedate,
               requestid,
               creater,
               currentnodetype,
               dbo.Jisuanshichang(w.createdate,w.createtime,w.lastoperatedate,w.lastoperatetime) as hours,
               (select sum(case
                             when logtype = '3' then
                              1
                             else
                              0
                           end)
                  from workflow_requestLog
                 where requestid = w.requestid) as thcs
          from workflow_requestbase w
         where w.createdate >= '2018-11-01'
           and w.createdate < '2018-11-30') t
 group by companyid, workflowid

 ----根据流程类型、发起人所属公司按月统计发起流程数量、归档流程量
select
(select typename from workflow_type where id=workflowtype)as workflowtype,
(select subcompanyname from HrmSubCompany where id=t.companyid) as companyname,
count(requestid) as lcnum,sum(case when t.currentnodetype=3 then 1 else 0 end) as gdlcnum
from
(
select 
(select workflowtype from workflow_base where id=workflowid) as workflowtype,
workflowid,(select id from HrmSubCompany where id=(select subcompanyid1 from hrmresource where id=creater))  as companyid,
createdate,lastoperatedate,requestid,creater,w.currentnodetype
from workflow_requestbase w
where w.createdate>='2018-11-01' and w.createdate<='2018-11-30'
) t
group by workflowtype,companyid--,createdate

 ----根据流程类型按月统计发起流程数量、归档流程量
select
(select typename from workflow_type where id=workflowtype)as workflowtype,
count(requestid) as lcnum,sum(case when t.currentnodetype=3 then 1 else 0 end) as gdlcnum
from
(
select 
(select workflowtype from workflow_base where id=workflowid) as workflowtype,
workflowid,(select id from HrmSubCompany where id=(select subcompanyid1 from hrmresource where id=creater))  as companyid,
createdate,lastoperatedate,requestid,creater,w.currentnodetype
from workflow_requestbase w
where w.createdate>='2018-11-01' and w.createdate<='2018-11-30'
) t
group by workflowtype

  ----根据发起人所属公司按月统计发起流程数量、归档流程量
select
(select subcompanyname from HrmSubCompany where id=t.companyid) as companyname,
count(requestid) as lcnum,sum(case when t.currentnodetype=3 then 1 else 0 end) as gdlcnum
from
(
select 
(select workflowtype from workflow_base where id=workflowid) as workflowtype,
workflowid,(select id from HrmSubCompany where id=(select subcompanyid1 from hrmresource where id=creater))  as companyid,
createdate,lastoperatedate,requestid,creater,w.currentnodetype
from workflow_requestbase w
where w.createdate>='2018-11-01' and w.createdate<='2018-11-30'
) t
group by companyid
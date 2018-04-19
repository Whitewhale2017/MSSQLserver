select * from workflow_base where id in (361,363,364,365)

select EmployeeCode from hrmresource_midtable group by EmployeeCode having count(EmployeeCode)>1

select * from hrmresource_midtable where EmployeeCode in ('800242','800350','800445','840176')

delete from hrmresource_midtable where id in (10698,10706,10715,10717)

----------CW_差旅费报销流程V3.0
select * from formtable_main_189 a
left join workflow_currentoperator b on a.requestId = b.requestid
left join workflow_nodebase c on b.nodeid = c.id
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31'

----------CW_费用报销申请流程V3.0
select * from formtable_main_189 a
left join workflow_currentoperator b on a.requestId = b.requestid
left join workflow_nodebase c on b.nodeid = c.id
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31' and b.nodeid = '3666'

-----------CW_用款申请V3.0
select a.LCBH,b.receivedate,b.operatedate,b.nodeid,c.nodename from formtable_main_190 a
left join workflow_currentoperator b on a.requestId = b.requestid
left join workflow_nodebase c on b.nodeid = c.id
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31' and b.nodeid = '3682'
order by LCBH

-----------CW_用款申请V3.0
select a.LCBH,b.receivedate,b.receivetime,b.operatedate,b.operatetime from formtable_main_191 a
left join workflow_currentoperator b on a.requestId = b.requestid
left join workflow_nodebase c on b.nodeid = c.id
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31' and b.nodeid = '3694'
order by LCBH


--获取出纳审批时长
----------CW_差旅费报销流程V3.0
select * from formtable_main_187 a
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31'

----------CW_费用报销申请流程V3.0
select * from formtable_main_189 a
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31'

-----------CW_用款申请V3.0
select * from formtable_main_190 a
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31' 

-----------CW_个人借款申请流程V3.0
select * from formtable_main_191 a
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31' 

----各分部发起流程量
----------CW_差旅费报销流程V3.0
select subcompanyname,count(a.requestId) from formtable_main_187 a
left join HrmResource b on a.SQR = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31'
group by c.subcompanyname

----------CW_费用报销申请流程V3.0
select subcompanyname,count(a.requestId) from formtable_main_189 a
left join HrmResource b on a.SQR = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31'
group by c.subcompanyname

-----------CW_用款申请V3.0
select subcompanyname,count(a.requestId) from formtable_main_190 a
left join HrmResource b on a.SQR = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31' 
group by c.subcompanyname

-----------CW_个人借款申请流程V3.0
select subcompanyname,count(a.requestId) from formtable_main_191 a
left join HrmResource b on a.SQR = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join workflow_requestbase d on a.requestId = d.requestid
where d.createdate>='2016-04-01' and d.createdate<='2016-08-31' 
group by c.subcompanyname

select * from formtable_main_266

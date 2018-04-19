--   54488
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0

--70142+6270
select count(*) from workflow_requestbase
where createdate>='2016-01-01' and  createdate<'2017-01-01' and currentnodetype<>0

-----------------------------------------2015年数据------------------------------------  55368
-- 0
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)=0 

-- 0-（3天    16171
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>0 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=3

-- 4-（5天    4605
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>3 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=5

-- 6-（8天    4566
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>5 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=8

--8天以上     6388
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>8

-----------------------------------------2016年数据------------------------------------  71859
-- 0天
select count(*) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)=0 

-- 0-（3天    21769
select count(*) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>0 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=3

-- 4-（5天    6107
select count(*) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>3 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=5

-- 6-（8天    6165
select count(*) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>5 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=8

--8天以上     10214
select count(*) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>8

-----------------------------------------2015年数据  所有流程平均耗时------------------------------------  
select sum(DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0


-----------------------------------------2016年数据  所有流程平均耗时-------------------------------------  
select sum(DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0

select * from workflow_base where workflowname like '%用款%'

---------------------------------2015年 四季度 付款流程当月发起当月归档
select b.requestname,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime,DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime) as ts from formtable_main_190 a
left join workflow_requestbase b on a.requestId = b.requestid
where SQRQ >= '2015-10-01' and SQRQ <= '2015-12-31' and currentnodetype = '3'

---------------------------------2016年 四季度 付款流程当月发起当月归档
select b.requestname,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime,DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime) as ts from formtable_main_190 a
left join workflow_requestbase b on a.requestId = b.requestid
where SQRQ >= '2016-10-01' and SQRQ <= '2016-12-31' and currentnodetype = '3'


--------------------------------2015年 各事业部流程发起量 --------------------------------
select c.subcompanyname,count(a.requestid) as 流程数量 from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2015-01-01' and a.createdate<'2016-01-01' and currentnodetype<>0
group by c.subcompanyname

--------------------------------2016年 各事业部流程发起量 --------------------------------
select c.subcompanyname,count(a.requestid) as 流程数量 from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2016-01-01' and a.createdate<'2017-01-01' and currentnodetype<>0
group by c.subcompanyname


------------------------------  2015年 人事、行政、合同、财务、其他流程发起量 ----------------------------
select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where a.currentnodetype <> 0 and a.createdate >= '2015-01-01' and a.createdate < '2016-01-01'
group by c.typename

------------------------------  2016年 人事、行政、合同、财务、其他流程发起量 ----------------------------
select c.typename as 流程类别,count(a.requestid) as 各流程数量 from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where a.currentnodetype <>0 and a.createdate >= '2016-01-01' and a.createdate < '2017-01-01'
group by c.typename

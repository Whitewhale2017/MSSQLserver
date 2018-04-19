--   54488
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0

--70142+6270
select count(*) from workflow_requestbase
where createdate>='2016-01-01' and  createdate<'2017-01-01' and currentnodetype<>0

-----------------------------------------2015������------------------------------------  55368
-- 0
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)=0 

-- 0-��3��    16171
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>0 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=3

-- 4-��5��    4605
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>3 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=5

-- 6-��8��    4566
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>5 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=8

--8������     6388
select count(*) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>8

-----------------------------------------2016������------------------------------------  71859
-- 0��
select count(*) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)=0 

-- 0-��3��    21769
select count(*) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>0 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=3

-- 4-��5��    6107
select count(*) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>3 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=5

-- 6-��8��    6165
select count(*) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>5 and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)<=8

--8������     10214
select count(*) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0
and DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)>8

-----------------------------------------2015������  ��������ƽ����ʱ------------------------------------  
select sum(DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)) from workflow_requestbase  
where createdate>='2015-01-01' and createdate<'2016-01-01' and currentnodetype<>0


-----------------------------------------2016������  ��������ƽ����ʱ-------------------------------------  
select sum(DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime)) from workflow_requestbase  
where createdate>='2016-01-01' and createdate<'2017-01-01' and currentnodetype<>0

select * from workflow_base where workflowname like '%�ÿ�%'

---------------------------------2015�� �ļ��� �������̵��·����¹鵵
select b.requestname,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime,DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime) as ts from formtable_main_190 a
left join workflow_requestbase b on a.requestId = b.requestid
where SQRQ >= '2015-10-01' and SQRQ <= '2015-12-31' and currentnodetype = '3'

---------------------------------2016�� �ļ��� �������̵��·����¹鵵
select b.requestname,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime,DATEDIFF(DAY,createdate+' '+createtime,lastoperatedate+' '+lastoperatetime) as ts from formtable_main_190 a
left join workflow_requestbase b on a.requestId = b.requestid
where SQRQ >= '2016-10-01' and SQRQ <= '2016-12-31' and currentnodetype = '3'


--------------------------------2015�� ����ҵ�����̷����� --------------------------------
select c.subcompanyname,count(a.requestid) as �������� from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2015-01-01' and a.createdate<'2016-01-01' and currentnodetype<>0
group by c.subcompanyname

--------------------------------2016�� ����ҵ�����̷����� --------------------------------
select c.subcompanyname,count(a.requestid) as �������� from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2016-01-01' and a.createdate<'2017-01-01' and currentnodetype<>0
group by c.subcompanyname


------------------------------  2015�� ���¡���������ͬ�������������̷����� ----------------------------
select c.typename as �������,count(a.requestid) as ���������� from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where a.currentnodetype <> 0 and a.createdate >= '2015-01-01' and a.createdate < '2016-01-01'
group by c.typename

------------------------------  2016�� ���¡���������ͬ�������������̷����� ----------------------------
select c.typename as �������,count(a.requestid) as ���������� from workflow_requestbase a
left join workflow_base b on a.workflowid = b.id
left join workflow_type c on b.workflowtype = c.id
where a.currentnodetype <>0 and a.createdate >= '2016-01-01' and a.createdate < '2017-01-01'
group by c.typename

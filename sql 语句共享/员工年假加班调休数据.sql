select b.workcode,b.lastname,b.seclevel,e.lastname,c.subcompanyname,d.departmentname,cjlczgs,
(ltrim(zhs/60) +'小时'+right('0'+ltrim(zhs%60),2)+'分'+ltrim(zhs%60)+'秒') as zhs,
(ltrim(pjhs/60) +'小时'+right('0'+ltrim(pjhs%60),2)+'分'+ltrim(pjhs%60)+'秒') as averagehs from (
	select COUNT(requestid) as cjlczgs,userid as id,SUM(ss) as zhs,SUM(ss)/COUNT(requestid) as pjhs from (
		select a.requestid,a.ss,b.requestname,userid from (
			select a.requestid,sum(DATEDIFF(MINUTE,receivedate+' '+receivetime,operatedate+' '+operatetime)) as ss,userid from				workflow_currentoperator a 
			left join workflow_nodebase b on a.nodeid = b.id 
			where 1=1 and a.workflowid not in (1,93,94,137) and a.isremark not in (1,8) and preisremark not in (1,8,9) and					a.receivedate >='2017-01-02' and a.receivedate <='2017-01-08'
			group by a.requestid,userid
		) a left join workflow_requestbase b on a.requestid = b.requestid
		where b.currentnodetype not in (0,3)
	) t1 group by userid
) a 
left join hrmresource b on a.id = b.id 
left join HrmSubCompany c on b.subcompanyid1 = c.id
left join HrmDepartment d on b.departmentid = d.id
left join HrmResource e on b.managerid = e.id
--where b.id = '25'
order by a.pjhs desc 

select * from uf_formtable_njtx where yggh= '000090'
update uf_formtable_njtx set jynj = '8.0' where yggh= '000090'
select * from workflow_base where workflowname like '%加班%'
select * from formtable_main_31 

select b.workcode,qjlx,qjsc from formtable_main_31 a
left join HrmResource b on a.sqr  = b.id
where requestId ='1651'

update uf_formtable_njtx set dnnj='', where yggh = '000090'

select isnull(jytx,0.00) as jytx from uf_formtable_njtx a
left join HrmResource b on a.yggh = b.workcode 
where b.id = ''

select * from formtable_main_31 a
left join workflow_requestbase b on a.requestId = b.requestid
where qjlx in (0,1) and b.currentnodetype = '3' 
--加班
--  24
select sum(jbsc),c.lastname,c.workcode from formtable_main_30 a
left join workflow_requestbase b on a.requestId = b.requestid
left join HrmResource c on a.sqr = c.id
where jbhcl=0 and b.currentnodetype = '3' and jbksrq>='2017-01-01'
group by c.lastname,c.workcode
--  134
select sum(jbsc),c.lastname,c.workcode from formtable_main_30 a
left join workflow_requestbase b on a.requestId = b.requestid
left join HrmResource c on a.sqr = c.id
where jbhcl=0 and b.currentnodetype = '3' and jbksrq<'2017-01-01'
group by c.lastname,c.workcode

-- 调休
select sum(qjsc),c.lastname,c.workcode  from formtable_main_31 a
left join workflow_requestbase b on a.requestId = b.requestid
left join HrmResource c on a.sqr = c.id
where qjlx in (0) and b.currentnodetype = '3' and a.qsrq>='2017-01-01'
group by c.lastname,c.workcode

select sum(qjsc),c.lastname,c.workcode  from formtable_main_31 a
left join workflow_requestbase b on a.requestId = b.requestid
left join HrmResource c on a.sqr = c.id
where qjlx in (0) and b.currentnodetype = '3' and a.qsrq<'2017-01-01'
group by c.lastname,c.workcode

select jcfdnj+jcflnj,dnnj,jynj,xm,yggh from uf_formtable_njtx where jcfdnj+jcflnj>dnnj order by yggh 

--年假
select sum(qjsc),c.lastname,c.workcode  from formtable_main_31 a
left join workflow_requestbase b on a.requestId = b.requestid
left join HrmResource c on a.sqr = c.id
where qjlx in (1) and b.currentnodetype = '3' and a.qsrq>='2017-01-01'
group by c.lastname,c.workcode

select sum(qjsc),c.lastname,c.workcode  from formtable_main_31 a
left join workflow_requestbase b on a.requestId = b.requestid
left join HrmResource c on a.sqr = c.id
where qjlx in (1) and b.currentnodetype = '3' and a.qsrq<'2017-01-01'
group by c.lastname,c.workcode

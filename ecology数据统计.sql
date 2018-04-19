--各事业部发起文档
select c.subcompanyname,count(a.id) from DocDetail a
left join HrmResource b on a.doccreaterid = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where doccreatedate >='2015-07-01' and doccreatedate <= '2015-12-31'
group by c.subcompanyname

select c.subcompanyname,count(a.id) from DocDetail a
left join HrmResource b on a.doccreaterid = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where doccreatedate >='2016-01-01' and doccreatedate <= '2016-06-31'
group by c.subcompanyname
--各事业部已办流程
select c.subcompanyname,count(a.requestid) from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate >='2015-07-01' and a.createdate <= '2015-12-31' and a.currentnodetype = '3'
group by c.subcompanyname

select c.subcompanyname,count(a.requestid) from workflow_requestbase a
left join HrmResource b on a.creater = b.id
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate >='2016-01-01' and a.createdate <= '2016-06-31' and a.currentnodetype = '3'
group by c.subcompanyname
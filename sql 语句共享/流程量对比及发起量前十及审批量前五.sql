--2015与2016年流程发起量总数
select count(*) as zsl from workflow_requestbase
where createdate>='2015-01-01' and  createdate<'2016-01-01'

select count(*) as zsl from workflow_requestbase
where createdate>='2016-01-01' and  createdate<'2017-01-01'

--2015与2016年人员总数  
select * from HrmResource where startdate >=''
--2016年流程发起量最多的前十
select count(*) as fql,b.lastname,c.subcompanyname from workflow_requestbase a
left join HrmResource b on a.creater = b.id 
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2016-01-01' 
group by b.lastname,c.subcompanyname 
order by fql desc
/*
741	林美净	银天下事业部
585	姚滟珍	金兜事业部
507	徐柳燕	银天下事业部
458	杨儿壮	银如意事业部
443	申云娇	制品贸易中心
396	陈欢	银天下事业部
396	耿庆玲	服务中心
389	季重阳	银如意事业部
386	陈青云	服务中心
378	蔡莲雯	运营中心
*/
--2016年流程审批量最多的前五

select count(requestid) as cly,b.lastname,c.subcompanyname from (
	select distinct requestid,userid from workflow_currentoperator 
	where receivedate>='2016-01-01' and  receivedate<'2017-01-01' and groupid<>0 
	group by userid,requestid
) a
left join HrmResource b on a.userid = b.id 
left join HrmSubCompany c on b.subcompanyid1 = c.id
where b.status in (0,1)
group by b.lastname,c.subcompanyname
order by cly desc

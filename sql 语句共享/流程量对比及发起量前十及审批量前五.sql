--2015��2016�����̷���������
select count(*) as zsl from workflow_requestbase
where createdate>='2015-01-01' and  createdate<'2016-01-01'

select count(*) as zsl from workflow_requestbase
where createdate>='2016-01-01' and  createdate<'2017-01-01'

--2015��2016����Ա����  
select * from HrmResource where startdate >=''
--2016�����̷���������ǰʮ
select count(*) as fql,b.lastname,c.subcompanyname from workflow_requestbase a
left join HrmResource b on a.creater = b.id 
left join HrmSubCompany c on b.subcompanyid1 = c.id
where a.createdate>='2016-01-01' 
group by b.lastname,c.subcompanyname 
order by fql desc
/*
741	������	��������ҵ��
585	Ҧ����	����ҵ��
507	������	��������ҵ��
458	���׳	��������ҵ��
443	���ƽ�	��Ʒó������
396	�»�	��������ҵ��
396	������	��������
389	������	��������ҵ��
386	������	��������
378	������	��Ӫ����
*/
--2016����������������ǰ��

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

select * from HrmDepartment
select * from HrmResource
sp_help HrmResource
select * from HrmSubCompany

select c.subcompanyname,r.lastname as 'rzcrm' from HrmResource r,HrmSubCompany c 
where 
cast(r.id as varchar) in (select * from dbo.SplitStr(cast((select c.rzcrm from HrmSubCompany c where c.id=6) as varchar),','))


select data as 'rzcrm' from dbo.SplitStr(cast((select c.rzcrm from HrmSubCompany c where c.id=6) as varchar),',')


select * from HrmSubCompany where (canceled is null or canceled=0)

create proc chaxungongsijuzheng
as
begin
select c.id,c.subcompanyname,t1.lastname as '��/�ӹ�˾�ܾ���',t2.lastname as 'ֱ�߸��ܲ�',t3.lastname as '���¾���',t4.lastname as '����רԱ',
t5.lastname as 'н��רԱ',t6.lastname as '����ӡ�±���Ա',t7.lastname as '�ܲ�/�ܾ�������',t8.lastname  as '������������Ա',t9.lastname as '��ְ��ά�Խ���',
t10.lastname as '��ְ��Ϣ��ȫ�Խ���',t11.lastname as '��ְ�����Խ���',t12.lastname as '��ְ��ѵ�Խ���',t13.lastname as '��ְ����/rtx�Խ���',
t14.lastname as '��ְCRM��ҵ��ϵͳ�Խ�',t15.lastname as '��ְ�ܾ���Խ���',t16.lastname as '��ְ��ά�Խ���',t17.lastname as '��ְ��Ϣ��ȫ�Խ���',
t18.lastname as '��ְ�����Խ���',t19.lastname as '��ְ��ѵ�Խ���',t20.lastname as '��ְ����Խ���',t21.lastname as '��ְ����/�رնԽ���',
t22.lastname as '��ְҵ��ϵͳ�رնԽ���',t23.lastname as '����������',t24.lastname '����רԱ',t25.lastname as '����Ա',t26.lastname as '��Ƹ������'
from HrmSubCompany c
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(r.id as varchar)=cast(c.fgszjl as varchar)) t1
on t1.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(c.zxfzc as varchar)=cast(r.id as varchar)) t2
on t2.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(c.rsjl as varchar)=cast(r.id as varchar)) t3
on t3.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(c.flzy as varchar)=cast(r.id as varchar)) t4
on t4.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(c.xzzy as varchar)=cast(r.id as varchar)) t5
on t5.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(c.rsyzbgr as varchar)=cast(r.id as varchar)) t6
on t6.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(c.zjlzl as varchar)=cast(r.id as varchar)) t7
on t7.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(c.clgly as varchar)=cast(r.id as varchar)) t8
on t8.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(c.rzywdjr as varchar)=cast(r.id as varchar)) t9
on t9.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(c.rzxxaqdj as varchar)=cast(r.id as varchar)) t10
on t10.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast(c.rzxzdjr as varchar)=cast(r.id as varchar)) t11
on t11.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.rzpxdjr as varchar)=cast(r.id as varchar)) t12
on t12.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.rzyxkt as varchar)=cast(r.id as varchar)) t13
on t13.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.rzcrm as varchar)=cast(r.id as varchar)) t14
on t14.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.lzzjbdj as varchar)=cast(r.id as varchar)) t15
on t15.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.lzywdj as varchar)=cast(r.id as varchar)) t16
on t16.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.lzxxaq as varchar)=cast(r.id as varchar)) t17
on t17.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.lzxzdj as varchar)=cast(r.id as varchar)) t18
on t18.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.lzpxdjr as varchar)=cast(r.id as varchar)) t19
on t19.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.lzcwdjr as varchar)=cast(r.id as varchar)) t20
on t20.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.lzyxgb as varchar)=cast(r.id as varchar)) t21
on t21.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.lzywxt as varchar)=cast(r.id as varchar)) t22
on t22.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.xzfzr as varchar)=cast(r.id as varchar)) t23
on t23.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.xizzy as varchar)=cast(r.id as varchar)) t24
on t24.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.gcy as varchar)=cast(r.id as varchar)) t25
on t25.subcompanyname=c.subcompanyname
left join
(select c.subcompanyname,r.lastname from HrmResource r,HrmSubCompany c 
where cast( c.zpfzr as varchar)=cast(r.id as varchar)) t26
on t26.subcompanyname=c.subcompanyname
where (c.canceled is null or c.canceled=0)
order by c.id
end

exec chaxungongsijuzheng



select selectname,a.id 
from formtable_main_167_dt1 a
inner join workflow_SelectItem b on a.gsmc = b.selectvalue and b.fieldid = '10540' and  selectname like ? 
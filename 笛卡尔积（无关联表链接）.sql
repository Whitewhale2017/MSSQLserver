select id,lastname,status,b.zzglg  
from HrmResource a,Matrixtable_4 b
order by id


----------------------------------
select a.id,lastname,status,b.zzglg 
from HrmResource a
cross join Matrixtable_4 b
order by id

------------------��ɫ����Ա�ϼ�--------------------------
select * from hrmroles
create view view_roles_members
as
select b.rolesname,a.roleid,substring((
select ','+cast(resourceid as varchar) from HrmRoleMembers
where roleid=a.roleid
for xml path('')),2,len((
select ','+cast(resourceid as varchar) from HrmRoleMembers
where roleid=a.roleid
for xml path('')))-1) as members
from HrmRoleMembers a
left join HrmRoles b
on a.roleid=b.id
group by a.roleid,b.rolesname

select * from view_roles_members

select islasttimes,* from workflow_currentoperator

--------------------------------------------------------

select * from MatrixInfo

select * from Matrixtable_1

alter view view_jz_members
as
select '��ҵ�����¹�����Ϣ' as 'jzmc','����רԱ' as 'lm',rszy,right(dbo.f_xmzh(rszy),len(dbo.f_xmzh(rszy))-1) as 'mebnames'
from Matrixtable_1
group by rszy
union all
select '��ҵ�����¹�����Ϣ' as 'jzmc','����רԱ' as 'lm',kqzy,right(dbo.f_xmzh(kqzy),len(dbo.f_xmzh(kqzy))-1) as 'mebnames'
from Matrixtable_1
group by kqzy
union all
select '��ҵ�����¹�����Ϣ' as 'jzmc','���¾���' as 'lm',rsjl,right(dbo.f_xmzh(rsjl),len(dbo.f_xmzh(rsjl))-1) as 'mebnames'
from Matrixtable_1
group by rsjl
union all
select '��ҵ�����¹�����Ϣ' as 'jzmc','��Ƹ����' as 'lm',zpfzr,right(dbo.f_xmzh(zpfzr),len(dbo.f_xmzh(zpfzr))-1) as 'mebnames'
from Matrixtable_1
group by zpfzr
union all
select '��ҵ�����¹�����Ϣ' as 'jzmc','н��רԱ' as 'lm',xzzy,right(dbo.f_xmzh(xzzy),len(dbo.f_xmzh(xzzy))-1) as 'mebnames'
from Matrixtable_1
group by xzzy
union all
select '��ҵ�����¹�����Ϣ' as 'jzmc','����רԱ' as 'lm',flzy,right(dbo.f_xmzh(flzy),len(dbo.f_xmzh(flzy))-1) as 'mebnames'
from Matrixtable_1
group by flzy

select * from view_jz_members

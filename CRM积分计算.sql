select * from [dbo].[�����б�$] where ������� is null
delete from [dbo].[�����б�$] where ������� is null

select * from [�����б�$] order by �µ�ʱ��,�û���


select * from [�����б�$] where �û��� in (
(select �û��� from [�����б�$] group by �û��� having count(1)>1))
order by �û���
 
 select distinct �µ�ʱ�� from [�����б�$] 

 create view v_mrmtje
 as
 select [�û���],sum([ʵ�����]) as ���ս�����,[�µ�ʱ��] from [dbo].[�����б�$] group by [�û���],[�µ�ʱ��]

alter view v_jfjcxx
as
select t.*,
(case
     when �ۼƽ��<=5000 then 1 
	 when  �ۼƽ��>5000 and �ۼƽ��<=10000 then 1.2 
	 when  �ۼƽ��>10000 and �ۼƽ��<=20000 then 2
	  when  �ۼƽ��>20000 then 3 end
	 ) as ���ֱ���,round(���ս�����/100,0) as ����
from (
select a.*,dbo.f_ljje(a.�µ�ʱ��,a.�û���) as �ۼƽ�� 
from v_mrmtje a
) t


alter function f_ljje(@xdrq varchar(30),@yhm varchar(30))
returns float
as
begin
declare @res float
    set @res=(select (case when sum(���ս�����) is null then 0 else sum(���ս�����) end) as a from v_mrmtje where [�µ�ʱ��]<@xdrq and �û���=@yhm)
return @res
end

select  t.*,t1.���� from (
select �û���,round(sum(���ֱ���*����),0) as �ۼƻ���,sum(���ս�����) as �ۼƽ��,
(case when sum(���ս�����)<=5000 then '����'
      when sum(���ս�����)>5000 and sum(���ս�����)<=10000 then '��'
	  when  sum(���ս�����)>10000 and sum(���ս�����)<20000 then '����'
	  when  sum(���ս�����)>20000 then '�ڿ�' end) as ��Ա�ȼ�
from v_jfjcxx group by �û���) t 
left join (select distinct �û���,���� from [�����б�$]) t1
on t.�û���=t1.�û���



select * from PDJL

select * from v_pdjg

alter view v_pdjg
as
select �ص�,����,���ص�,��λ,���ϱ���,��������,����,���������
,cast(������� as numeric(20,2)) as �������
,cast(�̵����� as numeric(20,2)) as �̵�����
,�̵���
,�̵�����
,�̵�ʱ��
from PDJL  a where a.�̵�ʱ�� =(
select max(b.�̵�ʱ��) 
from PDJL b 
where a.��λ=b.��λ 
and a.�ص�=b.�ص�
and a.����=b.����
and a.���ϱ���=b.���ϱ���
and a.����=b.����
and a.���������=b.��������� 
and a.���ص�=b.���ص�
)

select * from v_pdjg 
where --�̵�����=0 and 
�ص� like '%�ֽ�%'
order by �̵����� 

select * from v_pdjg 
where --�̵�����=0 and 
�ص� like '%����%'
order by �̵����� 

select ��λ,�ص�,����,���ϱ���,����,���������,���ص�
 from v_pdjg group by ��λ,�ص�,����,���ϱ���,����,���������,���ص� 
 having count(1)>1

select �ص�,����,���ص�,count(1) as ����
,sum(case when �̵����� = ������� then 1 else 0 end) as ��ƽ
,sum(case when �̵����� > ������� then 1 else 0 end) as ��ӯ
,sum(case when �̵����� < ������� then 1 else 0 end) as �̿�
,sum(case when �̵����� = 0 then 1 else 0 end) as �̵�����Ϊ��
from v_pdjg
group by �ص�,����,���ص�
order by �ص�

select �ص�,count(1) as ����
,sum(case when �̵����� = ������� then 1 else 0 end) as ��ƽ
,sum(case when �̵����� > ������� then 1 else 0 end) as ��ӯ
,sum(case when �̵����� < ������� then 1 else 0 end) as �̿�
,sum(case when �̵����� = 0 then 1 else 0 end) as �̵�����Ϊ��
from v_pdjg
group by �ص�
order by �ص�

select * from PDJL
select * from CWPDJL where ��λ='23 209 52'
select * from v_pdjg where ���������='DA1840355N18010100'

select count(*) from PDJL
select * from CWPDJL 

select t.* 
,case when ���������='�޲���' and �ƻ��̵���='��ƽ' then 'һ��'
      when ���������='����' and �ƻ��̵���='��ӯ' then 'һ��'
	  when ���������='����' and �ƻ��̵���='�̿�' then 'һ��'
	  when �ƻ�������� is null or �ƻ��̵����� is null or �ƻ��̵��� is null then  '�ƻ�������'
	 else '����'
  end as �������ƻ����
from 
(
select a.�ص�,a.�������� as ����,a.�ֿ���� as �ֿ�,a.��λ,a.���ϱ���,a.�������� as ��������,a.����,a.���������
,a.��������,a.ʵ������,a.��������
,a.��������ʵ��,a.�������츴��
,a.�������ʵ��,a.���������
,a.��� as '��λ���'
,b.������� as �ƻ��������,b.�̵����� as �ƻ��̵�����
,b.�̵��� as �ƻ��̵���
from cwpdjl a
left join v_pdjg b
on a.��������=b.���� and a.�ֿ����=b.���ص� and a.��λ=b.��λ and a.���ϱ���=b.���ϱ��� and a.����=b.���� and a.���������=b.���������
) t

select ��λ from [dbo].[ZJWSJPDJL] where �ƻ�����='��' group by ��λ

select * from [ZJWSJPDJL] where 
��λ='SHSYK2201'

 update [ZJWSJPDJL] set �ƻ�����='��' where 
��λ='SHSYK2201'



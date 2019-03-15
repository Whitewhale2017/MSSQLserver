truncate table material_history_item_log
insert into material_history_item_log select * from openquery([RF],'select * from v_material_history_item_log where createDate<=''2019-03-14 08:00''')

select * into material_history_item_log from openquery([RF],'select * from v_material_history_item_log where createDate<=''2019-03-15 08:00''')


select werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate from [dbo].[material_history_item_log] 
group by werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate
having count(*)>1

select gesme,quantity,verme from [material_history_item_log] where matnr='1100101302' and createDate='2019-03-07 19:29:39.0000000'

select * from [dbo].[stomtr]
------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

select  r.*,(��ƽ+�̿�+��ӯ)/(��������*1.0) as �̵����
from 
(
select  ����,sum(��Ŀ) as ��������,sum(case when �̵���='��ƽ' then ��Ŀ else 0 end) as  ��ƽ
,sum(case when �̵���='�̿�' then ��Ŀ else 0 end) as  �̿�
,sum(case when �̵���='��ӯ' then ��Ŀ else 0 end) as  ��ӯ
,sum(case when �̵���='δ��' then ��Ŀ else 0 end) as  δ��
from
(
select t.����,t.�̵���,count(t.�̵���) as ��Ŀ from 
(
select t.*,case when �������=�̵����� then '��ƽ'
                when �������>�̵����� then '�̿�'
			    when �������<�̵����� then '��ӯ'
			    else 'δ��'
			    end as '�̵���'
from
(
-----------------------------��ϸ------------------------------------------
select A.werks as '����',A.lgort as '���ص�',A.lgpla as '��λ',A.matnr as '���Ϻ�',A.maktx as '��������',A.��  as '�ִ�����'
,A.charg as '����',A.sonum_ex as '���������',A.bestq as '�������',B.verme as '�������',B.quantity as '�̵�����',B.�̵�ʱ��
from [dbo].[stomtr] A
left join (

select left(createDate,19) as '�̵�ʱ��',werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,verme,quantity
from (
select * from  material_history_item_log A
where createDate=(select max(createDate) from material_history_item_log B where A.werks=B.werks and A.lgort=B.lgort 
and A.lgpla=B.lgpla and A.matnr=B.matnr and A.charg=B.charg and A.sonum_ex=B.sonum_ex and A.bestq=B.bestq)
) t
where createDate>'2019-03-08 00:00:00.0000000'

) B
on A.werks=B.werks and A.lgort=B.lgort 
and A.lgpla=B.lgpla and A.matnr=B.matnr and A.charg=B.charg and A.sonum_ex=B.sonum_ex and A.bestq=B.bestq and A.��=B.lgtyp
-------------------------------------------------------------------------------------------------------------
) t
) t
group by ����,�̵���
) t
group by ����
) r
----------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------








select * from 
material_history_item_log 
where (werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate) 
in
(
select werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate 
from material_history_item_log
group by werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate
having count(*)>1
)

and id not in (
select max(id)
from material_history_item_log
group by werks,lgort,lgpla,matnr,maktx,lgtyp
,charg,sonum_ex,bestq,gesme,createDate
having count(*)>1
)





select ����,���ص�,��λ,���Ϻ�,�ִ�����,����,���������,������� 
from (
select left(createDate,19) as '�̵�ʱ��',werks as '����',lgort as '���ص�',lgpla as '��λ',matnr as '���Ϻ�',maktx as '��������',lgtyp as '�ִ�����'
,charg as '����',sonum_ex as '���������',bestq as '�������',gesme as '�������',quantity as '�̵�����'
from (
select * from  material_history_item_log A
where createDate=(select max(createDate) from material_history_item_log B where A.werks=B.werks and A.lgort=B.lgort 
and A.lgpla=B.lgpla and A.matnr=B.matnr and A.charg=B.charg and A.sonum_ex=B.sonum_ex and A.bestq=B.bestq)
) t
where createDate>'2019-03-08 00:00:00.0000000'
) t
group by ����,���ص�,��λ,���Ϻ�,�ִ�����,����,���������,�������
having count(*)>1
       

select *
from (
select left(createDate,19) as '�̵�ʱ��',werks as '����',lgort as '���ص�',lgpla as '��λ',matnr as '���Ϻ�',maktx as '��������',lgtyp as '�ִ�����'
,charg as '����',sonum_ex as '���������',bestq as '�������',gesme as '�������',quantity as '�̵�����'
from (
select * from  material_history_item_log A
where createDate=(select max(createDate) from material_history_item_log B where A.werks=B.werks and A.lgort=B.lgort 
and A.lgpla=B.lgpla and A.matnr=B.matnr and A.charg=B.charg and A.sonum_ex=B.sonum_ex and A.bestq=B.bestq)
) t
where createDate>'2019-03-08 00:00:00.0000000'
) t
where ���Ϻ�='1100002041' 
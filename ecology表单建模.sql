--���÷�����ģ�飺 
update modeinfo set isdelete=0 where id=ģ���id 
--ע�⣺modeinfo�洢�б���ģ����Ϣ��

--������ʷ������ָ����ģ�飨��uf_actibity_mapping�������� 
update uf_actibity_mapping set formid=��ģ��id 

select * from modeinfo where modename like '%�����ʲ�����Ա��Ϣ%'

update modeinfo set isdelete=0 where modename like '%�����ʲ�����Ա��Ϣ%'
--��ѯ���:(�Ȳ�ѯȷ������)
select * from workflow_currentoperator where userid =480 and isremark=8 and islasttimes=1 and workflowid=36 --����������ݣ����԰� isremark �ĳ� 2����
--������䣨���������أ�:
update workflow_currentoperator  set isremark =2 where userid =480 and isremark=8 and islasttimes=1 and workflowid=36
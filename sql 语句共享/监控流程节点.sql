 select b.id as ����id,workflowname,d.nodename as �ڵ�����,c.retract,IsPendingForward as �Ƿ������������ת��,
 IsWaitForwardOpinion as �Ƿ�ȴ���ת�������,
 IsBeForward as ��ת�����Ƿ��ת��,
 IsSubmitedOpinion as ��ת�����Ƿ��ת��,
 IsSubmitForward as �ύ��ת�����Ƿ���ύ���,
 IsFreeWorkflow as �Ƿ�����趨������ת,
 IsBeForwardSubmit as �Ƿ������Ѱ켰�������ת��,
 UseExceptionHandle as �Ƿ�����ת�쳣����,
 FlowToAssignNode as �洢ָ���Ľڵ�,
 ExceptionHandleWay as '�Զ���ת����һ�ڵ�||���û�ָ��������||�ύ��ָ���ڵ�'
 from workflow_flownode a
 left join workflow_base b on a.workflowid = b.id
 left join workflow_function_manage c on a.workflowid = c.workflowid and a.nodeid = c.operatortype
 left join workflow_nodebase d on a.nodeid = d.id
 where b.formid <0
 order by b.id,d.id
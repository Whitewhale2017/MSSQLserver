 select b.id as 流程id,workflowname,d.nodename as 节点名称,c.retract as '强制收回',IsPendingForward as 是否允许待办事宜转发,
 IsWaitForwardOpinion as 是否等待被转发人意见,
 IsBeForward as 被转发人是否可转发,
 IsSubmitedOpinion as 被转发人是否可转发,
 IsSubmitForward as 提交后被转发人是否可提交意见,
 IsFreeWorkflow as 是否可以设定自由流转,
 IsBeForwardSubmit as 是否允许已办及办结事宜转发,
 UseExceptionHandle as 是否开启流转异常处理,
 FlowToAssignNode as 存储指定的节点,
 ExceptionHandleWay as '自动流转至下一节点||由用户指定操作者||提交至指定节点'
 from workflow_flownode a
 left join workflow_base b on a.workflowid = b.id
 left join workflow_function_manage c on a.workflowid = c.workflowid and a.nodeid = c.operatortype
 left join workflow_nodebase d on a.nodeid = d.id
 where b.formid <0
 order by b.id,d.id
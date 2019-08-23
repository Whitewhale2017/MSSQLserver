select t1.requestid,
       t1.requestmark,
       t1.createdate,
       t1.createtime,
      (select lastname from  hrmresource where id=t1.creater) as creater,
       t1.creatertype,
       t1.workflowid,
       t1.requestname,
       t1.requestnamenew,
       t1.status,
       t1.requestlevel,
       t1.currentnodeid,
       t2.viewtype,
       t2.userid,
       t2.receivedate,
       t2.receivetime,
       t2.isremark,
       t2.nodeid,
       t2.agentorbyagentid,
       t2.agenttype,
       t2.isprocessed
  from workflow_requestbase t1, workflow_currentoperator t2
 where (t1.deleted <> 1 or t1.deleted is null or t1.deleted = '')
   and t1.requestid = t2.requestid
   and t2.userid = 5026 --人员ID
   and t2.usertype = 0
   --and t2.requestid='72189' 
   and (t1.deleted = 0 or t1.deleted is null)
   and ((t2.isremark = '0' and (t2.takisremark is null or t2.takisremark = '0')) or t2.isremark in ('1', '5', '8', '9', '7'))
   and (t1.deleted = 0 or t1.deleted is null)
   and t2.islasttimes = 1 --标志位
   and (isnull(t1.currentstatus, -1) = -1 or (isnull(t1.currentstatus, -1) = 0 and t1.creater in (1)))
   and t1.workflowid in
       (select id from workflow_base where (isvalid = '1' or isvalid = '3'))
   order by t2.receivedate ,t2.receivetime

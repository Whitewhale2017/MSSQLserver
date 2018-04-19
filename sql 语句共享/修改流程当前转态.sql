select * from workflow_requestLog  where requestid = '124495' and workflowid = '451' and operatedate = '2016-10-17' and operatetime = '14:45:02'

delete from workflow_requestLog where requestid = '124495' and workflowid = '451' and operatedate = '2016-10-17' and operatetime = '14:45:02'

update workflow_requestbase set status = '09子公司总经理' where requestid = '124495' 
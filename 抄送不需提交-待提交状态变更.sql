--查询语句:(先查询确认数据)
select * from workflow_currentoperator where userid =480 and isremark=8 and islasttimes=1 and workflowid=36 --查出来的数据，可以把 isremark 改成 2即可
--更新语句（更新请慎重）:
update workflow_currentoperator  set isremark =2 where userid =480 and isremark=8 and islasttimes=1 and workflowid=36


--update formtable_main_39 set wjrq=Datename(year,GetDate())+'-'+Datename
--(month,GetDate())+'-'+Datename(day,GetDate()) where requestid={?requestid}

select Datename(year,GetDate())+'-'+Datename(month,GetDate())+'-'+Datename(day,GetDate()) --当前日期

select * from formtable_main_43 

select * from workflow_currentoperator where  nodeid='2277' and requestid='102171' \

select receivedate from workflow_currentoperator where  nodeid='2277' and requestid='102224'

update formtable_main_43  -----生成证照外接日期
set wjrq=c.receivedate
from workflow_currentoperator c,formtable_main_43 f
where f.requestId=c.requestid and c.nodeid='2277'


select * from formtable_main_39 where requestId='100193'

select * from workflow_currentoperator where  nodeid='2297' and requestid='102715'

update formtable_main_39  -----生成印章外接日期
set wjrq=c.receivedate
from workflow_currentoperator c,formtable_main_39 f
where f.requestId=c.requestid and c.nodeid='2297'

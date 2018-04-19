select * from workflow_base where workflowname like '%¹º%'

alter table formtable_main_69_dt1 alter column xqsl decimal(15, 2) 

select * from workflow_billfield where billid = '-69' and viewtype = '1'

update workflow_billfield set fielddbtype = 'decimal(15,2)',type = '3' where id = '7842'
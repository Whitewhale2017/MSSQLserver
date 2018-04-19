--合同简写
select * from formtable_main_216
--流程表单ID
select * from workflow_base where id in (select workflowid from workflow_requestbase where requestid = '129089')

select * from formtable_main_170 where requestid = '129089'

select * from temp_htxx where htbh like 'RJSF201%' order by htbh desc

select * from counter_middle where company = 'RJSF'

--update formtable_main_170 set HTBH = 'RJSF201610313123',gssxnew = 'RJSF' where id = '315'
--update counter_middle set code = '3123' where id = '4'
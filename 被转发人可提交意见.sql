update formtable_main_152 set ysjg=0 where requestId='107585'


select * from workflow_Forward where requestid=122437 and BeForwardid in (1101524,1100516)

select (select id from hrmresource where id=userid) as id,(select lastname from hrmresource where id=userid) as name ,* from workflow_currentoperator where  requestid='122437'
select * from hrmresource where lastname='Ô¬½Ü' --2799
select * from hrmresource where lastname='Ñ¦º£ÌÎ' --65

--122437	1096283	1101524	1	0	0	1	1	0	0	0	0	0	1	1	1	1
--122437	1096283	1100515	1	0	0	1	1	0	0	0	0	0	1	0	0	1
--122437	1096283	1100514	1	0	0	1	1	0	0	0	0	0	1	0	0	1
--122437	1096283	1100517	1	0	0	1	1	0	0	0	0	0	1	0	0	1
--122437	1100517	1103883	1	0	1	1	1	0	0	0	1	1	1	1	1	1
--122437	1096283	1100516	1	0	0	1	1	0	0	0	0	0	1	0	0	1

update workflow_Forward set IsBeForwardSubmitAlready=1,IsBeForwardSubmitNotaries=1 where requestid='122437' and BeForwardid='1100516'
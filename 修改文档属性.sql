select * from DocDetail where docsubject like  '%���ڷ�����������Ա�������ƶȡ���֪ͨ%'  and docExtendName='doc' and docstatus=9  

 ---docstatus 9 ���̲ݸ� 2��ʽ

update DocDetail set docstatus=2 where id=73468

select * from DocDetail where docsubject like  '%���칫����%' 

update DocDetail set subcategory=38,seccategory=43 where id='48505'

select * from DocSecCategory where categoryname = '���ŷ���-֪ͨ'

select * from DocSubCategory where id = '38'

select * from formtable_main_257_dt1

------�޸���������ĸ���
select * from DocDetail where id in (65894,66260)

select * from workflow_requestLog where requestid in (127627,128264)

select * from workflow_requestLog where requestid='127627' and nodeid=1512

update workflow_requestLog set  annexdocids='65894' where  requestid=127627 and nodeid=1512
 






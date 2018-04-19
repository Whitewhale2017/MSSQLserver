use ecology
select * from view_PersonInfo;
sp_help sysobjects;

select xtype from sysobjects group by xtype;

select top 5 * from sysobjects where xtype='U' and name like '%doc%';

select * from workflowactionview;

sp_help docmark;

select * from DocDetail;


delete  FROM workflow_requestLog WHERE remark LIKE '%12345678%' --É¾³ýÉóÅúÒâ¼û

select * from workflow_requestLog;







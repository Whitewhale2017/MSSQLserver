select lastname,subcompanyid1,departmentid from hrmresource where subcompanyid1 is null

select lastname,subcompanyid1,departmentid from hrmresource where subcompanyid1=0

update hrmresource set  subcompanyid1=(select subcompanyid1 from HrmDepartment where id=HrmResource.departmentid) where subcompanyid1=0

select * from HrmDepartment where id=462


select XM,RSGX,RSGXQ,YDBM,YDBMQ from formtable_main_101

update formtable_main_101 set  rsgx=(select subcompanyid1 from HrmDepartment where id=formtable_main_101.YDBM) where rsgx is null

select * from formtable_main_247 where requestId='97728'

update formtable_main_247 set sqr='477',sqbm='632',sqgs='5' where requestId='97728'

select * from workflow_requestbase where workflowid='414'


select * from HrmResource where id=477

use ecology
go
if exists(select * from sysobjects where name='ecology.dbo.sqrxxbg') drop function dbo.sqrxxbg
go
create proc sqrxxbg
@workflowid varchar
as 
update formtable_main_247 set 
sqr=(select creater from workflow_requestbase where requestid=formtable_main_247.requestId),

where requestId in (select requestid from workflow_requestbase where workflowid=@workflowid£©


go






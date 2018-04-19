select * from workflow_requestlog where requestid='73565'

delete  from workflow_requestlog where requestid='73525' and operator='1'

select * from Hrmresource where id='1'

use ecology
go 
if exists(select count(*) from sysobjects where  id='ecology.dbo.shanchuganyuhenji') drop proc dbo.shanchuganyuhenji
go
create proc shanchuganyuhenji
@requestid varchar(50)
as 
delete  from workflow_requestlog where requestid=@requestid and operator='1'


exec shanchuganyuhenji '98218'


select * from workflow_requestlog where requestid=493

delete  from workflow_requestlog where workflowid=95 and operator='1'


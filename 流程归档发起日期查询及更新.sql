select * from formtable_main_104
select * from workflow_requestbase where requestid='77760'
select * from workflow_requestLog where requestid='77760'
select * from workflow_currentoperator where requestid='77760' order by receivedate
select gdrq from formtable_main_146
update formtable_main_146 set gdrq=null
update formtable_main_146
set formtable_main_146.gdrq=b.lastoperatedate
from workflow_requestbase b
where formtable_main_146.requestid=b.requestid and b.currentnodetype=3

update formtable_main_146 set gdrq=null

select * from formtable_main_146

update formtable_main_146
set formtable_main_146.sqrq=b.createdate
from workflow_requestbase b
where formtable_main_146.requestid=b.requestid 

use ecology
go
if exists(select * from sysobjects where name='Genxin_gdrq_sqrq') drop proc dbo.Genxin_gdrq_sqrq
go 
create proc Genxin_gdrq_sqrq @Tablename nvarchar(1000)
as
declare @SQLstr nvarchar(1000)
declare @SQLstr1 nvarchar(1000)
begin
  set @SQLstr=N'update '+@Tablename+' set '+@Tablename+'.gdrq=b.lastoperatedate from workflow_requestbase b where '+@Tablename+'.requestid=b.requestid and b.currentnodetype=3'
  --select @SQLstr
  set @SQLstr1=N'update '+@Tablename+' set '+@Tablename+'.sqrq=b.createdate from workflow_requestbase b where '+@Tablename+'.requestid=b.requestid'
  --select @SQLstr1
  Execute sp_executesql @SQLStr 
  Execute sp_executesql @SQLStr1
end



exec Genxin_gdrq_sqrq formtable_main_150

select * from formtable_main_227

select requestId,tbrq,sqrq,gdrq from formtable_main_101


update formtable_main_219 set gdrq=null
update formtable_main_219 set sqrq=null
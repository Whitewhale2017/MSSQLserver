select * from formtable_main_106
select * from workflow_requestLog
use ecology
select HGEducationLevel from HrmResource

if exists (select * from sysobjects where name='proc_randCardID')
drop proc proc_randCardID
go
create proc proc_randCardID
--@str char(19),
@randCardID char(19) OUTPUT
as
declare @r varchar(50)
SELECT  @r = convert(numeric(19,8),Rand())
SET @randCardID =SUBSTRING(@r,3,8)
--set @randCardID =@str+stuff(@randCardID,5,0,' ')
set @randCardID =stuff(@randCardID,5,0,' ')
go







create table mytest
(
  id char(19)
 )
drop table mytest


if exists (select * from sysobjects where name='proc_myTest')
drop proc proc_myTest
go
create proc proc_myTest
as
select * from HrmResource
go
exec proc_myTest

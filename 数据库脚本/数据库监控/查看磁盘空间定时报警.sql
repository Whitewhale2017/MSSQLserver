use master
go
if exists(select * from sys.objects where name='diskSpace' and type_desc='USER_TABLE')
drop table diskSpace
go
create table diskSpace
(
	drive varchar(10),
	diskSpace bigint
)
insert into diskSpace values('C',102400)
insert into diskSpace values('D',111616)
insert into diskSpace values('E',162816)
insert into diskSpace values('F',98099)
go
if exists(select * from sys.objects where name='diskSpaceAlert')
drop proc diskSpaceAlert
go
create proc diskSpaceAlert
as
create table #diskSpace
(
	drive varchar(10),
	freeSpace bigint
)
insert into #diskSpace
exec master.dbo.xp_fixeddrives

declare @disk varchar(10)
declare @diskSpace bigint
declare @freeSpace bigint
declare @emailcontent nvarchar(500)
set @emailcontent=N''
declare cur cursor for select drive,diskSpace from diskSpace
open cur
fetch cur into @disk,@diskSpace
while @@FETCH_STATUS=0
begin
	select @freeSpace=freeSpace from #diskSpace where drive=@disk
	if(@freeSpace*1.0/@diskSpace<0.1)
	begin
		set @emailcontent=@emailcontent+N'磁盘：'+@disk+N' 的剩余空间为：'+CONVERT(varchar(50),@freeSpace)+N'MB，不足该磁盘的10%，请及时处理！'+CHAR(10)
	end
	fetch cur into @disk,@diskSpace
end
close cur
deallocate cur
drop table #diskSpace
--发送邮件
--@profile_name：数据库邮件的配置文件，不填则为默认的配置文件，如果没有配置数据库邮件，会导致邮件发送报错
--@recipients：收件人，多个可以用逗号隔开
--@copy_recipients：抄送人，多个可以用逗号隔开
--@subject：邮件标题
--@body：邮件内容
--@importance：重要性，normal,less,high
exec msdb..sp_send_dbmail @profile_name=N'diskSpaceAlert', @recipients=N'liling@hofan.cn',@copy_recipients =N'donglianxing@hofan.cn',@subject =N'磁盘空间不足',@body =@emailcontent,@importance =N'High'
go

exec diskSpaceAlert
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
		set @emailcontent=@emailcontent+N'���̣�'+@disk+N' ��ʣ��ռ�Ϊ��'+CONVERT(varchar(50),@freeSpace)+N'MB������ô��̵�10%���뼰ʱ����'+CHAR(10)
	end
	fetch cur into @disk,@diskSpace
end
close cur
deallocate cur
drop table #diskSpace
--�����ʼ�
--@profile_name�����ݿ��ʼ��������ļ���������ΪĬ�ϵ������ļ������û���������ݿ��ʼ����ᵼ���ʼ����ͱ���
--@recipients���ռ��ˣ���������ö��Ÿ���
--@copy_recipients�������ˣ���������ö��Ÿ���
--@subject���ʼ�����
--@body���ʼ�����
--@importance����Ҫ�ԣ�normal,less,high
exec msdb..sp_send_dbmail @profile_name=N'diskSpaceAlert', @recipients=N'liling@hofan.cn',@copy_recipients =N'donglianxing@hofan.cn',@subject =N'���̿ռ䲻��',@body =@emailcontent,@importance =N'High'
go

exec diskSpaceAlert
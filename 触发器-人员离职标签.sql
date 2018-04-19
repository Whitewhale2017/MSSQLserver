alter TRIGGER tr_lz_bq
on ecology8.dbo.hrmresource
after update
AS
if (update(status))
BEGIN
declare @lzid int,@name varchar(50),@status int
select @lzid=id,@name=lastname,@status=status from inserted
if (@status=5)
  begin
    update hrmresource set lastname=replace(@name,'(LZ)','') where id=@lzid
    update hrmresource set lastname=lastname+'(LZ)' where id=@lzid
  end
else
  begin
   update hrmresource set lastname=replace(@name,'(LZ)','') where id=@lzid
  end
END

drop trigger tr_lz_bq
begin try
declare @str nvarchar(100)
set @str='dlskjfowieowpjdklsj'
create table #temp(name nvarchar(10))
insert into #temp values(@str)
end try
begin catch
declare @i int
set @i=@@ERROR
IF(@i>0)
BEGIN
select text from sys.messages where message_id=@i and language_id=2052
END
end catch
DROP TABLE #temp

select * from sys.messages
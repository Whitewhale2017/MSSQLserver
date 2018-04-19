
-----定义局部游标需加@，且不能定义时赋值---------
declare @my_cur1 cursor 
set @my_cur1=cursor scroll for (select id,lastname,workcode from hrmresource)
open @my_cur1
declare @id char(10)
declare @name char(10)
declare @workcode char(10)
fetch next from @my_cur1 into @id,@name,@workcode
while @@FETCH_STATUS=0
     begin
	   print @id +@name+@workcode
	 fetch next from @my_cur1 into @id,@name,@workcode
	 end
close @my_cur1 --局部游标自动释放
deallocate @my_cur1


-----定义全局游标不能加@，且需要定义时赋值---------
declare my_cursor cursor for (select id,lastname,workcode from hrmresource) 
open my_cursor
declare @id char(10)
declare @name char(10)
declare @workcode char(10)
fetch next from my_cursor into @id,@name,@workcode
 while @@FETCH_STATUS=0
    begin
     print @id +@name+@workcode
	 fetch next from my_cursor into @id,@name,@workcode
	 end
close my_cursor  --全局游标需语句释放
deallocate my_cursor
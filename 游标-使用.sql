
-----����ֲ��α����@���Ҳ��ܶ���ʱ��ֵ---------
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
close @my_cur1 --�ֲ��α��Զ��ͷ�
deallocate @my_cur1


-----����ȫ���α겻�ܼ�@������Ҫ����ʱ��ֵ---------
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
close my_cursor  --ȫ���α�������ͷ�
deallocate my_cursor
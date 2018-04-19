declare @test_cursor cursor 
set @test_cursor=cursor local scroll for
select * from HrmResource


declare test_cursor2 cursor global scroll for
select departmentname from HrmDepartment

deallocate test_cursor2

open test_cursor2
declare @pr nvarchar(200)
fetch next from test_cursor2 into @pr
print @pr
fetch last from test_cursor2 into @pr
print @pr
fetch first from test_cursor2 into @pr
print @pr
close test_cursor2



go
open @test_cursor
go
open test_cursor2
go
close test_cursor2
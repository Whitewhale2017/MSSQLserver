select * from MatrixInfo
select * from Matrixtable_4


select * from HrmRoles
select * from HrmRoleMembers

select id,lastname,status from hrmresource where status=5

drop proc isexists_col
----�洢���̴�������----����һ-----------------
alter proc isexists_col(@tablename varchar(50),@fstr varchar(50),@res int output)
as
begin
--declare @res int
set @res=0
declare col_cursor cursor for 
SELECT Name FROM SysColumns where ID = Object_Id(@tablename)
open col_cursor
declare @colname varchar(50)
fetch next from col_cursor into @colname
while @@FETCH_STATUS=0
begin
declare @sqlstr nvarchar(500),@tempres int
set @sqlstr=N'select @countout=count(*) from '+@tablename+' where '+@colname+' like ''%,'+@fstr+',%'' or '+@colname+' like ''%,'+@fstr+''' or '+@colname+' like '''+@fstr+',%'' or '+@colname+' like '+@fstr
exec sp_executesql @sqlstr,N'@countout int out',@countout=@tempres output
set @res=@res+@tempres
fetch next from col_cursor into @colname
end 
close col_cursor
deallocate col_cursor
end

declare @fin int
exec isexists_col 'Matrixtable_4','2138',@fin output
select @fin as fin
----------------------------------------������----------------------------------------------------------------------
alter proc isexists_col(@tablename varchar(50),@fstr varchar(50))
as
begin
declare @res int
set @res=0
declare col_cursor cursor for 
SELECT Name FROM SysColumns where ID = Object_Id(@tablename)
open col_cursor
declare @colname varchar(50)
fetch next from col_cursor into @colname
while @@FETCH_STATUS=0
begin
declare @sqlstr nvarchar(500),@tempres int
set @sqlstr=N'select @countout=count(*) from '+@tablename+' where '+@colname+' like ''%,'+@fstr+',%'' or '+@colname+' like ''%,'+@fstr+''' or '+@colname+' like '''+@fstr+',%'' or '+@colname+' like '+@fstr
exec sp_executesql @sqlstr,N'@countout int out',@countout=@tempres output
set @res=@res+@tempres
fetch next from col_cursor into @colname
end 
close col_cursor
deallocate col_cursor
return @res
end

declare @fin int
exec @fin=isexists_col 'Matrixtable_4','2138'
select @fin as fin




----------------------------------------------------------------------------------------------------------------------
select * from SysColumns
SELECT Name FROM SysColumns where ID = Object_Id('HrmRoles')

--https://www.cnblogs.com/RascallySnake/archive/2010/05/20/1739839.html

declare @i_counts int,@i_times  int,@str_sql nvarchar(1000),@str_dbname nvarchar(100);

set @str_sql = 'select @tmp_counts = counts, @tmp_times=times '
             + '  from ' +@str_dbname+ '.dbo.t_msisdn with(nolock) '; 

exec sp_executesql @str_sql,N'@tmp_counts int output, @tmp_times int output',
                         @tmp_counts = @i_counts output,      --����
                         @tmp_times=@i_times output;  --ʱ��

select @i_counts as 'counts', @i_times as 'times'
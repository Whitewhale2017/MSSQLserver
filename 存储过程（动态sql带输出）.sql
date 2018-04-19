----存储过程带出参数----方法一-----------------
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
----------------------------------------方法二----------------------------------------------------------------------
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

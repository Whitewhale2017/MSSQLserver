DECLARE @IntVariable int;
DECLARE @SQLString nvarchar(500);
DECLARE @ParmDefinition nvarchar(500);
DECLARE @max_title varchar(30);

SET @IntVariable = 0;
SET @SQLString = N'SELECT @max_titleOUT = max(jobtitle) 
   FROM HrmResource
   WHERE joblevel = @level';
SET @ParmDefinition = N'@level tinyint, @max_titleOUT varchar(30) OUTPUT';
EXECUTE sp_executesql @SQLString, @ParmDefinition, @level = @IntVariable, @max_titleOUT=@max_title OUTPUT;
SELECT @max_title;
--------------------------------------------------------------------------------------------------------------------------
----------sql_executesql不能直接传递表名作为参数------------------------------------------------------------------------------
declare @tablename varchar(50),@colname varchar(50),@fstr varchar(50),@res int
declare @sqlstr nvarchar(500)
set @tablename='Matrixtable_6'
set @colname='cgzy'
set @fstr='1405'

set @sqlstr=N'select @countout=count(*) from '+@tablename+' where '+@colname+' like ''%,'+@fstr+',%'' or '+@colname+' like ''%,'+@fstr+''' or '+@colname+' like '''+@fstr+',%'' or '+@colname+' like '+@fstr
exec sp_executesql @sqlstr,N'@countout int out',@countout=@res output
select @res

select count(*) from Matrixtable_4 where zzglg like '2138'

select * from Matrixtable_6 where cgzy like '%,1405,%' or cgzy like '%,1405' or cgzy like '1405,%' or cgzy like '1405'
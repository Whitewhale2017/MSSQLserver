--------------------------------行转列测试数据：--------------------------------------
--测试数据
if not object_id(N'Tempdb..#T') is null
    drop table #T
Go
Create table #T([Name] nvarchar(22),[Subject] nvarchar(22),[Score] int)
Insert #T
select N'李四',N'语文',60 union all
select N'李四',N'数学',70 union all
select N'李四',N'英语',80 union all
select N'张三',N'语文',90 union all
select N'张三',N'数学',80 union all
select N'张三',N'英语',70
Go
--测试数据结束

select * from #T
delete from #T where name='李四' and Subject='英语'

select name,语文,数学,isnull(英语,0) as 英语,物理 from (
select * from #T
pivot(max(score) for subject in (语文,数学,英语,物理)) as maxscore
) t

--动态写法（加上了总分和平均分）：

DECLARE @sql VARCHAR(MAX)
SET @sql = 'select Name'
SELECT  @sql = @sql + ',max(case Subject when ''' + Subject
        + ''' then Score else 0 end)[' + Subject + ']'
FROM    ( SELECT DISTINCT
                    Subject
          FROM      #T
        ) a
SET @sql = @sql
    + ',sum(Score) 总分,cast(avg(Score*1.0) as decimal(18,2)) 平均分 from #T group by Name'
EXEC(@sql)
--动态的也可以使用pivot：

DECLARE @sql VARCHAR(MAX)
SELECT @sql=isnull(@sql+',','')+Subject FROM #T GROUP BY Subject
SET @sql='select m.* , n.总分, n.平均分 from
        (
		  select * 
		  from (select * from #T) a 
		  pivot (max(Score) for Subject in ('+@sql+')) b
		  ) m ,
         (
		 select Name,sum(Score)总分, cast(avg(Score*1.0) as decimal(18,2))平均分 
		 from #T 
		 group by Name
		 ) n
         where m.Name= n.Name'
exec(@sql)



--------------------------列转行的测试数据：---------------------------------------------------
--测试数据 
if not object_id(N'Tt') is null
drop table Tt
Go
Create table Tt([姓名] nvarchar(22),[语文] int,[数学] int,[英语] int)
Insert Tt
select N'张三',60,70,80 
union all
select N'李四',90,80,70
Go
--测试数据结束
-- 动态写法：

DECLARE @sql VARCHAR(8000)
SELECT @sql=isnull(@sql+' union all ','')+' select 姓名, [课程]='
+quotename(Name,'''')+' , [分数] = '+quotename(Name)+' from T'
FROM syscolumns
WHERE Name!='姓名' AND ID=object_id('T')--表名tb，不包含列名为姓名的其他列
ORDER BY colid
EXEC(@sql+' order by 姓名')
 --同样的动态写法也可以使用 unpivot：


DECLARE @sql VARCHAR(8000)
SELECT @sql=isnull(@sql+',','')+quotename(Name)
FROM syscolumns
WHERE ID=object_id('T')AND Name NOT IN('姓名')
ORDER BY Colid
SET @sql='select 姓名,[课程],[分数] from T unpivot ([分数] for [课程] in('+@sql+'))b'
exec(@sql)
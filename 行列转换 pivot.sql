--------------------------------��ת�в������ݣ�--------------------------------------
--��������
if not object_id(N'Tempdb..#T') is null
    drop table #T
Go
Create table #T([Name] nvarchar(22),[Subject] nvarchar(22),[Score] int)
Insert #T
select N'����',N'����',60 union all
select N'����',N'��ѧ',70 union all
select N'����',N'Ӣ��',80 union all
select N'����',N'����',90 union all
select N'����',N'��ѧ',80 union all
select N'����',N'Ӣ��',70
Go
--�������ݽ���

select * from #T
delete from #T where name='����' and Subject='Ӣ��'

select name,����,��ѧ,isnull(Ӣ��,0) as Ӣ��,���� from (
select * from #T
pivot(max(score) for subject in (����,��ѧ,Ӣ��,����)) as maxscore
) t

--��̬д�����������ֺܷ�ƽ���֣���

DECLARE @sql VARCHAR(MAX)
SET @sql = 'select Name'
SELECT  @sql = @sql + ',max(case Subject when ''' + Subject
        + ''' then Score else 0 end)[' + Subject + ']'
FROM    ( SELECT DISTINCT
                    Subject
          FROM      #T
        ) a
SET @sql = @sql
    + ',sum(Score) �ܷ�,cast(avg(Score*1.0) as decimal(18,2)) ƽ���� from #T group by Name'
EXEC(@sql)
--��̬��Ҳ����ʹ��pivot��

DECLARE @sql VARCHAR(MAX)
SELECT @sql=isnull(@sql+',','')+Subject FROM #T GROUP BY Subject
SET @sql='select m.* , n.�ܷ�, n.ƽ���� from
        (
		  select * 
		  from (select * from #T) a 
		  pivot (max(Score) for Subject in ('+@sql+')) b
		  ) m ,
         (
		 select Name,sum(Score)�ܷ�, cast(avg(Score*1.0) as decimal(18,2))ƽ���� 
		 from #T 
		 group by Name
		 ) n
         where m.Name= n.Name'
exec(@sql)



--------------------------��ת�еĲ������ݣ�---------------------------------------------------
--�������� 
if not object_id(N'Tt') is null
drop table Tt
Go
Create table Tt([����] nvarchar(22),[����] int,[��ѧ] int,[Ӣ��] int)
Insert Tt
select N'����',60,70,80 
union all
select N'����',90,80,70
Go
--�������ݽ���
-- ��̬д����

DECLARE @sql VARCHAR(8000)
SELECT @sql=isnull(@sql+' union all ','')+' select ����, [�γ�]='
+quotename(Name,'''')+' , [����] = '+quotename(Name)+' from T'
FROM syscolumns
WHERE Name!='����' AND ID=object_id('T')--����tb������������Ϊ������������
ORDER BY colid
EXEC(@sql+' order by ����')
 --ͬ���Ķ�̬д��Ҳ����ʹ�� unpivot��


DECLARE @sql VARCHAR(8000)
SELECT @sql=isnull(@sql+',','')+quotename(Name)
FROM syscolumns
WHERE ID=object_id('T')AND Name NOT IN('����')
ORDER BY Colid
SET @sql='select ����,[�γ�],[����] from T unpivot ([����] for [�γ�] in('+@sql+'))b'
exec(@sql)

GO
IF OBJECT_ID('TBL')IS NOT NULL
DROP TABLE TBL
GO
CREATE TABLE TBL(
���� DATE
)
GO
INSERT TBL
SELECT '2012-03-01' UNION ALL
SELECT '2012-03-31'


--���õݹ�ʵ��������·ݵ��������ڣ�
go
declare @date date
select @date=MAX(����) from tbl
;with t
as(
select * from tbl
union all
select dateadd(dd,1,a.����) from t a
where not exists(select * from tbl b
where b.����=DATEADD(DD,1,a.����)
)
and a.����<@date
)
select *from t order by ����

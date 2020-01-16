
GO
IF OBJECT_ID('TBL')IS NOT NULL
DROP TABLE TBL
GO
CREATE TABLE TBL(
日期 DATE
)
GO
INSERT TBL
SELECT '2012-03-01' UNION ALL
SELECT '2012-03-31'


--利用递归实现输出三月份的所有日期：
go
declare @date date
select @date=MAX(日期) from tbl
;with t
as(
select * from tbl
union all
select dateadd(dd,1,a.日期) from t a
where not exists(select * from tbl b
where b.日期=DATEADD(DD,1,a.日期)
)
and a.日期<@date
)
select *from t order by 日期

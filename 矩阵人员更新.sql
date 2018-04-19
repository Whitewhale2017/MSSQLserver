USE [ecology8]
GO

/****** Object:  StoredProcedure [dbo].[proc_jzbbj]    Script Date: 2017/8/1 17:54:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[proc_jzbbj](@bm varchar(5000),@sx int,@dyry varchar(100))
as 
begin
--declare @sx int
--declare @dyry varchar(500)
--declare @bm varchar(2000)
--set @sx=1 
--set @dyry='1432'
--set @bm='4,59'
--select @sx,@dyry,@bm
update HrmDepartmentDefined
set 
rszy=(case when @sx=0 then @dyry else rszy end),
kqzy=(case when @sx=1 then @dyry else kqzy end),
xzzy=(case when @sx=2 then @dyry else xzzy end),
flzy=(case when @sx=3 then @dyry else flzy end)
where cast(deptid as varchar) in (select * from dbo.SplitStr(@bm,','))

update Matrixtable_6
set 
rszy=(case when @sx=0 then @dyry else rszy end),
kqzy=(case when @sx=1 then @dyry else kqzy end),
xzzy=(case when @sx=2 then @dyry else xzzy end),
flzy=(case when @sx=3 then @dyry else flzy end)
where cast(id as varchar) in (select * from dbo.SplitStr(@bm,','))
end
GO



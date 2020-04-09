drop trigger tri_update_Matrixtable_2;
CREATE TRIGGER tri_update_Matrixtable_2
   ON [dbo].[HrmDepartmentDefined]
   AFTER UPDATE
AS 
BEGIN
    declare @deptid varchar(1000)
    declare @zz varchar(1000),@bmjl varchar(1000),@zxzj varchar(1000),@zjj2 varchar(1000)
	declare @bmfg varchar(1000),@gsld varchar(1000),@jjqxr varchar(1000)
	select @deptid=deptid from inserted
	select @zz=cast(zz as varchar(1000)),@bmjl=cast(bmjl as varchar(1000)),@zxzj=cast(zxzj as varchar(1000))
	      ,@zjj2=cast(zjj2 as varchar(1000)),@bmfg=cast(bmfg as varchar(1000)),@gsld=cast(gsld as varchar(1000))
		  ,@jjqxr=cast(jjqxr as varchar(1000)) from HrmDepartmentDefined where deptid=@deptid
	update Matrixtable_2 set zz=@zz,bmjl=@bmjl,zxzj=@zxzj,zjj2=@zjj2,bmfg=@bmfg,gsld=@gsld,jjqxr=@jjqxr where id=@deptid
END
GO


select * from (
select a.deptid,b.departmentname,
case when cast(a.zz as varchar(100))=c.zz then 'Y' else cast(a.zz as varchar(100)) end as zz
,case when cast(a.bmjl as varchar(100))=c.bmjl then 'Y' else cast(a.bmjl as varchar(100)) end as bmjl
,case when cast(a.zxzj as varchar(100))=c.zxzj then 'Y' else cast(a.zxzj as varchar(100)) end as zxzj
,case when cast(a.zjj2 as varchar(100))=c.zjj2 then 'Y' else cast(a.zjj2 as varchar(100)) end as zjj2 
,case when cast(a.bmfg as varchar(100))=c.bmfg then 'Y' else cast(a.bmfg as varchar(100)) end as bmfg 
,case when cast(a.gsld as varchar(100))=c.gsld then 'Y' else cast(a.gsld as varchar(100)) end as gsld 
,case when cast(a.jjqxr as varchar(100))=c.jjqxr then 'Y' else cast(a.jjqxr as varchar(100)) end as jjqxr 
from HrmDepartmentDefined a
inner join HrmDepartment b
on a.deptid=b.id and (b.canceled is null or b.canceled=0) 
left join  Matrixtable_2  c
on a.deptid=c.id
)T 
where T.zz<>'Y' or T.bmjl<>'Y'or T.zxzj<>'Y'or T.zjj2<>'Y'or T.bmfg<>'Y'or T.gsld<>'Y'or T.jjqxr<>'Y'

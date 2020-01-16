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

select deptid,zz,bmjl,zxzj,zjj2,bmfg,gsld,jjqxr from HrmDepartmentDefined where deptid='476'
select id,zz,bmjl,zxzj,zjj2,bmfg,gsld,jjqxr from Matrixtable_2  where id='476'

update HrmDepartmentDefined set zjj2='325,67' where deptid='476'


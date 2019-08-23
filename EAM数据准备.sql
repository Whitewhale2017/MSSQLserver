	select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,zclb from uf_fixedassets order by id desc

select id,sybmbh,zzbh from uf_fixedassets where len(sybmbh)<>6

-----------------编号中设备类别不符合规范------------------
select id,zzbh,substring(zzbh,2,2) from uf_fixedassets  where id not in (
select id from uf_fixedassets 
where substring(zzbh,2,2) in (select lbsx from uf_sblb)  
) --财务固定资产

select id,zzbh,substring(zzbh,2,2) from uf_zxgdzc  where id not in (
select id from uf_zxgdzc 
where substring(zzbh,2,2) in (select lbsx from uf_sblb) 
)  --中心固定资产




------------编号长度不符合规范---------
select * from uf_fixedassets where len(zzbh)<>9 --财务固定资产
select zzbh,* from uf_zxgdzc where len(zzbh)<>9 --中心固定资产 

------------编号重复---------


select * from uf_fixedassets where zzbh in (select zzbh from uf_fixedassets group by zzbh having count(1)>1) order by zzbh --财务固定资产 


select zzbh,* from uf_zxgdzc a
where a.zzbh in (select zzbh from uf_zxgdzc group by zzbh having count(1)>1)  
order by a.zzbh --中心固定资产 

alter view [dbo].[v_fixedassets]
as
select id,zzbh,sapzzbh,sbmc,sbxh,zclb,ysrq,whr,cfwz,ssqy,zclbyj,0 as gdzc from uf_fixedassets --财务固定资产
union all 
select id,zzbh,null as sapzzbh,sbmc,sbxh,zclb,ysrq,whr,cfwz,ssqy,zclbyj,1 as gdzc from uf_zxgdzc --中心固定资产

select * from [v_fixedassets]



alter view v_gdzcsjyc
as
select a.*,0 as gzyy from v_fixedassets a where len(zzbh)<>9 --'编号长度不符合规范'
union all
select a.*,1 as gzyy from v_fixedassets a  --'设备类别缩写不符合规则'
where substring(zzbh,2,2) <> (select lbsx from uf_sblb where id=substring(a.zclb,3,3))  
union all 
select a.*,2 as gzyy  from v_fixedassets a   --'区域缩写不符合规则'
where substring(zzbh,1,1) <> (select sx from uf_gdzcssqy where id=a.ssqy)  and ssqy<>1 and zclbyj<>6
union all
select a.*,3 as gzyy from v_fixedassets a 
where zzbh in (select zzbh from v_fixedassets group by zzbh having count(1)>1)  --'资产编号重复'
--

--


--select zzbh,sbmc,sbxh,replace(cast(sbxh as varchar(1000)),' ','') from uf_fixedassets where zzbh like 'PMY%'

--update  uf_fixedassets set sbxh=replace(cast(sbxh as varchar(1000)),' ','') where zzbh like 'PMY%'
-------------------------更新重名人员----------------------------
update uf_fixedassets set whr='1709' where id in (
select a.id-- ,a.zzbh,a.whr,b.lastname 
from uf_fixedassets a
left join hrmresource b
on cast(a.whr as varchar(4))=cast(b.id as varchar(4))
where b.lastname='王丽'
)

update uf_fixedassets set syr='1709' where id in (
select a.id--,a.zzbh,a.syr,b.lastname 
from uf_fixedassets a
left join hrmresource b
on cast(a.syr as varchar(4))=cast(b.id as varchar(4))
where b.lastname='张波'
)

update 	uf_zxgdzc set whr='1709' where id in (
select a.id 
--,a.zzbh,a.whr,b.lastname 
from uf_zxgdzc a
left join hrmresource b
on cast(a.whr as varchar(4))=cast(b.id as varchar(4))
where b.lastname='王丽'
)

update 	uf_zxgdzc set syr='1709' where id in (
select a.id 
--,a.zzbh,a.syr,b.lastname 
from uf_zxgdzc a
left join hrmresource b
on cast(a.syr as varchar(4))=cast(b.id as varchar(4))
where b.lastname='张波'
)
--------------------------------------------------------------------
select id,sblb,lbsx from uf_sblb
select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,substring(zzbh,2,2),zclb,zclbyj as sblsx from uf_fixedassets 

--------------更新设备类型（树形按钮）--------------------------------
update uf_fixedassets set zclb='5_'+cast(lb.id as varchar(2)) from uf_sblb lb where substring(zzbh,2,2)=lb.lbsx --财务固定资产

update 	uf_zxgdzc set zclb='5_'+cast(lb.id as varchar(2)) from uf_sblb lb where substring(zzbh,2,2)=lb.lbsx --中心固定资产


-------------------------------------------------------------------
------------------------------------------------------------------------
--------------表单建模保存数据是先insert关键信息，然后update自定义信息------------------------

-----------------变更自动生成的编号---------------------------------------------
alter trigger tri_zcbh_uf_fixedassets
on uf_fixedassets
after update
as
if update(fzzcbh)
begin
   declare @bh varchar(20),@id int
   select @id=id,@bh=fzzcbh from inserted
   update uf_fixedassets set zzbh=left(@bh,3)+right(@bh,6) where id=@id
end;
-------------------------------------------------------------------------

--create trigger tri_eam_fixedassets
--on uf_fixedassets
--after update
--as
--begin
--   declare @id int,@zzbh varchar(20),@sapzzbh varchar(50),@sbmc varchar(50)
--   declare @ysrq varchar(50),@cfwz varchar(50),@ssqy varchar(50),@zclbyj varchar(50)
--   select @id=id from inserted
--   if exists(select id from openquery([EAM],'select id from uf_fixedassets ') where id=@id)
--   begin
--   select  @zzbh=zzbh,@sapzzbh=sapzzbh,@sbmc=sbmc,@ysrq=ysrq,@cfwz=cfwz,@ssqy=gd.qy,@zclbyj=ws.selectname from inserted uf
--    left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
--    left join uf_gdzcssqy gd on gd.id=uf.ssqy
--   update openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets ')  
--   set zzbh=@zzbh,sapzzbh=@sapzzbh,sbmc=@sbmc,sbxh=@sbxh,ysrq=@ysrq,cfwz=@cfwz,ssqy=@ssqy,zclbyj=@zclbyj where id=@id
--   end
--   else
--   begin
--	insert into  openquery([EAM],'select id,zzbh,sapzzbh,sbmc,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets ')  
--	select id,zzbh,sapzzbh,sbmc,ysrq,cfwz,ssqy,zclbyj from inserted
--   end
--end;

alter table uf_fixedassets disable trigger tri_eam_fixedassets
----注意：text类型不用用在触发器的inserted\deleted表中--------------

-------------------插入财务固定资产数据--------------------
 select * from openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets') ;

insert into  openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets ')  
select  uf.id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj from uf_fixedassets uf
 left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
 left join uf_gdzcssqy gd on gd.id=uf.ssqy

 -----------------插入中心固定资产数据-------------------
 select * from openquery([EAM],'select id,zzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_centralassets ') ;

insert into  openquery([EAM],'select id,zzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_centralassets ')  
select  uf.id,zzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj 
,b.lastname as syr,c.bmfl as sybm,cast(uf.bz as varchar(2000)) as bz
from uf_zxgdzc uf
 left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
 left join uf_gdzcssqy gd on gd.id=uf.ssqy
   left join hrmresource b on uf.syr=b.id
   left join uf_bmbh c on uf.sybm=c.bmbh


------------------------------------------------
alter proc prc_insert_update_eam (@id int)
as
begin
   if exists(select id from openquery([EAM],'select id from uf_fixedassets ') where id=@id)
   begin
   declare @zzbh varchar(20),@sapzzbh varchar(50),@sbmc varchar(50),@sbxh varchar(2000)
   declare @ysrq varchar(50),@cfwz varchar(50),@ssqy varchar(50),@zclbyj varchar(50)

   select  @zzbh=zzbh,@sapzzbh=sapzzbh,@sbmc=sbmc,@sbxh=cast(sbxh as varchar(2000))
    ,@ysrq=ysrq,@cfwz=cfwz,@ssqy=gd.qy,@zclbyj=ws.selectname from uf_fixedassets uf
    left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
    left join uf_gdzcssqy gd on gd.id=uf.ssqy where uf.id=@id

   update openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets ')  
   set zzbh=@zzbh,sapzzbh=@sapzzbh,sbmc=@sbmc,sbxh=@sbxh,ysrq=@ysrq,cfwz=@cfwz,ssqy=@ssqy,zclbyj=@zclbyj where id=@id
   end 
   else 
   begin
   insert into  openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets ')  select  uf.id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj from uf_fixedassets uf
   left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
   left join uf_gdzcssqy gd on gd.id=uf.ssqy where uf.id=@id
   end
end;

exec prc_insert_update_eam 4841
---------------------------------------------------------

-------------------------批量插入数据更新进入EAM MYSQL数据库-----------------------
create proc prc_insert_eam (@id int)
as
begin
   if not exists(select id from openquery([EAM],'select id from uf_fixedassets ') where id=@id)
   begin
   insert into  openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets ')  select  uf.id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj from uf_fixedassets uf
   left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
   left join uf_gdzcssqy gd on gd.id=uf.ssqy where uf.id=@id
   end
end;

declare cur_temp cursor local scroll
for (select id from uf_fixedassets)
open cur_temp
declare @id int
fetch next from cur_temp into @id
while @@FETCH_STATUS=0
 begin
 exec prc_insert_eam @id
 fetch next from cur_temp into @id
 end
close cur_temp
deallocate cur_temp

-----------------
insert into openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj
,syr,sybm,bz
from uf_fixedassets ')  
    select  uf.id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj
	,b.lastname as syr,c.bmfl as sybm,cast(uf.bz as varchar(2000)) as bz
	 from uf_fixedassets uf
   left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
   left join uf_gdzcssqy gd on gd.id=uf.ssqy 
   left join hrmresource b on uf.syr=b.id
   left join uf_bmbh c on uf.sybm=c.bmbh
   where uf.id not in (select * from openquery([EAM],'select id from uf_fixedassets '))

select * from openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj
,syr,sybm,bz
from uf_centralassets ')  




--------------------
select zzbh,a.syr,a.sybm,a.bz,b.lastname,c.bmfl from uf_fixedassets a
left join hrmresource b
on a.syr=b.id
left join uf_bmbh c
on a.sybm=c.bmbh


select * from openquery([EAM],'select count(id) from uf_fixedassets ')

select a.id,a.zzbh,b.id from uf_fixedassets a
left join  openquery([EAM],'select id,zzbh from uf_fixedassets ') b
on a.id=b.id

--------------------用户名表-------------------------------------------------------------
select loginid,lastname,password from hrmresource 

select * from openquery([EAM],'SELECT * FROM fixedassets.admin')


select * from 
openquery([EAM],'select id,isaccountenabled,isaccountexpired,isaccountlocked,iscredentialsexpired,userid,name,username,password 
from fixedassets.admin ')

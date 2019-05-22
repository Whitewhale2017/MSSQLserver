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
select * from uf_zxgdzc where len(zzbh)<>9 --中心固定资产 

------------编号重复---------


select * from uf_zxgdzc where zzbh in (select zzbh from uf_fixedassets group by zzbh having count(1)>1) --中心固定资产 

create view [dbo].[v_fixedassets]
as
select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,'财务' as cwgdzc from uf_fixedassets
union all 
select id,zzbh,null as sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,'中心' as cwgdzc from uf_zxgdzc


select * from v_fixedassets where zzbh in (select zzbh from v_fixedassets group by zzbh having count(1)>1) --固定资产 


--select zzbh,sbmc,sbxh,replace(cast(sbxh as varchar(1000)),' ','') from uf_fixedassets where zzbh like 'PMY%'

--update  uf_fixedassets set sbxh=replace(cast(sbxh as varchar(1000)),' ','') where zzbh like 'PMY%'

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


insert into  openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets ')  
select  uf.id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj from uf_fixedassets uf
 left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
 left join uf_gdzcssqy gd on gd.id=uf.ssqy


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
insert into  openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets ')  select  uf.id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj from uf_fixedassets uf
   left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
   left join uf_gdzcssqy gd on gd.id=uf.ssqy where uf.id not in (select * from openquery([EAM],'select id from uf_fixedassets '))

--------------------

select * from openquery([EAM],'select count(id) from uf_fixedassets ')

select a.id,a.zzbh,b.id from uf_fixedassets a
left join  openquery([EAM],'select id,zzbh from uf_fixedassets ') b
on a.id=b.id


select loginid,lastname,password from hrmresource 

select * from openquery([EAM],'selec * from barcode_qas.admin')


select * from openquery([EAM],'select id,isaccountenable,isaccountexpired,isaccountlocked,iscredentialsexpired,userid,name,username,password from admin ')

insert into openquery([EAM],'select id,isaccountenable,isaccountexpired,isaccountlocked,iscredentialsexpired,userid,name,username,password from admin ')
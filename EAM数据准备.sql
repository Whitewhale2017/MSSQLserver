select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,zclb from uf_fixedassets order by id desc

select id,sybmbh,zzbh from uf_fixedassets where len(sybmbh)<>6

-----------------������豸��𲻷��Ϲ淶------------------
select id,zzbh,substring(zzbh,2,2) from uf_fixedassets  where id not in (
select id from uf_fixedassets 
where substring(zzbh,2,2) in (select lbsx from uf_sblb)  
) --����̶��ʲ�

select id,zzbh,substring(zzbh,2,2) from uf_zxgdzc  where id not in (
select id from uf_zxgdzc 
where substring(zzbh,2,2) in (select lbsx from uf_sblb) 
)  --���Ĺ̶��ʲ�




------------��ų��Ȳ����Ϲ淶---------
select * from uf_fixedassets where len(zzbh)<>9 --����̶��ʲ�
select * from uf_zxgdzc where len(zzbh)<>9 --���Ĺ̶��ʲ� 

------------����ظ�---------


select * from uf_zxgdzc where zzbh in (select zzbh from uf_fixedassets group by zzbh having count(1)>1) --���Ĺ̶��ʲ� 

create view [dbo].[v_fixedassets]
as
select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,'����' as cwgdzc from uf_fixedassets
union all 
select id,zzbh,null as sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,'����' as cwgdzc from uf_zxgdzc


select * from v_fixedassets where zzbh in (select zzbh from v_fixedassets group by zzbh having count(1)>1) --�̶��ʲ� 


--select zzbh,sbmc,sbxh,replace(cast(sbxh as varchar(1000)),' ','') from uf_fixedassets where zzbh like 'PMY%'

--update  uf_fixedassets set sbxh=replace(cast(sbxh as varchar(1000)),' ','') where zzbh like 'PMY%'

--------------------------------------------------------------------
select id,sblb,lbsx from uf_sblb
select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,substring(zzbh,2,2),zclb,zclbyj as sblsx from uf_fixedassets 

--------------�����豸���ͣ����ΰ�ť��--------------------------------
update uf_fixedassets set zclb='5_'+cast(lb.id as varchar(2)) from uf_sblb lb where substring(zzbh,2,2)=lb.lbsx --����̶��ʲ�

update 	uf_zxgdzc set zclb='5_'+cast(lb.id as varchar(2)) from uf_sblb lb where substring(zzbh,2,2)=lb.lbsx --���Ĺ̶��ʲ�


-------------------------------------------------------------------
------------------------------------------------------------------------
--------------����ģ������������insert�ؼ���Ϣ��Ȼ��update�Զ�����Ϣ------------------------

-----------------����Զ����ɵı��---------------------------------------------
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
----ע�⣺text���Ͳ������ڴ�������inserted\deleted����--------------


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

-------------------------�����������ݸ��½���EAM MYSQL���ݿ�-----------------------
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
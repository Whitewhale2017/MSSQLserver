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
select zzbh,* from uf_zxgdzc where len(zzbh)<>9 --���Ĺ̶��ʲ� 

------------����ظ�---------


select * from uf_fixedassets where zzbh in (select zzbh from uf_fixedassets group by zzbh having count(1)>1) order by zzbh --����̶��ʲ� 


select zzbh,* from uf_zxgdzc a
where a.zzbh in (select zzbh from uf_zxgdzc group by zzbh having count(1)>1)  
order by a.zzbh --���Ĺ̶��ʲ� 

alter view [dbo].[v_fixedassets]
as
select id,zzbh,sapzzbh,sbmc,sbxh,zclb,ysrq,whr,cfwz,ssqy,zclbyj,0 as gdzc from uf_fixedassets --����̶��ʲ�
union all 
select id,zzbh,null as sapzzbh,sbmc,sbxh,zclb,ysrq,whr,cfwz,ssqy,zclbyj,1 as gdzc from uf_zxgdzc --���Ĺ̶��ʲ�

select * from [v_fixedassets]



alter view v_gdzcsjyc
as
select a.*,0 as gzyy from v_fixedassets a where len(zzbh)<>9 --'��ų��Ȳ����Ϲ淶'
union all
select a.*,1 as gzyy from v_fixedassets a  --'�豸�����д�����Ϲ���'
where substring(zzbh,2,2) <> (select lbsx from uf_sblb where id=substring(a.zclb,3,3))  
union all 
select a.*,2 as gzyy  from v_fixedassets a   --'������д�����Ϲ���'
where substring(zzbh,1,1) <> (select sx from uf_gdzcssqy where id=a.ssqy)  and ssqy<>1 and zclbyj<>6
union all
select a.*,3 as gzyy from v_fixedassets a 
where zzbh in (select zzbh from v_fixedassets group by zzbh having count(1)>1)  --'�ʲ�����ظ�'
--

--


--select zzbh,sbmc,sbxh,replace(cast(sbxh as varchar(1000)),' ','') from uf_fixedassets where zzbh like 'PMY%'

--update  uf_fixedassets set sbxh=replace(cast(sbxh as varchar(1000)),' ','') where zzbh like 'PMY%'
-------------------------����������Ա----------------------------
update uf_fixedassets set whr='1709' where id in (
select a.id-- ,a.zzbh,a.whr,b.lastname 
from uf_fixedassets a
left join hrmresource b
on cast(a.whr as varchar(4))=cast(b.id as varchar(4))
where b.lastname='����'
)

update uf_fixedassets set syr='1709' where id in (
select a.id--,a.zzbh,a.syr,b.lastname 
from uf_fixedassets a
left join hrmresource b
on cast(a.syr as varchar(4))=cast(b.id as varchar(4))
where b.lastname='�Ų�'
)

update 	uf_zxgdzc set whr='1709' where id in (
select a.id 
--,a.zzbh,a.whr,b.lastname 
from uf_zxgdzc a
left join hrmresource b
on cast(a.whr as varchar(4))=cast(b.id as varchar(4))
where b.lastname='����'
)

update 	uf_zxgdzc set syr='1709' where id in (
select a.id 
--,a.zzbh,a.syr,b.lastname 
from uf_zxgdzc a
left join hrmresource b
on cast(a.syr as varchar(4))=cast(b.id as varchar(4))
where b.lastname='�Ų�'
)
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

-------------------�������̶��ʲ�����--------------------
 select * from openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets') ;

insert into  openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_fixedassets ')  
select  uf.id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj
,b.lastname as syr,c.bmfl as sybm,cast(uf.bz as varchar(2000)) as bz
from uf_fixedassets uf
 left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
 left join uf_gdzcssqy gd on gd.id=uf.ssqy
  left join hrmresource b on uf.syr=b.id
   left join uf_bmbh c on uf.sybm=c.bmbh
   where uf.id not in (select id from  openquery([EAM],'select id from uf_fixedassets '))

 -----------------�������Ĺ̶��ʲ�����-------------------
 select * from openquery([EAM],'select id,zzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_centralassets ') ;

insert into  openquery([EAM],'select id,zzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_centralassets ')  
select  uf.id,zzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj 
,b.lastname as syr,c.bmfl as sybm,cast(uf.bz as varchar(2000)) as bz
from uf_zxgdzc uf
 left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
 left join uf_gdzcssqy gd on gd.id=uf.ssqy
   left join hrmresource b on uf.syr=b.id
   left join uf_bmbh c on uf.sybm=c.bmbh
   where uf.id not in (select id from  openquery([EAM],'select id from uf_centralassets '))


------------------------------------------------
select * from uf_fixedassets where zzbh='SIE190332'

exec prc_insert_update_eam 5956
------------------------------------------------

ALTER proc [dbo].[prc_insert_update_eam] (@id int)
as
begin
      declare @zzbh varchar(20),@sapzzbh varchar(50),@sbmc varchar(50),@sbxh varchar(2000)
      declare @ysrq varchar(50),@cfwz varchar(50),@ssqy varchar(50),@zclbyj varchar(50)
      declare @syr varchar(50),@sybm varchar(50),@bz varchar(2000)
      select  @zzbh=zzbh,@sapzzbh=sapzzbh,@sbmc=sbmc,@sbxh=cast(sbxh as varchar(2000))
      ,@ysrq=ysrq,@cfwz=cfwz,@ssqy=gd.qy,@zclbyj=ws.selectname,@syr=b.lastname,@sybm=c.bmfl,@bz=cast(uf.bz as varchar(2000))
	   from uf_fixedassets uf
       left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
       left join uf_gdzcssqy gd on gd.id=uf.ssqy 
       left join hrmresource b on uf.syr=b.id
       left join uf_bmbh c on uf.sybm=c.bmbh
	   where uf.id=@id
   if exists(select id from openquery([EAM],'select id from uf_fixedassets ') where id=@id)
      begin
      update openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_fixedassets ')  
      set zzbh=@zzbh,sapzzbh=@sapzzbh,sbmc=@sbmc,sbxh=@sbxh,ysrq=@ysrq,cfwz=@cfwz,ssqy=@ssqy,zclbyj=@zclbyj,syr=@syr,sybm=@sybm,bz=@bz where id=@id
      end 
   else 
      begin
      insert into  openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_fixedassets ')  
      values(@id,@zzbh,@sapzzbh,@sbmc,@sbxh,@ysrq,@cfwz,@ssqy,@zclbyj,@syr,@sybm,@bz)
   end
end;

ALTER proc [dbo].[prc_insert_update_eam_zx](@id int)
as
begin
   declare @zzbh varchar(20),@sbmc varchar(50),@sbxh varchar(2000)
   declare @ysrq varchar(50),@cfwz varchar(50),@ssqy varchar(50),@zclbyj varchar(50)
   declare @syr varchar(50),@sybm varchar(50),@bz varchar(2000)
   select  @zzbh=zzbh,@sbmc=sbmc,@sbxh=cast(sbxh as varchar(2000))
    ,@ysrq=ysrq,@cfwz=cfwz,@ssqy=gd.qy,@zclbyj=ws.selectname,@syr=b.lastname,@sybm=c.bmfl,@bz=cast(uf.bz as varchar(2000)) 
	from uf_zxgdzc uf
    left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27219
    left join uf_gdzcssqy gd on gd.id=uf.ssqy 
	left join hrmresource b on uf.syr=b.id
    left join uf_bmbh c on uf.sybm=c.bmbh
	where uf.id=@id
   if exists(select id from openquery([EAM],'select id from uf_centralassets ') where id=@id)
     begin
     update openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_centralassets ')  
     set zzbh=@zzbh,sbmc=@sbmc,sbxh=@sbxh,ysrq=@ysrq,cfwz=@cfwz,ssqy=@ssqy,zclbyj=@zclbyj,syr=@syr,sybm=@sybm,bz=@bz 
     where id=@id
     end 
   else 
     begin
     insert into  openquery([EAM],'select id,zzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_centralassets ')  
     values(@id,@zzbh,@sbmc,@sbxh,@ysrq,@cfwz,@ssqy,@zclbyj,@syr,@sybm,@bz)
   end
end;
---------------------------------------------------------

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


--------------------�û�����-------------------------------------------------------------
select loginid,lastname,password from hrmresource 

select * from openquery([EAM],'SELECT * FROM fixedassets.admin')


select a.*,b.status from 
openquery([EAM],'select id,isaccountenabled,isaccountexpired,isaccountlocked,iscredentialsexpired,userid,name,username,password 
from fixedassets.admin ') a
inner join hrmresource b
on a.username=b.loginid
where b.status=5

select * from hrmresource where loginid='uid14180'

begin
   update openquery([EAM],'select id,isaccountenabled,isaccountexpired,isaccountlocked,iscredentialsexpired,userid,name,username,password 
   from fixedassets.admin ') set password='' where username<>'admin' ---���admin�˺�֮����˺�����

   update openquery([EAM],'select id,isaccountenabled,isaccountexpired,isaccountlocked,iscredentialsexpired,userid,name,username,password 
   from fixedassets.admin ') set isaccountenabled=0  
   from ecology.dbo.hrmresource a
   where username=a.loginid and a.status=5  ---������ְ�˺�
    
  update openquery([EAM],'select id,isaccountenabled,isaccountexpired,isaccountlocked,iscredentialsexpired,userid,name,username,password 
  from fixedassets.admin ') set password=lower(isnull(a.password,''))
  from ecology.dbo.hrmresource a
  where username=a.loginid and a.status<>5 --������ְ��Ա�˺�����

  insert into openquery([EAM],'select id,isaccountenabled,isaccountexpired,isaccountlocked,iscredentialsexpired,userid,name,username,password,loginFailureCount 
  from fixedassets.admin ') 
  select a.id as id,1 as isaccountenabled,0 as isaccountexpired,0 as isaccountlocked,0 as iscredentialsexpired
  ,a.id as userid,a.lastname as name,a.loginid as username,lower(isnull(a.password,'')) as password,0 as loginFailureCount
  from ecology.dbo.hrmresource a
  left join openquery([EAM],'select id,isaccountenabled,isaccountexpired,isaccountlocked,iscredentialsexpired,userid,name,username,password 
   from fixedassets.admin ') b
   on a.loginid=b.username 
   where a.status<>5 and loginid is not null and loginid<>'' and b.username is null  --�����µ���ְ��Ա�˺�

 end;


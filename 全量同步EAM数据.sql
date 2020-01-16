---登录192.168.4.106 EAM mysql数据库-----------
--use fixedassets;
--SET SQL_SAFE_UPDATES = 0; /*修改数据库模式*/
--truncate table uf_centralassets;
--truncate table uf_fixedassets;



-------------------插入财务固定资产数据--------------------
 --select * from openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj from uf_fixedassets') ;
 use ecology;
insert into  openquery([EAM],'select id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_fixedassets ')  
select  uf.id,zzbh,sapzzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj
,b.lastname as syr,c.bmfl as sybm,cast(uf.bz as varchar(2000)) as bz
from uf_fixedassets uf
 left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
 left join uf_gdzcssqy gd on gd.id=uf.ssqy
  left join hrmresource b on uf.syr=b.id
   left join uf_bmbh c on uf.sybm=c.bmbh
   where uf.id not in (select id from  openquery([EAM],'select id from uf_fixedassets '))

 -----------------插入中心固定资产数据-------------------
 --select * from openquery([EAM],'select id,zzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_centralassets ') ;

insert into  openquery([EAM],'select id,zzbh,sbmc,sbxh,ysrq,cfwz,ssqy,zclbyj,syr,sybm,bz from uf_centralassets ')  
select  uf.id,zzbh,sbmc,sbxh,ysrq,cfwz,gd.qy,ws.selectname as zclbyj 
,b.lastname as syr,c.bmfl as sybm,cast(uf.bz as varchar(2000)) as bz
from uf_zxgdzc uf
 left join workflow_SelectItem ws on ws.selectvalue =uf.zclbyj and ws.fieldid=27094
 left join uf_gdzcssqy gd on gd.id=uf.ssqy
   left join hrmresource b on uf.syr=b.id
   left join uf_bmbh c on uf.sybm=c.bmbh
   where uf.id not in (select id from  openquery([EAM],'select id from uf_centralassets '))

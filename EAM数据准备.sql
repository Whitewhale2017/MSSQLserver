select zzbh,fzzcbh,ssqy,zclb,* from uf_fixedassets 

select * from uf_qyzcglyxx


update uf_fixedassets set fzzcbh='234567' where id=66
--------------表单建模保存数据是先insert关键信息，然后update自定义信息------------------------
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



select * from hrmresource where lastname='王丽'

update uf_fixedassets set zclbyj=6

select * from  openquery([EAM],'select * from uf_fixedassets')

insert into openquery([EAM],'select * from uf_fixedassets') 
select id,zzbh,sapzzbh,sbmc,sbxh,cjsbbh,ysrq,jysjd,sbly,sbzt,cfwz,syr,
	ywsw,bz,formmodeid,sybm,sybmbh,zclb,ssqy,MODEUUID,
	b.selectname as zclbyj,null as createdate,null as modifydate,null as userid  
	from [dbo].[uf_fixedassets] a
	left join (select selectname,selectvalue from workflow_selectitem where fieldid=27094) b
	on a.zclbyj=b.selectvalue

select selectname from workflow_selectitem where fieldid=27094

--merge into [dbo].[T_Class_B]
--using [dbo].[T_Class_A] -- 这里的[dbo].[T_Class_A]也可以是子查询
--on [T_Class_A].[ClassName]=[T_Class_B].[ClassName]
--when matched 
--then update  set [T_Class_B].[StudentTotalCount]=[T_Class_A].[StudentTotalCount],[T_Class_B].[Owner]=[T_Class_A].[Owner]
--when not matched
--then insert([ClassName],[StudentTotalCount],[Owner]) values([T_Class_A].[ClassName],[T_Class_A].[StudentTotalCount],[T_Class_A].[Owner]);



select * from uf_gdzcbf_dt1

update uf_fixedassets set sbzt=2 where id in (select gdzcbh from uf_gdzcbf )
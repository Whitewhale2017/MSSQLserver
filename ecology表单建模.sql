--启用废弃的模块： 
update modeinfo set isdelete=0 where id=模块的id 
--注意：modeinfo存储有表单建模的信息。

--更新历史表单数据指定的模块（以uf_actibity_mapping举例）： 
update uf_actibity_mapping set formid=新模块id 

select * from modeinfo where modename like '%区域资产管理员信息%'

update modeinfo set isdelete=0 where modename like '%区域资产管理员信息%'
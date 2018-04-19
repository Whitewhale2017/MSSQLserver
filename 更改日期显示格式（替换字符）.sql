select * from formtable_main_248
select * from workflow_requestbase

update formtable_main_248 set yhksrq=(select stuff(stuff(yhxyyxqz,5,1,'年'),8,1,'月')+'日'),
yhjsrq=(select stuff(stuff(yhxyyxqjz ,5,1,'年'),8,1,'月')+'日'),
jyssxfdx=(select dbo.szL2U(jysxfsqwfz)),
zhhysxfdx=(select dbo.szL2U(zhhysxfsqwfz)),
hjsxfdx=(select dbo.szL2U(jysxfhjsqwfz)),
jyyqfwb=(select dbo.szL2U(jyyqfsqwfz)),
crjdx=(select dbo.szL2U(ljcrjjzbdy))

select replace(yhxyyxqz,left(yhxyyxqz,5),'年') from formtable_main_248

select stuff(stuff(yhxyyxqz,5,1,'年'),8,1,'月')+'日' from formtable_main_248

select stuff('abcdefg',1,6,'Hello ') --结果为：Hello g


-------------------------------------表触发器-------------------------
if (object_id('tgr_248_insert', 'tr') is not null)
    drop trigger tgr_248_insert
go
create trigger tgr_248_insert
on workflow_requestbase
    after insert --插入触发
as
  --  --定义变量
  --  declare @requestid varchar(20)
	
  ----在inserted表中查询已经插入记录信息
  --    select @requestid = requestid from inserted
	 -- print '流程ID'+@requestid
    update formtable_main_248 set yhksrq=(select stuff(stuff(yhxyyxqz,5,1,'年'),8,1,'月')+'日'),
    yhjsrq=(select stuff(stuff(yhxyyxqjz ,5,1,'年'),8,1,'月')+'日'),
    jyssxfdx=(select dbo.szL2U(jysxfsqwfz)),
    zhhysxfdx=(select dbo.szL2U(zhhysxfsqwfz)),
    hjsxfdx=(select dbo.szL2U(jysxfhjsqwfz)),
    jyyqfwb=(select dbo.szL2U(jyyqfsqwfz)),
    crjdx=(select dbo.szL2U(ljcrjjzbdy))
	--where requestId=(select requestId from inserted)
	go
	update formtable_main_248 set yhksrq=(select stuff(stuff(yhxyyxqz,5,1,'年'),8,1,'月')+'日'),
    yhjsrq=(select stuff(stuff(yhxyyxqjz ,5,1,'年'),8,1,'月')+'日'),
    jyssxfdx=(select dbo.szL2U(jysxfsqwfz)),
    zhhysxfdx=(select dbo.szL2U(zhhysxfsqwfz)),
    hjsxfdx=(select dbo.szL2U(jysxfhjsqwfz)),
    jyyqfwb=(select dbo.szL2U(jyyqfsqwfz)),
    crjdx=(select dbo.szL2U(ljcrjjzbdy))


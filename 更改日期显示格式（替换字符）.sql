select * from formtable_main_248
select * from workflow_requestbase

update formtable_main_248 set yhksrq=(select stuff(stuff(yhxyyxqz,5,1,'��'),8,1,'��')+'��'),
yhjsrq=(select stuff(stuff(yhxyyxqjz ,5,1,'��'),8,1,'��')+'��'),
jyssxfdx=(select dbo.szL2U(jysxfsqwfz)),
zhhysxfdx=(select dbo.szL2U(zhhysxfsqwfz)),
hjsxfdx=(select dbo.szL2U(jysxfhjsqwfz)),
jyyqfwb=(select dbo.szL2U(jyyqfsqwfz)),
crjdx=(select dbo.szL2U(ljcrjjzbdy))

select replace(yhxyyxqz,left(yhxyyxqz,5),'��') from formtable_main_248

select stuff(stuff(yhxyyxqz,5,1,'��'),8,1,'��')+'��' from formtable_main_248

select stuff('abcdefg',1,6,'Hello ') --���Ϊ��Hello g


-------------------------------------������-------------------------
if (object_id('tgr_248_insert', 'tr') is not null)
    drop trigger tgr_248_insert
go
create trigger tgr_248_insert
on workflow_requestbase
    after insert --���봥��
as
  --  --�������
  --  declare @requestid varchar(20)
	
  ----��inserted���в�ѯ�Ѿ������¼��Ϣ
  --    select @requestid = requestid from inserted
	 -- print '����ID'+@requestid
    update formtable_main_248 set yhksrq=(select stuff(stuff(yhxyyxqz,5,1,'��'),8,1,'��')+'��'),
    yhjsrq=(select stuff(stuff(yhxyyxqjz ,5,1,'��'),8,1,'��')+'��'),
    jyssxfdx=(select dbo.szL2U(jysxfsqwfz)),
    zhhysxfdx=(select dbo.szL2U(zhhysxfsqwfz)),
    hjsxfdx=(select dbo.szL2U(jysxfhjsqwfz)),
    jyyqfwb=(select dbo.szL2U(jyyqfsqwfz)),
    crjdx=(select dbo.szL2U(ljcrjjzbdy))
	--where requestId=(select requestId from inserted)
	go
	update formtable_main_248 set yhksrq=(select stuff(stuff(yhxyyxqz,5,1,'��'),8,1,'��')+'��'),
    yhjsrq=(select stuff(stuff(yhxyyxqjz ,5,1,'��'),8,1,'��')+'��'),
    jyssxfdx=(select dbo.szL2U(jysxfsqwfz)),
    zhhysxfdx=(select dbo.szL2U(zhhysxfsqwfz)),
    hjsxfdx=(select dbo.szL2U(jysxfhjsqwfz)),
    jyyqfwb=(select dbo.szL2U(jyyqfsqwfz)),
    crjdx=(select dbo.szL2U(ljcrjjzbdy))


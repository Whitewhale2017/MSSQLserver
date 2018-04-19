select * from formtable_main_190 where requestId='73543'
update formtable_main_190  set cwkj=null where requestId>='73542'
select * from formtable_main_187
select * from formtable_main_189
select * from formtable_main_191
select * from formtable_main_206_dt1
select * from workflow_requestbase where requestId='73542'
select * from workflow_base where id='364'

select b.formid from workflow_base b,workflow_requestbase r where r.requestid=73542 and r.workflowid=b.id

--用款申请190 差旅费187 费用报销189 个人借款191 
update formtable_main_190 
set cwkj=d.cwkj,cwzg=d.cwzg,cwjl=d.cwjl,zgszjl=d.gszjl,cn=d.cn,zlkj=d.zlkj
from formtable_main_206_dt1 d    
where requestId='73782' 


use ecology
go
if exists(select count(*) from sysobjects where id='ecology.dbo.Gxcwlcjdxx') drop proc dbo.Gxcwlcjdxx
go
create proc Gxcwlcjdxx
@requestid varchar(50)
as 
begin
   if (select b.formid from workflow_base b,workflow_requestbase r where r.requestid=@requestid and r.workflowid=b.id)='-190'
    update formtable_main_190 set cwkj=d.cwkj,cwzg=d.cwzg,cwjl=d.cwjl,zgszjl=d.gszjl,cn=d.cn,zlkj=d.zlkj
    from formtable_main_206_dt1 d    
    where requestId=@requestid and d.fkgs=formtable_main_190.FKGS
	else
	   if (select b.formid from workflow_base b,workflow_requestbase r where r.requestid=@requestid and r.workflowid=b.id)='-187'
            update formtable_main_187 set cwkj=d.cwkj,cwzg=d.cwzg,cwjl=d.cwjl,zgszjl=d.gszjl,cn=d.cn,zlkj=d.zlkj
            from formtable_main_206_dt1 d    
            where requestId=@requestid and d.fkgs=formtable_main_187.FKGS
	  else
			if (select b.formid from workflow_base b,workflow_requestbase r where r.requestid=@requestid and r.workflowid=b.id)='-191'
            update formtable_main_191 set cwkj=d.cwkj,cwzg=d.cwzg,cwjl=d.cwjl,zgszjl=d.gszjl,cn=d.cn,zlkj=d.zlkj
            from formtable_main_206_dt1 d    
            where requestId=@requestid and d.fkgs=formtable_main_191.FKGS
	  else 
			if (select b.formid from workflow_base b,workflow_requestbase r where r.requestid=@requestid and r.workflowid=b.id)='-189'
            update formtable_main_189 set cwkj=d.cwkj,cwzg=d.cwzg,cwjl=d.cwjl,zgszjl=d.gszjl,cn=d.cn,zlkj=d.zlkj
            from formtable_main_206_dt1 d    
            where requestId=@requestid and d.fkgs=formtable_main_189.FKGS

end

drop proc Gxcwlcjdxx

exec Gxcwlcjdxx '136435'

select (select lastname from hrmresource where convert(varchar(20),id)=convert(varchar(20),cwkj)) as 'cwkj',
(select lastname from hrmresource where convert(varchar(20),id)=convert(varchar(20),cwzg)) as 'cwzg',
(select lastname from hrmresource where convert(varchar(20),id)=convert(varchar(20),cwjl)) as 'cwjl',
(select lastname from hrmresource where convert(varchar(20),id)=convert(varchar(20),cn)) as 'cn',
(select lastname from hrmresource where convert(varchar(20),id)=convert(varchar(20),zlkj)) as 'zlkj',
* 
from formtable_main_189 where requestId='131839'


select fkgs,* from formtable_main_189 where requestId='131839'

  update formtable_main_189  set cwkj=d.cwkj,cwzg=d.cwzg,cwjl=d.cwjl,zgszjl=d.gszjl,cn=d.cn,zlkj=d.zlkj
            from formtable_main_206_dt1 d    
            where requestId='131839' and d.fkgs=formtable_main_189.FKGS

select * from formtable_main_206_dt1 
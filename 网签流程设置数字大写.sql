select requestId,sxfyh,hysxfyhwb,sxfjl,jyssxfjlwb,yqfyh,jyyqfyhwb,ljcrjjzbdy,crjdx from formtable_main_263 ---YGJX

select requestId,sxfyh,hysxfyhwb,sxfjl,jyssxfjlwb,yqfyh,jyyqfyhwb,ljcrjjzbdy,crjdx from formtable_main_264 ---YGSD

select requestId,sxfyh,hysxfyhwb,sxfjl,jyssxfjlwb,yqfjl,jyyqfyhwb,ljcrjjzbdy,crjdx from formtable_main_265 ---TTRJ,yqfjl

alter proc WQ_szdx(@requestid varchar(20)) ---网签流程设置数字大写
as 
begin
declare @str as varchar(1000)
declare @formid as varchar(100)
set @formid=(select replace(cast(formid as varchar(100)),'-','') from workflow_base where id=(select workflowid from workflow_requestbase where requestid=@requestid))
if @formid='265'
set @str='update formtable_main_'+ @formid+' set hysxfyhwb=dbo.szL2U(sxfyh),jyssxfjlwb=dbo.szL2U(sxfjl),jyyqfyhwb=dbo.szL2U(yqfjl),crjdx=dbo.szL2U(ljcrjjzbdy) where requestid='+@requestid
else
set @str='update formtable_main_'+ @formid+' set hysxfyhwb=dbo.szL2U(sxfyh),jyssxfjlwb=dbo.szL2U(sxfjl),jyyqfyhwb=dbo.szL2U(yqfyh),crjdx=dbo.szL2U(ljcrjjzbdy) where requestid='+@requestid
exec (@str)
end

exec dbo.WQ_szdx  113304

--select dbo.szL2U(0)

--select requestId,sxfyh,hysxfyhwb,sxfjl,jyssxfjlwb,yqfyh,jyyqfyhwb,ljcrjjzbdy,crjdx from formtable_main_263 where requestId='113304'

--select * from workflow_requestbase 

--select * from workflow_base 

--select * from formtable_main_10

--select dbo.szL2U

--select replace(cast(formid as varchar(100)),'-','') from workflow_base where id=(select workflowid from workflow_requestbase where requestid=109465)



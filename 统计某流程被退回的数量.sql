drop function dbo.Tongjithcs

create function Tongjithcs(@requestid varchar(20))
returns int
as
begin
    return (select sum(case when logtype='3' then 1 else 0 end) from workflow_requestLog where requestid=@requestid)	
end

select sum(case when logtype='3' then 1 else 0 end),requestid from workflow_requestLog group by requestid

select * from workflow_requestbase

select * from 
(select (select workflowtype from workflow_base where id=workflowid) as workflowtype,
workflowid,(select id from HrmSubCompany where id=(select subcompanyid1 from hrmresource where id=creater))  as companyid,
createdate,lastoperatedate,requestid,creater,currentnodetype,dbo.Jisuanshichang(createdate,createtime,lastoperatedate,lastoperatetime) as hours,
(select sum(case when logtype='3' then 1 else 0 end) from workflow_requestLog where requestid=w.requestid) as thcs
from workflow_requestbase w
where w.createdate>='2016-07-01' and w.createdate<'2016-08-01') t
where t.thcs is null

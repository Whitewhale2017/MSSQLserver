--公司证照对应
select count(id) as zzglg from formtable_main_153_dt1 where zzglg = '67'
--公司印章对应
select * from formtable_main_154_dt1 where yzglg = '67'
--优秀员工申请部门负责人对应表
select * from formtable_main_155_dt1 where cast(xm as varchar) in ('2015')
--合同所属公司及其业务分管
select * from formtable_main_167_dt1 
where (cast(ywfg as varchar) = '4171' or cast(cwjl as varchar) = '4171' or cast(cwzj as varchar) = '4171' or cast(gdqr as varchar) = '4171' or cast(yzgl as varchar) = '4171')
--财务流程审批关系表
select * from formtable_main_206_dt1
where (cast(cwkj as varchar) = '4171' or cast(cwzg as varchar) = '4171' or cast(cwjl as varchar) = '4171' or cast(cwzj as varchar) = '4171' or cast(gszjl as varchar) = '4171'
 or cast(cn as varchar) = '4171' or cast(zlkj as varchar) = '4171')
--公司人事章对应 (劳动关系归属公司及人事章管理表)
select * from formtable_main_222_dt1 where (cast(yzgly as varchar) = '4171' or cast(flcwdjr as varchar) = '4171')
--激励机制审批管理表 
select * from formtable_main_249 where cast(fwg as varchar) = '4171'  
--发文相关
select * from formtable_main_255_dt1 where cast(hqr as varchar) = ''
--办公地点运维对接维护表4955
select * from formtable_main_257_dt1 where cast(ywry as varchar) = '1974' or cast(rjyw as varchar) = '1974'
--敏感人员信息登记表
select * from formtable_main_262_dt1 where cast(xm as varchar) = '' 
union all
--员工角色清单 13
select count(a.id) from HrmRoleMembers a
left join HrmRoles b on a.roleid = b.id
left join HrmResource c on a.resourceid = c.id
where resourceid <>1 and resourceid ='1796'
union all
--部门角色
select count(id) from HrmDepartment
where (canceled = '0' or canceled is null) and (bmfzr like '"+resourceid+"' or bmfzr like ',"+resourceid+"' or bmfzr like '"+resourceid+",')
union all
select count(id) from HrmDepartment
where (canceled = '0' or canceled is null) and (bmfgld like '"+resourceid+"' or bmfgld like '%,"+resourceid+"%' or bmfgld like '%"+resourceid+",%')
union all
select count(id) from HrmDepartment
where (canceled = '0' or canceled is null) and (zxzj like '"+resourceid+"' or zxzj like '%,"+resourceid+"%' or zxzj like '%"+resourceid+",%')
union all
select count(id) from HrmDepartment
where (canceled = '0' or canceled is null) and (rszy like '"+resourceid+"' or rszy like '%,"+resourceid+"%' or rszy like '%"+resourceid+",%')
union all
select count(id) from HrmDepartment
where (canceled = '0' or canceled is null) and (rszysj like '"+resourceid+"' or rszysj like '%,"+resourceid+"%' or rszysj like '%"+resourceid+",%')
union all
select count(id) from HrmDepartment
where (canceled = '0' or canceled is null) and (kqrszy like '"+resourceid+"' or kqrszy like '%,"+resourceid+"' or kqrszy like '%"+resourceid+",')
union all
select count(id) from HrmDepartment
where (canceled = '0' or canceled is null) and (bmzl like '"+resourceid+"' or bmzl like '%,"+resourceid+"%' or bmzl like '%"+resourceid+",%')
union all
--公司角色
select id,subcompanyname,zxfzc from HrmSubCompany
where (canceled is null or canceled = '0') and (zxfzc like '"+resourceid+"' or zxfzc like ',"+resourceid+"' or zxfzc like '"+resourceid+",')
union all
select id,subcompanyname,fgszjl from HrmSubCompany
where (canceled is null or canceled = '0') and (fgszjl like '"+resourceid+"' or fgszjl like ',"+resourceid+"' or fgszjl like '"+resourceid+",')
union all
select id,subcompanyname,zjlzl from HrmSubCompany
where (canceled is null or canceled = '0') and (zjlzl like '"+resourceid+"' or zjlzl like ',"+resourceid+"' or zjlzl like '"+resourceid+",')
union all
select id,subcompanyname,rsjl from HrmSubCompany
where (canceled is null or canceled = '0') and (rsjl like '"+resourceid+"' or rsjl like ',"+resourceid+"' or rsjl like '"+resourceid+",')
union all
select id,subcompanyname,flzy from HrmSubCompany
where (canceled is null or canceled = '0') and (flzy like '"+resourceid+"' or flzy like ',"+resourceid+"' or flzy like '"+resourceid+",')
union all
select id,subcompanyname,xzzy from HrmSubCompany
where (canceled is null or canceled = '0') and (xzzy like '"+resourceid+"' or xzzy like ',"+resourceid+"' or xzzy like '"+resourceid+",')
union all
select id,subcompanyname,clgly from HrmSubCompany
where (canceled is null or canceled = '0') and (clgly like '"+resourceid+"' or zjlzl like ',"+resourceid+"' or clgly like '"+resourceid+",')
union all
select id,subcompanyname,rsyzbgr from HrmSubCompany
where (canceled is null or canceled = '0') and (rsyzbgr like '"+resourceid+"' or rsyzbgr like ',"+resourceid+"' or rsyzbgr like '"+resourceid+",')
union all
select id,subcompanyname,rzywdjr from HrmSubCompany
where (canceled is null or canceled = '0') and (rzywdjr like '"+resourceid+"' or rzywdjr like ',"+resourceid+"' or rzywdjr like '"+resourceid+",')
union all
select id,subcompanyname,rzxxaqdj from HrmSubCompany
where (canceled is null or canceled = '0') and (rzxxaqdj like '"+resourceid+"' or rzxxaqdj like ',"+resourceid+"' or rzxxaqdj like '"+resourceid+",')
union all
select id,subcompanyname,rzxzdjr from HrmSubCompany
where (canceled is null or canceled = '0') and (rzxzdjr like '"+resourceid+"' or rzxzdjr like ',"+resourceid+"' or rzxzdjr like '"+resourceid+",')
union all
select id,subcompanyname,rzpxdjr from HrmSubCompany
where (canceled is null or canceled = '0') and (rzpxdjr like '"+resourceid+"' or rzpxdjr like ',"+resourceid+"' or rzpxdjr like '"+resourceid+",')
union all
select id,subcompanyname,rzyxkt from HrmSubCompany
where (canceled is null or canceled = '0') and (rzyxkt like '"+resourceid+"' or rzyxkt like '%,"+resourceid+"%' or rzyxkt like '%"+resourceid+",%')
union all
select id,subcompanyname,rzcrm from HrmSubCompany
where (canceled is null or canceled = '0') and (rzcrm like '"+resourceid+"' or rzcrm like ',"+resourceid+"' or rzcrm like '"+resourceid+",')
union all
select id,subcompanyname,lzzjbdj from HrmSubCompany
where (canceled is null or canceled = '0') and (lzzjbdj like '"+resourceid+"' or lzzjbdj like ',"+resourceid+"' or lzzjbdj like '"+resourceid+",')
union all
select id,subcompanyname,lzywdj from HrmSubCompany
where (canceled is null or canceled = '0') and (lzywdj like '"+resourceid+"' or lzywdj like ',"+resourceid+"' or lzywdj like '"+resourceid+",')
union all
select id,subcompanyname,lzxxaq from HrmSubCompany
where (canceled is null or canceled = '0') and (lzxxaq like '"+resourceid+"' or lzxxaq like ',"+resourceid+"' or lzxxaq like '"+resourceid+",')
union all
select id,subcompanyname,lzxzdj from HrmSubCompany
where (canceled is null or canceled = '0') and (lzxzdj like '"+resourceid+"' or lzxzdj like ',"+resourceid+"' or lzxzdj like '"+resourceid+",')
union all
select id,subcompanyname,lzpxdjr from HrmSubCompany
where (canceled is null or canceled = '0') and (lzpxdjr like '"+resourceid+"' or lzpxdjr like ',"+resourceid+"' or lzpxdjr like '"+resourceid+",')
union all	
select id,subcompanyname,lzyxgb from HrmSubCompany
where (canceled is null or canceled = '0') and (lzyxgb like '"+resourceid+"' or lzyxgb like '%,"+resourceid+"%' or lzyxgb like '%"+resourceid+",%')	
union all
select id,subcompanyname,lzywxt from HrmSubCompany
where (canceled is null or canceled = '0') and (lzywxt like '"+resourceid+"' or lzywxt like ',"+resourceid+"' or lzywxt like '"+resourceid+",')	
union all
select id,subcompanyname,xzfzr from HrmSubCompany
where (canceled is null or canceled = '0') and (xzfzr like '"+resourceid+"' or xzfzr like ',"+resourceid+"' or xzfzr like '"+resourceid+",')	
union all											
select id,subcompanyname,xizzy from HrmSubCompany
where (canceled is null or canceled = '0') and (xizzy like '"+resourceid+"' or xizzy like '%,"+resourceid+"%' or xizzy like '%"+resourceid+",%')									union all										
select id,subcompanyname,gcy from HrmSubCompany
where (canceled is null or canceled = '0') and (gcy like '"+resourceid+"' or gcy like '%,"+resourceid+"%' or gcy like '%"+resourceid+",%')
union all
select id,subcompanyname,zpfzr from HrmSubCompany
where (canceled is null or canceled = '0') and (zpfzr like '"+resourceid+"' or zpfzr like ',"+resourceid+"' or zpfzr like '"+resourceid+",')
union all
select id,subcompanyname,rlzyfg from HrmSubCompany
where (canceled is null or canceled = '0') and (rlzyfg like '"+resourceid+"' or rlzyfg like ',"+resourceid+"' or rlzyfg like '"+resourceid+",')
union all
select id,subcompanyname,xzbzg from HrmSubCompany
where (canceled is null or canceled = '0') and (xzbzg like '"+resourceid+"' or xzbzg like ',"+resourceid+"' or xzbzg like '"+resourceid+",')
union all
select count(id) from formtable_main_153_dt1 where zzglg = '"+resourceid+"'
union all	
select count(id) from formtable_main_154_dt1 where yzglg = '"+resourceid+"'
union all
select count(id) from formtable_main_167_dt1 
where (cast(ywfg as varchar) = '"+resourceid+"' or cast(cwjl as varchar) = '"+resourceid+"' or cast(cwzj as varchar) = '"+resourceid+"' 
or cast(gdqr as varchar) = '"+resourceid+"' or cast(yzgl as varchar) = '"+resourceid+"')
union all
select count(id) from formtable_main_206_dt1 
where (cast(cwkj as varchar) = '"+resourceid+"' or cast(cwzg as varchar) = '"+resourceid+"' or cast(cwjl as varchar) = '"+resourceid+"' or cast(cwzj as varchar)
='"+resourceid+"' or cast(gszjl as varchar) = '"+resourceid+"'or cast(cn as varchar) = '"+resourceid+"' or cast(zlkj as varchar) = '"+resourceid+"')
union all
select count(id) from formtable_main_222_dt1 where (cast(yzgly as varchar) = '"+resourceid+"' or cast(flcwdjr as varchar) = '"+resourceid+"')
union all
select count(id) from formtable_main_249 where cast(fwg as varchar) = '"+resourceid+"'
union all
select count(id) from formtable_main_255_dt1 where cast(hqr as varchar) = '"+resourceid+"'
union all
select count(id) from formtable_main_257_dt1 where cast(ywry as varchar) = '"+resourceid+"' or cast(rjyw as varchar) = '"+resourceid+"'
union all
select count(id) from formtable_main_262_dt1 where cast(xm as varchar) = '"+resourceid+"' 

--统计**功能的点击量
create table CountClickAmount(
	id int identity(1,1) primary key not null,
	functionName varchar(50) null,
	amount int null
)

update CountClickAmount set amount = amount+1 where id = '1'
--统计**功能的详细点击量
drop table CountClickAmountDetail
create table CountClickAmountDetail(
	id int identity(1,1) primary key not null,
	useid int null,
	clientip varchar(100) null,
	clickdate varchar(20) null,
	clicktime varchar(20) null
)

select workcode,lastname,a.certificatenum,mobile,b.subcompanyname,c.departmentname,datefield1,a.LeaveDate,e.selectname as LeavingReason
from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
left join hrmresource_midtable d on a.id = d.resourceid
left join workflow_SelectItem e on a.LeavingReason = e.selectvalue and e.fieldid = '13649'
where a.status = '5' 
order by a.LeaveDate desc


select workcode 工号,lastname 姓名,a.certificatenum 身份证号,mobile 手机号,b.subcompanyname 公司,c.departmentname 部门,datefield1 入职日期,a.LeaveDate 离职日期,e.selectname as 离职原因
from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
left join hrmresource_midtable d on a.id = d.resourceid
left join workflow_SelectItem e on a.LeavingReason = e.selectvalue and e.fieldid = '13649'
where a.status = '5' and d.EmployeeLbCode ='21'
order by a.LeaveDate desc

select workcode 工号,lastname 姓名,a.certificatenum 身份证号,mobile 手机号,b.subcompanyname 公司,c.departmentname 部门,datefield1 入职日期,a.LeaveDate 离职日期,e.selectname as 离职原因
from HrmResource a
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join HrmDepartment c on a.departmentid = c.id
left join hrmresource_midtable d on a.id = d.resourceid
left join workflow_SelectItem e on a.LeavingReason = e.selectvalue and e.fieldid = '13649'
where a.status = '5' and d.EmployeeLbCode !='21'
order by a.LeaveDate desc

select * from workflow_base  where workflowname like '%离职%'

--停用
select b.requestname 流程名,c.lastname 离职人,d.subcompanyname 公司,e.departmentname 部门,zzlzsj 最终离职日期,b.lastoperatedate+' '+b.lastoperatetime 最后操作时间,b.status 状态 from formtable_main_104 a
left join workflow_requestbase b on a.requestId = b.requestid
left join HrmResource c on a.XM = c.id
left join HrmSubCompany d on c.subcompanyid1 = d.id
left join HrmDepartment e on c.departmentid = e.id
where zzlzsj >= '2016-01-01' and zzlzsj <= '2016-06-30'
--
select * from formtable_main_219

select b.requestname 流程名,c.lastname 离职人,d.subcompanyname 公司,e.departmentname 部门,zzlzrq 最终离职日期,b.lastoperatedate+' '+b.lastoperatetime 最后操作时间,b.status 状态 from formtable_main_219 a
left join workflow_requestbase b on a.requestId = b.requestid
left join HrmResource c on a.XM = c.id
left join HrmSubCompany d on c.subcompanyid1 = d.id
left join HrmDepartment e on c.departmentid = e.id
where zzlzrq >= '2016-01-01' and zzlzrq <= '2016-06-30'
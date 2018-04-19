select workcode,(select lastname from HrmResource where workcode=n.workcode),nd,
'法定' as '法定',(select njhours from empnianjia where workcode=n.workcode and njtype='法定') as 'fdsc',
'福利' as '福利',(select njhours from empnianjia where workcode=n.workcode and njtype='福利') as 'flsc',
(select sum(njhours) from empnianjia where workcode=n.workcode group by workcode)
from empnianjia n
where id in(select max(id) from empnianjia group by workcode)

select * from empnianjia where workcode in (
select workcode from empnianjia group by workcode having count(workcode)>2) order by workcode
--------------------------------------------------------------





select * from empnianjia where workcode like '%?'
select * from empnianjia where workcode like '840083'
select * from empnianjia where workcode like ' %'

select workcode,count(*) from empnianjia 
group by workcode
having count(*)>2

select e.workcode,h.lastname from empnianjia e
left join Hrmresource h
on  e.workcode=h.workcode
group by e.workcode,h.lastname
having count(*)>1



select e.workcode,h.lastname,e.njtype,e.nd,e.njhours,e.sjjy from empnianjia e
left join HrmResource h
on e.workcode=h.workcode

select * from HrmResource where workcode='101832'

insert into empnianjia values('050001','福利','2016',40,0);
insert into empnianjia values('050011','福利','2016',32,0);
insert into empnianjia values('050101','福利','2016',40,0);
insert into empnianjia values('050839','福利','2016',40,0);
insert into empnianjia values('050301','福利','2016',32,0);
insert into empnianjia values('050306','福利','2016',16,0);
insert into empnianjia values('050501','福利','2016',40,0);
insert into empnianjia values('050847','福利','2016',16,0);
insert into empnianjia values('050013','福利','2016',16,0);
insert into empnianjia values('050015','福利','2016',16,0);
insert into empnianjia values('050018','福利','2016',16,0);
insert into empnianjia values('050021','福利','2016',16,0);
insert into empnianjia values('050036','福利','2016',8,0);
insert into empnianjia values('050702','福利','2016',16,0);
insert into empnianjia values('050231','福利','2016',8,0);
insert into empnianjia values('050042','福利','2016',0,0);
insert into empnianjia values('050043','福利','2016',0,0);
insert into empnianjia values('050044','福利','2016',0,0);
insert into empnianjia values('050102','福利','2016',16,0);
insert into empnianjia values('050106','福利','2016',16,0);
insert into empnianjia values('050108','福利','2016',16,0);
insert into empnianjia values('050112','福利','2016',16,0);
insert into empnianjia values('050115','福利','2016',16,0);
insert into empnianjia values('050120','福利','2016',8,0);
insert into empnianjia values('050705','福利','2016',16,0);
insert into empnianjia values('050206','福利','2016',16,0);
insert into empnianjia values('050711','福利','2016',16,0);
insert into empnianjia values('050110','福利','2016',16,0);
insert into empnianjia values('050125','福利','2016',16,0);
insert into empnianjia values('050128','福利','2016',0,0);
insert into empnianjia values('050808','福利','2016',8,0);
insert into empnianjia values('050241','福利','2016',8,0);
insert into empnianjia values('050207','福利','2016',16,0);
insert into empnianjia values('050226','福利','2016',8,0);
insert into empnianjia values('050803','福利','2016',8,0);
insert into empnianjia values('050238','福利','2016',0,0);
insert into empnianjia values('050246','福利','2016',0,0);
insert into empnianjia values('050247','福利','2016',0,0);
insert into empnianjia values('050305','福利','2016',16,0);
insert into empnianjia values('050324','福利','2016',8,0);
insert into empnianjia values('050327','福利','2016',8,0);
insert into empnianjia values('050319','福利','2016',8,0);
insert into empnianjia values('050333','福利','2016',0,0);
insert into empnianjia values('050726','福利','2016',8,0);
insert into empnianjia values('050402','福利','2016',16,0);
insert into empnianjia values('050421','福利','2016',8,0);
insert into empnianjia values('050410','福利','2016',16,0);
insert into empnianjia values('050205','福利','2016',16,0);
insert into empnianjia values('050430','福利','2016',0,0);
insert into empnianjia values('050334','福利','2016',0,0);
insert into empnianjia values('050335','福利','2016',0,0);
insert into empnianjia values('050435','福利','2016',0,0);
insert into empnianjia values('050436','福利','2016',0,0);
insert into empnianjia values('050439','福利','2016',0,0);
insert into empnianjia values('050437','福利','2016',0,0);
insert into empnianjia values('050441','福利','2016',0,0);
insert into empnianjia values('050443','福利','2016',0,0);
insert into empnianjia values('050444','福利','2016',0,0);
insert into empnianjia values('050505','福利','2016',16,0);
insert into empnianjia values('050506','福利','2016',16,0);
insert into empnianjia values('050534','福利','2016',8,0);
insert into empnianjia values('050538','福利','2016',8,0);
insert into empnianjia values('050537','福利','2016',8,0);
insert into empnianjia values('050539','福利','2016',8,0);
insert into empnianjia values('050540','福利','2016',0,0);
insert into empnianjia values('050612','福利','2016',16,0);
insert into empnianjia values('050541','福利','2016',0,0);
insert into empnianjia values('050543','福利','2016',0,0);
insert into empnianjia values('050544','福利','2016',0,0);
insert into empnianjia values('050901','福利','2016',8,0);
insert into empnianjia values('050908','福利','2016',8,0);
insert into empnianjia values('050912','福利','2016',8,0);
insert into empnianjia values('050229','福利','2016',8,0);
insert into empnianjia values('050632','福利','2016',0,0);
insert into empnianjia values('050635','福利','2016',0,0);
insert into empnianjia values('050638','福利','2016',0,0);
insert into empnianjia values('050001','法定','2016',80,0);
insert into empnianjia values('050011','','2016',40,0);
insert into empnianjia values('050101','','2016',40,0);
insert into empnianjia values('050839','','2016',40,0);
insert into empnianjia values('050301','','2016',40,0);
insert into empnianjia values('050306','','2016',40,0);
insert into empnianjia values('050501','','2016',40,0);
insert into empnianjia values('050847','','2016',80,0);
insert into empnianjia values('050013','','2016',40,0);
insert into empnianjia values('050015','','2016',80,0);
insert into empnianjia values('050018','','2016',40,0);
insert into empnianjia values('050021','','2016',40,0);
insert into empnianjia values('050036','','2016',40,0);
insert into empnianjia values('050702','','2016',40,0);
insert into empnianjia values('050231','','2016',40,0);
insert into empnianjia values('050042','','2016',40,0);
insert into empnianjia values('050043','','2016',0,0);
insert into empnianjia values('050044','','2016',40,0);
insert into empnianjia values('050102','','2016',40,0);
insert into empnianjia values('050106','','2016',40,0);
insert into empnianjia values('050108','','2016',40,0);
insert into empnianjia values('050112','','2016',40,0);
insert into empnianjia values('050115','','2016',40,0);
insert into empnianjia values('050120','','2016',40,0);
insert into empnianjia values('050705','','2016',40,0);
insert into empnianjia values('050206','','2016',40,0);
insert into empnianjia values('050711','','2016',40,0);
insert into empnianjia values('050110','','2016',40,0);
insert into empnianjia values('050125','','2016',0,0);
insert into empnianjia values('050128','','2016',0,0);
insert into empnianjia values('050808','','2016',40,0);
insert into empnianjia values('050241','','2016',40,0);
insert into empnianjia values('050207','','2016',40,0);
insert into empnianjia values('050226','','2016',40,0);
insert into empnianjia values('050803','','2016',40,0);
insert into empnianjia values('050238','','2016',40,0);
insert into empnianjia values('050246','','2016',40,0);
insert into empnianjia values('050247','','2016',40,0);
insert into empnianjia values('050305','','2016',40,0);
insert into empnianjia values('050324','','2016',40,0);
insert into empnianjia values('050327','','2016',40,0);
insert into empnianjia values('050319','','2016',40,0);
insert into empnianjia values('050333','','2016',0,0);
insert into empnianjia values('050726','','2016',40,0);
insert into empnianjia values('050402','','2016',40,0);
insert into empnianjia values('050421','','2016',40,0);
insert into empnianjia values('050410','','2016',40,0);
insert into empnianjia values('050205','','2016',40,0);
insert into empnianjia values('050430','','2016',40,0);
insert into empnianjia values('050334','','2016',0,0);
insert into empnianjia values('050335','','2016',40,0);
insert into empnianjia values('050435','','2016',40,0);
insert into empnianjia values('050436','','2016',40,0);
insert into empnianjia values('050439','','2016',40,0);
insert into empnianjia values('050437','','2016',40,0);
insert into empnianjia values('050441','','2016',0,0);
insert into empnianjia values('050443','','2016',40,0);
insert into empnianjia values('050444','','2016',0,0);
insert into empnianjia values('050505','','2016',40,0);
insert into empnianjia values('050506','','2016',40,0);
insert into empnianjia values('050534','','2016',40,0);
insert into empnianjia values('050538','','2016',40,0);
insert into empnianjia values('050537','','2016',40,0);
insert into empnianjia values('050539','','2016',40,0);
insert into empnianjia values('050540','','2016',40,0);
insert into empnianjia values('050612','','2016',40,0);
insert into empnianjia values('050541','','2016',40,0);
insert into empnianjia values('050543','','2016',40,0);
insert into empnianjia values('050544','','2016',40,0);
insert into empnianjia values('050901','','2016',40,0);
insert into empnianjia values('050908','','2016',40,0);
insert into empnianjia values('050912','','2016',40,0);
insert into empnianjia values('050229','','2016',40,0);
insert into empnianjia values('050632','','2016',40,0);
insert into empnianjia values('050635','','2016',40,0);
insert into empnianjia values('050638','','2016',40,0);

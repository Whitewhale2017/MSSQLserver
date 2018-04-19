select * from empnianjia where workcode='011380'

select workcode from empnianjia 
group by workcode
having count(*)>4

select workcode from empnianjia 
group by workcode,njtype 
having count(*)>1 and njtype='福利'

select workcode from empnianjia 
group by workcode,njtype 
having count(*)>1 and njtype='法定'

delete from empnianjia 
where
njtype='福利' 
and
workcode in 
(select workcode from empnianjia 
group by workcode,njtype
having count(*)>1 and njtype='福利')
and
id not in
(
select max(id)
from empnianjia
group by workcode,njtype
having count(workcode)>1 and njtype='福利'
);

delete from empnianjia 
where 
njtype='法定'
and
workcode in 
(select workcode from empnianjia 
group by workcode,njtype 
having count(*)>1 and njtype='法定' )
and
id not in
(
select max(id)
from empnianjia
group by workcode,njtype
having count(workcode)>1 and njtype='法定'
);
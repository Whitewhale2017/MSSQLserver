select * from empnianjia where workcode='011380'

select workcode from empnianjia 
group by workcode
having count(*)>4

select workcode from empnianjia 
group by workcode,njtype 
having count(*)>1 and njtype='����'

select workcode from empnianjia 
group by workcode,njtype 
having count(*)>1 and njtype='����'

delete from empnianjia 
where
njtype='����' 
and
workcode in 
(select workcode from empnianjia 
group by workcode,njtype
having count(*)>1 and njtype='����')
and
id not in
(
select max(id)
from empnianjia
group by workcode,njtype
having count(workcode)>1 and njtype='����'
);

delete from empnianjia 
where 
njtype='����'
and
workcode in 
(select workcode from empnianjia 
group by workcode,njtype 
having count(*)>1 and njtype='����' )
and
id not in
(
select max(id)
from empnianjia
group by workcode,njtype
having count(workcode)>1 and njtype='����'
);
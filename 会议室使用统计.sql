select * from Bill_Meeting where len(Address)>3
select * from meeting where len(Address)>3

select-- a.id,a.name,BeginDate,Address,b.name
count(a.id) as 'cs',address,(select Name from MeetingRoom where id=a.address) as 'location' 
from Meeting a
where a.begindate>='2017-01-01' and a.begindate<='2017-12-31'
group by address

select * from MeetingRoom


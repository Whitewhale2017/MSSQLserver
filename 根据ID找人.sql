use ecology
go 
if exists(select count(*) from sysobjects where id='Gjidzr')
drop function Gjidzr
go
create function Gjidzr(@id varchar(100)) --¸ù¾ÝIDÕÒÈË
returns varchar(100)
as
begin
   return (select lastname from Hrmresource r where cast(r.id as varchar)=cast(@id as varchar))                                                    
end



select subcompanyname,dbo.Gjidzr(fgszjl) as fgszjl,dbo.Gjidzr(rsjl) as rsjl
from HrmSubCompany 

declare @s varchar(50),@split varchar(2),@pos int,@splitlen int
select @s='a,b,ct,d,e,f,g',@split=',',@pos=3,@splitlen=len(@split+'a')-2
       while @pos>1 and charindex(@split,@s+@split)>0
       select @pos=@pos-1,@s=stuff(@s,1,charindex(@split,@s+@split)+@splitlen,'')
select left(@s,charindex(@split,@s+@split)-1)

select replace('123,234,3,12','','')
select * from formtable_main_359

select * from uf_rwxx where rwzt=0
 
create trigger tri_update_rwzt
on formtable_main_359
after update 
as
begin
    declare @rwzt int,@rwbh varchar(50),@jhwcrq varchar(20)
    select @rwzt=rwzt,@rwbh=rwbh,@jhwcrq=jhwcrq from inserted
   if (@jhwcrq<convert(varchar(10),getdate(),23) and @rwzt in (2,3))
      begin
	    update uf_rwxx set rwzt=7 where rwbh=@rwbh
	  end
   else
      begin
	    update uf_rwxx set rwzt=@rwzt where rwbh=@rwbh
	  end
	  end 
end


select rwbh,rwmc,rwzt,zzr from formtable_main_359 
where rwzt in (2,3) and jhwcrq<convert(varchar(10),getdate(),23)
select * from formtable_main_154_dt1

select * from formtable_main_154_dt1 a
left join workflow_SelectItem b on a.gsmc = b.selectvalue 



select * from formtable_main_167_dt1 a
left join workflow_SelectItem b on a.gsmc = b.selectvalue and b.fieldid = '10540'

select * from workflow_SelectItem order by fieldid desc
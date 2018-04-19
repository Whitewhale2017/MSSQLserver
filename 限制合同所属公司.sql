select a.id,selectname,selectvalue from formtable_main_167_dt1 a
left join workflow_SelectItem b on a.gsmc = b.selectvalue and b.fieldid = '10540'
where a.gsmc in (1,2,3,5,13,14,15,16,17,20,25,28,29,31,32,35,36,37,38)

select * from formtable_main_167_dt1 a

select * from workflow_SelectItem b
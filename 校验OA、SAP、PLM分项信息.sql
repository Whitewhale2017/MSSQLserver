select * from 
(
select a.H_NO,a.H_TYPE,b.hth,b.auart,a.ctime
from openquery([PLMPRD],'select * from SIPM1 order by CTime') a
full outer join  openquery([192.168.4.105],'select * from ecology.dbo.uf_WorkOrder') b
on a.H_NO=b.hth
where ctime>='2019-03-25 00:00:00'
--order by a.ctime desc
) T
group by H_NO


select * from openquery([PLMPRD],'select * from SIPM1') --��ͬ
select * from openquery([PLMPRD],'select * from SIPM2') --��ͬ����ļ�
select * from openquery([PLMPRD],'select * from SIPM3') --�׼�
select * from openquery([PLMPRD],'select H_NO,WBS,NO as matnr,amount,cast(ctime as date) as cdate from SIPM4
where ctime>=to_date(''2019-03-28'',''YYYY-MM-DD'')') --����

select * from openquery([PLMPRD],'select * from SIPM4') --����


select * from openquery([192.168.4.105],'select * from ecology.dbo.uf_WorkOrder') --����������Ϣ
select * from openquery([192.168.4.105],'select * from ecology.dbo.uf_WorkOrder_dt1') --�׼���Ϣ
select * from openquery([192.168.4.105],'select * from ecology.dbo.uf_WorkOrder_dt2') --������Ϣ

select * from  openquery([SAPPRD],'select pspnr,posid from SAPABAP1.PRPS where mandt=''800''')

select * from  openquery([SAPPRD],'select right(a.matnr,10) as mtr,a.matnr,b.posid as wbs from SAPABAP1.PRST a
left outer join SAPABAP1.PRPS b
on a.pspnr=b.pspnr and b.mandt=''800''
where  a.mandt=''800''')  ---PLM������SAP��WBS BOM����

select * from  openquery([SAPPRD],'select a.matnr,a.bdmng,b.posid from SAPABAP1.RESB a
left outer join SAPABAP1.PRPS b
on a.pspel=b.pspnr and b.mandt=''800''
where a.mandt=''800''and a.BWART=''281'' and XLOEK<>''X'' ')--SAP��Ŀ����



select * from openquery([RF],'select * from material_history_item_log limit 2,10')

--------PLM ����Ϊ��-------------------
select a.H_NO,a.wbs as pwbs,a.matnr as pmtr,a.amount as pnum,a.cdate,b.wbs as swbs,b.mtr as smtr
from openquery([PLMPRD],'select H_NO,WBS,NO as matnr,amount,cast(ctime as date) as cdate from SIPM4
where ctime>=to_date(''2019-03-28'',''YYYY-MM-DD'')') as a
full outer join openquery([SAPPRD],'select right(a.matnr,10) as mtr,a.matnr,b.posid as wbs from SAPABAP1.PRST a
left outer join SAPABAP1.PRPS b
on a.pspnr=b.pspnr and b.mandt=''800''
where  a.mandt=''800''') b
on a.wbs=b.wbs and a.matnr=b.mtr

--------SAP ����Ϊ��-------------------
select a.H_NO,a.wbs as pwbs,a.matnr as pmtr,a.amount as pnum,a.cdate,b.wbs as swbs,b.mtr as smtr
from openquery([PLMPRD],'select H_NO,WBS,NO as matnr,amount,cast(ctime as date) as cdate from SIPM4
where ctime>=to_date(''2015-01-1'',''YYYY-MM-DD'')') as a
right outer join openquery([SAPPRD],'select right(a.matnr,10) as mtr,a.matnr,b.posid as wbs from SAPABAP1.PRST a
left outer join SAPABAP1.PRPS b
on a.pspnr=b.pspnr and b.mandt=''800''
where  a.mandt=''800''') b
on a.wbs=b.wbs and a.matnr=b.mtr
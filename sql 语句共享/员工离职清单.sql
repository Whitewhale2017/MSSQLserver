select b.subcompanyname,count(a.id) from HrmResource a --��ְ����
left join HrmSubCompany b on a.subcompanyid1 = b.id
where status = '5' and LeaveDate >='2016-01-01' and LeaveDate <='2016-06-30'
group by b.subcompanyname

select * from formtable_main_148_dt1 --������ְ
select b.subcompanyname,count(XM) from formtable_main_148_dt1 a --������ְ ���ݹ�˾
left join HrmSubCompany b on a.fb = b.id 
where lzrq >='2016-01-01' and lzrq <='2016-06-30'
group by b.subcompanyname


select SUBSTRING(zzlzrq,6,2),count(XM) from formtable_main_219 a --��������  �����·�
left join HrmSubCompany b on a.SSGS = b.id 
where zzlzrq >='2016-01-01' and zzlzrq <='2016-06-30'
group by SUBSTRING(zzlzrq,6,2)

select b.subcompanyname,count(XM) from formtable_main_219 a --�������� ���ݹ�˾
left join HrmSubCompany b on a.SSGS = b.id 
where zzlzrq >='2016-01-01' and zzlzrq <='2016-06-30'
group by b.subcompanyname

select b.subcompanyname,count(XM) from formtable_main_104 a --��������(ͣ��) ���ݹ�˾
left join HrmSubCompany b on a.SSGS = b.id 
where zzlzsj >='2016-01-01' and zzlzsj <='2016-06-30'
group by b.subcompanyname

select b.subcompanyname,c.XzRank,count(a.id) from HrmResource a --����Ա��ְ������ ��ְ����
left join HrmSubCompany b on a.subcompanyid1 = b.id
left join hrmresource_midtable c on a.id = c.resourceid
where a.status = '5' and a.LeaveDate >='2016-01-01' and a.LeaveDate <='2016-06-30'
group by b.subcompanyname,c.XzRank


select b.subcompanyname,SUBSTRING(LeaveDate,6,2),count(a.id) from HrmResource a --��ְ���� �����·�
left join HrmSubCompany b on a.subcompanyid1 = b.id
where status = '5' and LeaveDate >='2016-01-01' and LeaveDate <='2016-06-30'
group by b.subcompanyname,SUBSTRING(LeaveDate,6,2)

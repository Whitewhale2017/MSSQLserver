---������ʵ���ڲ�ѯ
select a.lastname,b.departmentname from ecology.dbo.HrmResource a
left join ecology8.dbo.HrmDepartment b
on a.departmentid=b.id


----------------�������ʵ����ѯ--------------------
----------------------------------------------------
---��ʱ����(1)
--------------
--select * from openrowset('SQLOLEDB', 'sql������������ַ��'; '�û���'; '����', ���ݿ���.dbo.����)
select * from openrowset('SQLOLEDB', '192.168.19.203'; 'sa'; 'Ytx@zjb13f', ecology.dbo.Hrmdepartment)
--����ʾ��
select * into �� from openrowset('SQLOLEDB' ,'sql������������ַ��';'�û���';'����' ,���ݿ���.dbo.����)

---��ʱ����(2)
--------------
--�����ʾ����������ĳ��������ݣ��ñ��� SQL Server ����һ��ʵ���С�
--SELECT *FROM OPENDATASOURCE('SQLOLEDB','Data Source=ServerName;User ID=MyUID;Password=MyPass').Northwind.dbo.Categories
SELECT * FROM OPENDATASOURCE('SQLOLEDB','Data Source=192.168.19.203;User ID=sa;Password=Ytx@zjb13f').ecology.dbo.hrmdepartment
--�����Ǹ���ѯ��ʾ������ͨ������ Jet �� OLE DB �ṩ�����ѯ Excel ���ӱ��
--SELECT *FROM OpenDataSource( 'Microsoft.Jet.OLEDB.4.0','Data Source="c:Financeaccount.xls";User ID=Admin;Password=;Extended properties=Excel 5.0')...xactions


----�������ӷ�����-------------------------------
--�ڿ���ѯʱ��Ҫ����Ad Hoc Distributed Queries---Ĭ���ѿ�������ִ���������
--����Ad Hoc Distributed Queries��
exec sp_configure 'show advanced options',1
reconfigure
exec sp_configure 'Ad Hoc Distributed Queries',1
reconfigure
--ʹ����ɺ󣬹ر�Ad Hoc Distributed Queries��
--exec sp_configure 'Ad Hoc Distributed Queries',0
--reconfigure
--exec sp_configure 'show advanced options',0
--reconfigure 




--exec sp_addlinkedserver   'srv_lnk', '', 'SQLOLEDB','Զ�̷���������ip��ַ'
exec sp_addlinkedserver   'srv_lnk', '', 'SQLOLEDB','192.168.19.203'
--exec sp_addlinkedsrvlogin 'srv_lnk','false',null,'�û���','����'
exec sp_addlinkedsrvlogin 'srv_lnk','false',null,'sa','Ytx@zjb13f'

--go
--��ѯʾ��
--select * from srv_lnk.���ݿ���.dbo.����
select * from srv_lnk.ecology.dbo.hrmresource

--����ʾ��
--select * into �� from srv_lnk.���ݿ���.dbo.����

--�Ժ���ʹ��ʱɾ�����ӷ�����
--exec sp_dropserver 'srv_lnk','droplogins'
exec sp_dropserver 'srv_lnk','droplogins'



select * from openquery��srv_lnk,'select * from hrmresource'��


--������д������ɾ����ִ�д洢���̵ĵ�¼�˻�
exec sp_addlogin 'php_user','User$2014','ecology'
go
--�������ݿ��û�
exec sp_adduser 'php_user','php_user'
go
--������Ȩ�޸����û�
exec sp_addrolemember 'db_datareader','php_user'
go
--��д��ɾ�������µ�Ȩ�������˻�
exec sp_addrolemember 'db_datawriter','php_user'
go
--���趨��Ȩ��
exec sp_addrolemember 'db_ddladmin','php_user'
go
--�����˻�dbo�ܹ���ִ�е�Ȩ��
grant execute on schema :: dbo to php_user
go

--����ֻ���˻�
exec sp_addlogin 'oa_reader','hofan123','ecology'
go
--�������ݿ��û�
exec sp_adduser 'oa_reader','oa_reader'
go
--������Ȩ�޸����û�
exec sp_addrolemember 'db_datareader','oa_reader'
go

--�����˻�ʹ��SQL Profiler��Ȩ��
use master
go
exec sp_addlogin 'oa_trace','Trace$123','master'
go
exec sp_adduser 'oa_trace','oa_trace'
go
grant alter trace to oa_trace
go

--�����˻�ĳ����Ĳ�ѯȨ��
grant select on GetMulProccessSql to oa_trace
go
--�������ݿ�������Ȩ��
exec sp_addrolemember 'db_owner','php_user'
go
--�����˻���ĳ����Ĳ�ѯȨ��
GRANT SELECT ON [oa_user].[formtable_main_export] TO [read_export]
GO
--�����˻��Ա�ֵ��������Ȩ��
use [ecology]
GO
GRANT VIEW DEFINITION ON [dbo].[fun_split] TO [read_export]
GO
--�����˻��Ա�ֵ�����޸�Ȩ��
use [ecology]
GO
GRANT ALTER ON [dbo].[fun_split] TO [read_export]
GO
--�����˻��Ա�ֵ�����ӹ�����Ȩ��
use [ecology]
GO
GRANT TAKE OWNERSHIP ON [dbo].[fun_split] TO [read_export]
GO
--�����˻��Ա�ֵ��������Ȩ��
use [ecology]
GO
GRANT CONTROL ON [dbo].[fun_split] TO [read_export]
GO
--�����˻��Ա�ֵ�����鿴Ȩ��
use [ecology]
GO
GRANT SELECT ON [dbo].[fun_split] TO [read_export]
GO
--�����˻��Ա�ֵ��������Ȩ��
use [ecology]
GO
GRANT REFERENCES ON [dbo].[fun_split] TO [read_export]
GO
--���ݿ���ֹ����û�ʱ
--�����û���ָֻ���û���û�е�¼�����û���ֻ������ĳ�����ݿ⡷��ȫ�ԡ��û����ڵ��£���


--��ȡ��ǰ���ݿ�ܹ�������
select * from sys.schemas
GO
--ͨ�������û�����ȡprincipal_id
SELECT DATABASE_PRINCIPAL_ID('DEV-LILING\Repplication');
GO
--�ѹ����û���ӵ�еļܹ�������һ���û�
--ʵ��Ϊ��test1�ļܹ�db_datareader�����dbo
ALTER AUTHORIZATION ON SCHEMA::db_datareader TO dbo
GO
--ɾ�������û�
exec sp_dropuser 'test1'
GO

--�����ݿ�������߼ܹ�����DEV-LILING\Repplication
ALTER AUTHORIZATION ON SCHEMA::db_datareader TO [DEV-LILING\Repplication]
GO
--�����ݿ��[DEV-LILING\Repplication]�ܹ�����dbo
ALTER AUTHORIZATION ON SCHEMA::[DEV-LILING\Repplication] TO dbo
go
--ɾ���ܹ�
drop schema [DEV-LILING\Repplication]
go
--�����ݿ�������߸���DEV-LILING\Repplication
EXEC sp_changedbowner [DEV-LILING\Repplication]
GO

/*
----------------------------ʵ�鳡��-------------------------------
1��ʹ��windows�˻�([Hofan-sz\liling])��½�������󣬽���һ�����ݿ⣬�����ݿ�������߸��������û�
2���ڷ���������ɾ��windows�˻��ĵ�¼Ȩ�ޣ�ʹ�����ݿ��е�dbo�û�����
*/

/*
----------------------------׼���׶�-------------------------------
1������һ���µ�windows�˻�([DEV-LILING\Repplication])���������Ա��
2��ʹ��sa��½SQLSERVER���ڷ���������İ�ȫ�ڵ��µĵ�¼���ڵ��¼������˻�����ʹ���������ɫΪsysadmin
*/

/*
----------------------------ʵ�ʲ���-------------------------------
ѡ�����ݿ⡷��ȫ�ԡ��û� ��ѡ��dbo,�Ҽ����Կ��Կ���dbo��������Ϊ�����windows�˻�
*/
--���û�[DEV-LILING\Repplication]���ݿ��Ĭ�ϼܹ�
ALTER USER [DEV-LILING\Repplication] WITH DEFAULT_SCHEMA=[dbo]
GO
--���û�dbo�����мܹ������DEV-LILING\Repplication
ALTER AUTHORIZATION ON SCHEMA::db_datareader TO [DEV-LILING\Repplication]
GO
ALTER AUTHORIZATION ON SCHEMA::db_owner TO [DEV-LILING\Repplication]
GO
--�ٽ��û������мܹ������dbo
ALTER AUTHORIZATION ON SCHEMA::db_datareader TO dbo
GO
ALTER AUTHORIZATION ON SCHEMA::db_owner TO dbo
GO
--����û��������ݿ��ɫ����Ҫɾ����ɫ
exec sp_droprolemember 'db_datareader','[Hofan-sz\liling]'
go
--ɾ���û�DEV-LILING\Repplication
exec sp_dropuser 'DEV-LILING\Repplication'
go
--�����ݿ�������߸���DEV-LILING\Repplication
EXEC sp_changedbowner [DEV-LILING\Repplication]
GO
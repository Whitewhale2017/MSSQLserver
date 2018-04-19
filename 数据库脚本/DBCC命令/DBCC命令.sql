--DBCC ����������Բ�ѯ���е�DBCC ����
dbcc help ('?')

--���ָ�����ݿ�Ĵ��̿ռ����ṹ��һ����
DBCC checkcatalog

--��鵱ǰ���ݿ���ָ�����ϵ�ָ��Լ��������Լ����������
DBCC checkconstraints('TraceInfo.dbo.temp_trc_adv')

--ͨ��ִ�����в������ָ�����ݿ������ж�����߼�������������
DBCC checkdb('TraceInfo')

--��鵱ǰ���ݿ���ָ���ļ����е����б��������ͼ�ķ���ͽṹ�����ԡ�
DBCC checkfilegroup(1,noindex)

--���ָ����ĵ�ǰ��ʶֵ�����б�Ҫ������ı�ʶֵ��������ʹ�� DBCC CHECKIDENT Ϊ��ʶ���ֶ������µĵ�ǰ��ʶֵ��
DBCC checkident('TraceInfo.dbo.temp_trc_adv')
--�����ʾֵ
DBCC CHECKIDENT ('TraceInfo.dbo.temp_trc_adv', NORESEED);
--���ñ�ʾֵ
DBCC CHECKIDENT ('TraceInfo.dbo.temp_trc_adv', RESEED,474);


--�����ɱ��������ͼ������ҳ�ͽṹ�������ԡ�
DBCC checktable('TraceInfo.dbo.temp_trc_adv')

--���ձ��������ͼ����ɾ���Ŀɱ䳤���еĿռ�
DBCC cleantable(TraceInfo,'dbo.temp_trc_adv', 0)

--��ָ�����ݿ��еı���������һ����������
DBCC dbreindex('dbo.temp_trc_adv','IX_Clustered_EndTime',90)

--�ӻ������ɾ���������������
DBCC dropcleanbuffers

--ɾ���ƻ������е�����Ԫ�أ�ͨ��ָ���ƻ������ SQL ����Ӽƻ�����ɾ���ض��ƻ�������ɾ��ָ����Դ���е����й��������顣
DBCC freeproccache

--�����л������ͷ�����δʹ�õĻ�����Ŀ
DBCC freesystemcache('ALL')

--ˢ����� Microsoft SQL Server ʵ��ִ�еķֲ�ʽ��ѯ��ʹ�õķֲ�ʽ��ѯ���ӻ���
DBCC freesessioncache


--ָ�������ͼ��������Ƭ����
DBCC indexdefrag (TraceInfo, 'dbo.temp_trc_adv', IX_Clustered_EndTime)


--��ʾ�ӿͻ��˷��͵� Microsoft SQL Server 2005 ʵ�������һ�����,spidΪsession_id��request_id
DBCC inputbuffer(spid)


--��ʾ���ݿ��������Ϣ
DBCC opentran(11)

--��ʮ�����ƺ� ASCII ��ʽ����ָ�� session_id �ĵ�ǰ���������
DBCC outputbuffer(spid)

--�Ա���ʽ��ʾ�йع��̻������Ϣ
DBCC proccache

--��ʾָ�����ϵ�ָ��Ŀ��ĵ�ǰ�ַ�ͳ����Ϣ
DBCC show_statistics('dbo.temp_trc_adv','IX_Clustered_EndTime')


--��ʾָ���ı����ͼ�����ݺ���������Ƭ��Ϣ
DBCC showcontig('dbo.temp_trc_adv','IX_Clustered_EndTime')

--�������ݿⲢָ�����ÿռ�İٷֱ�
DBCC shrinkdatabase('TraceInfo',10)

--�ض����ݿ�
DBCC SHRINKDATABASE ('TraceInfo', TRUNCATEONLY);

--������ǰ���ݿ��ָ�����ݻ���־�ļ��Ĵ�С����ͨ�������ݴ�ָ�����ļ��ƶ�����ͬ�ļ����е������ļ�������ļ���
--����������ݿ���ɾ�����ļ����ļ���С�����������ȴ������ļ�ʱ��ָ���Ĵ�С��С�������Ὣ��С�ļ���С����Ϊ��ֵ��
DBCC shrinkfile('TestDB_log',1)


--���õȴ���������ͳ����Ϣ
DBCC sqlperf('sys.dm_os_wait_stats',clear)
--Ϊ�������ݿ��ṩ������־�ռ��÷���ͳ����Ϣ��
DBCC sqlperf(LOGSPACE)

--����ָ���ĸ��ٱ��
DBCC traceoff(ID)

--����ָ���ĸ��ٱ��
DBCC traceon(ID)


--��ʾ���ٱ�־��״̬
DBCC tracestatus(ID)

--���ص�ǰ���ӵĻ�����ã��� SET ѡ��
DBCC useroptions

--�����ݿ��еı��浽�ڴ��У��������ڴ治�ͷ�
DBCC PINTABLE ( database_id , table_id )

--�鿴�����ݺ������Ĵ洢�ṹ
DBCC IND(CSOS_NEW_2,OrderInfo,-1)
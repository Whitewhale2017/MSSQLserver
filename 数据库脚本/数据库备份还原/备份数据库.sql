BACKUP DATABASE TestLoggingShip TO DISK=N'F:\database_bak\TestLoggingShip.bak' 
WITH COMPRESSION --ѹ������
,DESCRIPTION ='���ݿ�TestLoggingShip����'--���ݿ�����,���255���ַ�
,NAME='���ݿ�TestLoggingShip����'--���ݿⱸ�����ƣ����128���ַ�
,PASSWORD='123'--Ϊ������������
,INIT --��������ͬ���ı���,NOINIT׷�ӵ�����ͬ���ı���
,NOSKIP --BACKUP ����ڿ��Ը���ý���ϵ����б��ݼ�֮ǰ�ȼ�����ǵĹ������ڡ�����Ĭ����Ϊ,SKIP���ñ��ݼ��Ĺ��ں����Ƽ��
,NOFORMAT--�Ƿ�Ӧ�������ڴ˱��ݲ����ľ���д��ý���ͷ���Ը����κ����е�ý���ͷ�ͱ��ݼ�,FORMATʹ���ݲ��������ڱ��ݲ���������ý�����д���µ�ý���ͷ


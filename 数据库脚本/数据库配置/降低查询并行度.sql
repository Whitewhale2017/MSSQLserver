--��������
sp_configure 'show advanced options', 1;

GO

RECONFIGURE WITH OVERRIDE;

GO
--Ϊ��������������в�ѯ�õ�6��CPU����ǰ������Ϊ24��CPU
sp_configure 'max degree of parallelism', 6;--������8��(��)cpu

GO
RECONFIGURE WITH OVERRIDE;

GO
--����ѯ������Ԥ����ѯ����10�����������в�ѯ������5��ΪϵͳĬ��
sp_configure 'cost threshold for parallelism', 10;--����ʱ������

GO

RECONFIGURE WITH OVERRIDE;

GO
--�ر�����
sp_configure 'show advanced options', 0;

GO
RECONFIGURE WITH OVERRIDE;

GO


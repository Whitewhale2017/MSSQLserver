DENY VIEW any DATABASE TO PUBLIC  --ɾ������Ĭ���û�����ȥsa�������ݿ����Ȩ��

GRANT VIEW any DATABASE TO PUBLIC   --��������Ĭ���û������ݿ����Ȩ��

DENY VIEW any DATABASE TO ehr

GRANT VIEW any DATABASE TO ehr

--��ע:�����û�ʱ,�û�ӳ���Ȳ���Ȩ��test���ݿ�

--ɾ���ܹ����߽��ܹ���ֵ��������ɫ

ALTER AUTHORIZATION ON DATABASE::workflow_ytx TO ehr
ALTER AUTHORIZATION ON DATABASE::YTX TO ehr
ALTER AUTHORIZATION ON DATABASE::YTX_ATS TO ehr


ALTER AUTHORIZATION ON DATABASE::workflow_ytx TO sa
ALTER AUTHORIZATION ON DATABASE::YTX TO sa
ALTER AUTHORIZATION ON DATABASE::YTX_ATS TO sa

select * from HrmResource 


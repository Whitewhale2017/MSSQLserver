 
 
-- ׼��������
--���ذ�װOracle�ͻ��˺�����Զ��Oracle�����tnsnames.ora��¼��
--�ҵ������ļ�tnsnames.ora���ļ�λ��ΪOracle��װĿ¼*\network\admin�£�������Զ�̷����磺
--OADB=
--  (DESCRIPTION =
--    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.254.41.52)(PORT = 1521))
--    (CONNECT_DATA =
--      (SERVER = DEDICATED)
--      (SERVICE_NAME = oadb)
--    )
 
 
 
 --�������ݿ����ӷ�����
EXEC sp_addlinkedserver
@server =N'OracleEcology', --Ҫ���������ӷ���������
@srvproduct=N'Oracle', --��Ʒ����
@provider=N'OraOLEDB.Oracle', --OLE DB ��������
@datasrc=N'oadb' --����Դoracle"ora10g"network"admin"tnsnames.ora�鿴

EXEC sp_addlinkedsrvlogin
 'OracleEcology', --�ѽ��������ӷ�������
'false', -- �̶� */ 
NULL, --Ϊÿ����½SQL SERVER���û�ʹ�ô����ӷ�����,��д�û���*/
'ecology', --�ʺ�(oracle)
'ecology' --����

SELECT * FROM openquery(OracleEcology,'SELECT * FROM hrmresource')

exec sp_serveroption 'OraclePolice','rpc out','true' 
exec sp_serveroption 'OraclePolice','rpc','true' 
--�������Ǵ�rpc,rpc out�ģ�Ĭ��ΪFalse,�򿪺����֧��Զ�̸��ķֲ�ʽ���񡣣����зֲ�ʽ�����������Ҫ���ã�


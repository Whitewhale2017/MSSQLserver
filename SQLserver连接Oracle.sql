 
 
-- ׼��������
--���ذ�װOracle�ͻ��˺�����Զ��Oracle�����tnsnames.ora��¼��
--�ҵ������ļ�tnsnames.ora���ļ�λ��ΪOracle��װĿ¼*\network\admin�£�������Զ�̷����磺
--OADB=
--  (DESCRIPTION =
--    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.4.172)(PORT = 1521))
--    (CONNECT_DATA =
--      (SERVER = DEDICATED)
--      (SERVICE_NAME = orcl)
--    )
 
 
 
 --�������ݿ����ӷ�����
EXEC sp_addlinkedserver
@server =N'DW', --Ҫ���������ӷ���������
@srvproduct=N'Oracle', --��Ʒ����
@provider=N'OraOLEDB.Oracle', --OLE DB ��������
@datasrc=N'DWDB' --����Դoracle"ora10g"network"admin"tnsnames.ora�鿴

EXEC sp_addlinkedsrvlogin
 'DW', --�ѽ��������ӷ�������
'false', -- �̶� */ 
NULL, --Ϊÿ����½SQL SERVER���û�ʹ�ô����ӷ�����,��д�û���*/
'DW_OA', --�ʺ�(oracle)
'Sansi1280' --����

SELECT * FROM openquery(DW,'select * from sap_acdoca');

exec sp_serveroption 'DW','rpc out','true' 
exec sp_serveroption 'DW','rpc','true' 
--�������Ǵ�rpc,rpc out�ģ�Ĭ��ΪFalse,�򿪺����֧��Զ�̸��ķֲ�ʽ���񡣣����зֲ�ʽ�����������Ҫ���ã�


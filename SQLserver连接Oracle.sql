 
 
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
 
 ----ODBC������TNS service name
 
 
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


-----------------------������ODBC����������---------------------

EXEC master.dbo.sp_addlinkedserver 
@server = N'PLM PRD', 
@srvproduct=N'Oracle', 
@provider=N'OraOLEDB.Oracle',
 @datasrc=N'192.168.4.135:1521/orcl' --------����Դֱ��д��ַ
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin 
@rmtsrvname=N'PLM PRD',
@useself=N'False',
@locallogin=NULL,
@rmtuser=N'SSPLM',
@rmtpassword='########'

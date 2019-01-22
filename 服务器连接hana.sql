---------------------------------------------------HANA QAS---------------------------------------
EXEC sp_addlinkedserver
@server = 'HANAQAS', ---Description
@srvproduct = 'HANA',   ---Description
@provider = 'MSDASQL',  ---Microsoft's OLE DB provider
@datasrc='HANAQAS' ---ODBC System DS

EXEC sp_addlinkedsrvlogin
@useself = 'FALSE',
@rmtsrvname = 'HANAQAS', --- same as above
@locallogin = NULL,
@rmtuser = 'SANGREAD',
@rmtpassword = 'Wyy123456'

--select * from HANAQAS.."_SYS_BIC"."TT_FIN_GLPOS_C"

select top 1000 * from HANAQAS.."SAPABAP1"."LQUA"  
select * from HANAQAS.."SAPABAP1"."LAGP"
--------------------------------------------------HANA PRD-----------------------------------------
EXEC sp_addlinkedserver
@server = 'HANAPRD', ---Description
@srvproduct = 'HANA',   ---Description
@provider = 'MSDASQL',  ---Microsoft's OLE DB provider
@datasrc='HANAPRD' ---ODBC System DS

EXEC sp_addlinkedsrvlogin
@useself = 'FALSE',
@rmtsrvname = 'HANAPRD', --- same as above
@locallogin = NULL,
@rmtuser = 'SANGREAD',
@rmtpassword = '11sanzsapK%'

select top 1000 * from HANAPRD.."SAPABAP1"."LQUA"  
------将SQL提交到远程服务器执行 方法1----------------
select * from openquery([HANAPRD],'select * from SAPABAP1.BKPF where bldat<=20181231')
------将SQL提交到远程服务器执行 方法2----------------
DECLARE @sql nvarchar(max)
SELECT @sql ='
DELETE 
FROM [AdventureWorks2008].[Sales].[SalesOrderDetail]
WHERE SalesOrderDetailID=5
    AND EXISTS(SELECT TOP 1 1 FROM [AdventureWorks2008].[Sales].[SalesOrderDetail])
'
exec [LINKSERVERNAME].[AdventureWorks2008].dbo.sp_executesql @sql

   
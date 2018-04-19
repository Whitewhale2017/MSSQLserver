select * from sys.sysprocesses WHERE [dbid]=7


select spid,count(*) from sys.sysprocesses WHERE [dbid]=7 and [status]<>N'sleeping'  group by spid HAVING count(*)>1

select count(*) from (select spid from sys.sysprocesses WHERE [dbid]=7 group by spid ) as a

select * from sys.sysprocesses WHERE spid=350

DBCC INPUTBUFFER(480)
DBCC INPUTBUFFER(296)
331
333
AutoGenerateOrderSystem_V2.dbo.UP_SystemConfig_GetModel;1
AutoGenerateOrderSystem_V2.dbo.UP_ProductFocus_ControlCenter;1
select COUNT(*) from sys.sysprocesses where [dbid]=7
select COUNT(*) from sys.sysprocesses where [dbid]<>7
DBCC INPUTBUFFER(58)
GO

DECLARE @SPID INT
DECLARE @SQL VARCHAR(MAX)
CREATE TABLE #TEMP
(
	SPID INT,
	TSQL_TEXT VARCHAR(MAX)
)
CREATE TABLE #TEMP_1
(
	EvnetType VARCHAR(100),
	Parameters int,
	TSQL_TEXT VARCHAR(MAX)
)
DECLARE CUR CURSOR FOR SELECT spid FROM sys.sysprocesses where [dbid]=7 
OPEN CUR
FETCH CUR INTO @SPID
WHILE @@FETCH_STATUS=0
BEGIN
	SET @SQL=N'DBCC INPUTBUFFER('+LTRIM(STR(@SPID))+')'
	INSERT INTO #TEMP_1 EXEC (@SQL)
	INSERT INTO #TEMP SELECT @SPID,TSQL_TEXT FROM #TEMP_1
	DELETE FROM #TEMP_1
	FETCH CUR INTO @SPID
END
CLOSE CUR
DEALLOCATE CUR
SELECT * FROM #TEMP
DROP TABLE #TEMP
DROP TABLE #TEMP_1
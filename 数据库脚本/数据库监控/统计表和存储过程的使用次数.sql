--每天更新追踪信息统计表信息
DECLARE @obj_id INT
DECLARE @name VARCHAR(100)
DECLARE @obj_type VARCHAR(10)
DECLARE @used_count INT 
DECLARE @DATE DATETIME 
DECLARE @QUERY_DATE DATE
SET @QUERY_DATE='2014-07-01'
DECLARE @last_search_date VARCHAR(10)
DECLARE CUR CURSOR FOR SELECT obj_id, name FROM dbo.ObjectTable
OPEN CUR
FETCH CUR INTO @obj_id,@name
WHILE @@FETCH_STATUS=0
BEGIN
	SET @name=N' '+@name+N' '
	SELECT @used_count=COUNT([EndTime]),@DATE=MAX([EndTime]) FROM dbo.temp_trc_adv WHERE CONTAINS(TextData,@name) AND CONVERT(DATE, [EndTime])=@QUERY_DATE
	IF(@used_count IS NULL)
	BEGIN
		SET @used_count=0
	END
	IF(@DATE IS NULL)
	BEGIN
		SET @last_search_date='0000-00-00'
	END
	ELSE
	BEGIN
		SET @last_search_date=CONVERT(VARCHAR(10),@DATE,120)
	END
	UPDATE dbo.ObjectTable 
	SET used_count=used_count+@used_count,
	last_search_date=(CASE 
	WHEN used_count=0 AND @used_count>0 THEN @last_search_date
	WHEN used_count>0 AND @used_count=0 THEN last_search_date
	ELSE @last_search_date END) WHERE obj_id=@obj_id
	FETCH CUR INTO @obj_id,@name
END
CLOSE CUR
DEALLOCATE CUR 

GO

UPDATE ObjectTable SET used_count=0, last_search_date=N'0000-00-00'

SELECT TextData, Duration*1.0/1000000 AS [Duration], StartTime, EndTime, Reads, Writes, CPU, [Type] INTO #TEMP FROM dbo.temp_trc WHERE Duration>10000000


SELECT * FROM ObjectTable ORDER BY last_search_date DESC

SELECT * FROM #TEMP ORDER BY last_search_date DESC

ALTER TABLE dbo.temp_trc_1 ALTER COLUMN TextData NVARCHAR(MAX) NULL

DELETE FROM temp_trc_1
INSERT INTO temp_trc_1(TextData, Duration, StartTime, EndTime, Reads, Writes, CPU, [Type])
SELECT TextData, Duration, StartTime, EndTime, Reads, Writes, CPU, [Type] FROM #TEMP 

SELECT * FROM temp_trc_1
WHERE (TextData LIKE 'UP_%' OR TextData LIKE 'sp_%') AND TextData<>'UP_Ebest24MinPrice_UPDATE'
DROP TABLE #TEMP
GO
--查询执行时间超过10秒的存储过程
Truncate table dbo.temp_trc_1
GO
INSERT INTO temp_trc_1(TextData, Duration, StartTime, EndTime, Reads, Writes, CPU, [Type])
SELECT TextData, Duration, StartTime, EndTime, Reads, Writes, CPU, [Type] 
FROM dbo.temp_trc WHERE Duration>10000000

SELECT *  INTO #TEMP FROM ObjectTable WHERE last_search_date<>N'0000-00-00' AND obj_type=N'user_table' ORDER BY used_count DESC

SELECT * FROM #TEMP

SELECT TOP 1000 * FROM dbo.temp_trc WHERE CONTAINS(TextData,N'tbProductCN') 
--AND CONTAINS(TextData,N'tbProductCN')
--AND  CONTAINS(TextData,N'ProductStatus') AND CONTAINS(TextData,N'ProductSpec') 
--AND CONTAINS(TextData,N'DISTINCT') 
ORDER BY Duration DESC

SELECT * FROM temp_trc WHERE CONVERT(DATE, [EndTime])='2014-04-29' AND SPID=335










GO
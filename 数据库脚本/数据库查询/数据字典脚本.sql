USE DatabaseDictionary
GO


IF OBJECT_ID('DBDictionary.ColumnInfo') IS NOT NULL
BEGIN
	DROP TABLE DBDictionary.ColumnInfo
END
GO
IF OBJECT_ID('DBDictionary.ObjectInfo') IS NOT NULL
BEGIN
	DROP TABLE DBDictionary.ObjectInfo
END
GO
IF OBJECT_ID('DBDictionary.ObjectInfoType') IS NOT NULL
BEGIN
	DROP TABLE DBDictionary.ObjectInfoType
END
GO
IF OBJECT_ID('DBDictionary.DatabaseInfo') IS NOT NULL
BEGIN
	DROP TABLE DBDictionary.DatabaseInfo
END
GO
IF OBJECT_ID('DBDictionary.IPInfo') IS NOT NULL
BEGIN
	DROP TABLE DBDictionary.IPInfo
END
GO
IF EXISTS(SELECT * FROM sys.schemas where name='DBDictionary')
DROP SCHEMA DBDictionary
GO


--创建架构

CREATE SCHEMA DBDictionary
GO

--创建IP表，记录所有服务器IP信息
CREATE TABLE DBDictionary.IPInfo
(
	IPID int identity(1,1) primary key not null,			--IPID用来作为标识
	IPAddress varchar(50) not null,							--IP地址，记录连接数据库的IP和端口号
	Remark nvarchar(100) null								--IP对应的说明
)
GO
--插入数据
INSERT INTO DBDictionary.IPInfo(IPAddress,Remark) VALUES(N'192.168.1.6',N'广告系统服务器')
INSERT INTO DBDictionary.IPInfo(IPAddress,Remark) VALUES(N'192.168.1.19,8824',N'ERP系统服务器')
INSERT INTO DBDictionary.IPInfo(IPAddress,Remark) VALUES(N'192.168.1.4',N'订单系统服务器')
INSERT INTO DBDictionary.IPInfo(IPAddress,Remark) VALUES(N'',N'BI服务器')
GO
--创建数据库表，记录所有IP下的所有用户创建的数据库

CREATE TABLE DBDictionary.DatabaseInfo
(
	DatabaseInfoID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,						--数据库标识
	Database_id int not null,													--数据库在每台服务器下的Database_id，可以直接用该Database_id去对应的服务器中sys.databases查询
	Database_name varchar(128) not null,										--数据库在每台服务器下的name，可以直接用该Database_name去对应的服务器中sys.databases查询
	IPID int foreign key references DBDictionary.IPInfo(IPID) not null,			--外键，引用DBDictionary.IPInfo表的字段IPID，IPID+Database_id在该表中唯一
	[CreateTime] datetime not null,												--数据库创建时间
	[Recovery_model_desc] varchar(10)  null,									--数据库恢复模式
	[Collation_name] varchar(50)  null,											--数据库排序规则
	[state_desc] varchar(10),													--数据库状态，ONLINE在线，只获取在线状态的数据库
	[is_read_only] int NULL,													--是否只读
	[IsPublished] int NULL,														--是否是发布数据库
	is_distributor int NULL,													--是否是分发数据库
	Remark nvarchar(100) null													--数据库说明
)
GO
--创建索引
CREATE NONCLUSTERED INDEX IX_IPID ON DBDictionary.DatabaseInfo(IPID)
GO
CREATE NONCLUSTERED INDEX IX_Database_name ON DBDictionary.DatabaseInfo(Database_name)
GO
CREATE NONCLUSTERED INDEX IX_Database_id ON DBDictionary.DatabaseInfo(Database_id)
GO
--导入数据
DECLARE @SQL NVARCHAR(MAX)
DECLARE @IPAddress VARCHAR(50)
DECLARE @IPID INT
DECLARE CUR CURSOR FOR SELECT IPID ,IPAddress FROM DBDictionary.IPInfo
OPEN CUR 
FETCH CUR INTO @IPID,@IPAddress
WHILE @@FETCH_STATUS=0
BEGIN
	IF(@IPAddress<>'')
	BEGIN
		SET @IPAddress=N'['+@IPAddress+N'].'
	END
	SET @SQL=N'SELECT database_id,name,'+LTRIM(STR(@IPID))+N',create_date,recovery_model_desc,collation_name,state_desc,[is_read_only],is_published ,is_distributor'
	SET @SQL=@SQL+N' FROM '+@IPAddress+N'master.sys.databases where name not in ('
	SET @SQL=@SQL+N'N''distribution'',N''master'',N''model'',N''msdb'',N''tempdb'',N''ReportServer'',N''ReportServerTempDB'') AND database_id<>32767 AND state_desc=''ONLINE'' order by name'
	INSERT INTO DBDictionary.DatabaseInfo(Database_id,Database_name,IPID,[CreateTime],[Recovery_model_desc],[Collation_name],[state_desc],[is_read_only],[IsPublished],is_distributor) 
	EXEC (@SQL)
	FETCH CUR INTO @IPID,@IPAddress
END
CLOSE CUR
DEALLOCATE CUR
GO
--创建对象类型表
CREATE TABLE DBDictionary.ObjectInfoType
(
	[Object_type_id] int identity(1,1) primary key not null,					--标识
	[Object_type_desc] varchar(40) not null,									--对象类型名称
	Remark nvarchar(100) null													--对象类型说明
)
GO
--导入数据，当前只导入用户创建的表
INSERT INTO DBDictionary.ObjectInfoType([Object_type_desc],Remark) VALUES(N'USER_TABLE',N'用户创建的表')
INSERT INTO DBDictionary.ObjectInfoType([Object_type_desc],Remark) VALUES(N'SQL_STORED_PROCEDURE',N'用户创建的存储过程')
GO
--创建对象信息表，记录所有数据库对象，当前只记录表对象

CREATE TABLE DBDictionary.ObjectInfo
(
	ObjectInfoID int identity(1,1) primary key not null,													--对象ID标识
	[Object_id] int not null,																				--对象在每一个服务器中的Object_id，可以在该对象所在数据库的sys.objects中查询到
	[Object_name] varchar(128) not null,																	--对象在每一个服务器中的name，可以在该对象所在数据库的sys.objects中查询到
	[DatabaseInfoID] int foreign key references DBDictionary.DatabaseInfo(DatabaseInfoID) not null,					--外键，数据库标识
	[Object_type_id] int foreign key references DBDictionary.ObjectInfoType([Object_type_id]) not null,				--外键，对象类型标识
	[CreateTime] datetime not null,																			--创建时间
	[LastUpdateTime] datetime not null,																		--最后一次修改时间
	[VersionTime] datetime not null,																		--导入到数据字典时间，第一次导入表数据时与最后一次修改时间相同，之后不同则代表不同的版本
	[Remark] nvarchar(100) null																				--对象说明
)
GO
CREATE NONCLUSTERED INDEX IX_DatabaseInfoID ON DBDictionary.ObjectInfo([DatabaseInfoID])
GO
CREATE NONCLUSTERED INDEX IX_Object_name ON DBDictionary.ObjectInfo([Object_name])
GO
CREATE NONCLUSTERED INDEX IX_VersionTime ON DBDictionary.ObjectInfo([VersionTime])
GO
CREATE NONCLUSTERED INDEX IX_LastUpdateTime ON DBDictionary.ObjectInfo([LastUpdateTime])
GO

--导入数据，由于排序规则不一致，可能需要手动匹配排序规则
CREATE TABLE #TEMP
(
	[Object_type_id] int ,
	[Object_type_desc] varchar(40) COLLATE Latin1_General_CI_AS_KS_WS
)
INSERT INTO #TEMP 
SELECT [Object_type_id],[Object_type_desc] FROM DBDictionary.ObjectInfoType
DECLARE @IPAddress VARCHAR(50)
DECLARE @DatabaseInfoID INT
DECLARE @Database_name VARCHAR(128)
DECLARE @SQL NVARCHAR(MAX)
DECLARE CUR CURSOR FOR
SELECT A.IPAddress,B.DatabaseInfoID,Database_name FROM DBDictionary.IPInfo AS A JOIN DBDictionary.DatabaseInfo AS B ON A.IPID=B.IPID
OPEN CUR
FETCH CUR INTO @IPAddress,@DatabaseInfoID,@Database_name
WHILE @@FETCH_STATUS=0
BEGIN
	IF(@IPAddress<>'')
	BEGIN
		SET @IPAddress=N'['+@IPAddress+N'].'
	END
	SET @SQL=N'SELECT OBJ.[Object_id],OBJ.name,OBJTYPE.[Object_type_id],'
	SET @SQL=@SQL+LTRIM(STR(@DatabaseInfoID))+N',OBJ.[create_date],OBJ.[modify_date],OBJ.[modify_date],convert(nvarchar(100),ex.value)'
	SET @SQL=@SQL+N' FROM '+@IPAddress+N'['+@Database_name+N'].sys.objects AS OBJ JOIN #TEMP AS OBJTYPE'
	SET @SQL=@SQL+N' ON OBJ.type_desc=OBJTYPE.[Object_type_desc]'
	SET @SQL=@SQL+N' LEFT JOIN '+@IPAddress+N'['+@Database_name+'].sys.extended_properties as ex '
	SET @SQL=@SQL+N' ON ex.major_id=OBJ.[object_id] AND ex.[class]=1 and ex.[minor_id]=0 '
	SET @SQL=@SQL+N' WHERE type_desc =''USER_TABLE'' order by name'
	INSERT INTO DBDictionary.ObjectInfo([Object_id], [Object_name], Object_type_id, DatabaseInfoID, CreateTime, LastUpdateTime,[VersionTime],Remark)
	EXEC(@SQL)
	SET @SQL=N'UPDATE DBDictionary.DatabaseInfo SET Remark=(SELECT TOP 1 CONVERT(NVARCHAR(100),ex.value) FROM '+@IPAddress+N'['+@Database_name+N'].sys.extended_properties AS ex WHERE ex.[class]=0)
	WHERE DatabaseInfoID='+CONVERT(VARCHAR(10),@DatabaseInfoID)
	EXEC(@SQL)
	FETCH CUR INTO @IPAddress,@DatabaseInfoID,@Database_name
END
CLOSE CUR
DEALLOCATE CUR
DROP TABLE #TEMP
GO

CREATE TABLE DBDictionary.ColumnInfo
(
	ColumnInfoID int identity(1,1) primary key not null,
	ObjectInfoID int foreign key references DBDictionary.ObjectInfo(ObjectInfoID) not null,
	column_id int not null,
	column_name varchar(128) not null,
	data_type varchar(20) not null,
	data_length int null,
	is_primarykey int not null,
	is_nullable int not null,
	is_identity int not null,
	is_computed int not null,
	Remark nvarchar(100) null
)

GO
CREATE NONCLUSTERED INDEX IX_ObjectInfoID ON DBDictionary.ColumnInfo(ObjectInfoID)
GO
SELECT IP.IPID,IP.IPAddress,DB.DatabaseInfoID,Database_name,OBJ.ObjectInfoID,[Object_id] into #temp FROM DBDictionary.IPInfo AS IP
JOIN DBDictionary.DatabaseInfo AS DB ON IP.IPID=DB.IPID
JOIN DBDictionary.ObjectInfo AS OBJ ON OBJ.DatabaseInfoID=DB.DatabaseInfoID
DECLARE @IPAddress VARCHAR(50)
DECLARE @IPID INT
DECLARE @DatabaseInfoID INT 
DECLARE @Database_id INT
DECLARE @Database_name VARCHAR(128)
DECLARE @SQL NVARCHAR(MAX)
DECLARE CUR CURSOR 
FOR SELECT IP.IPAddress, DB.Database_name,IP.IPID,DB.DatabaseInfoID,DB.Database_id
FROM DBDictionary.IPInfo AS IP
JOIN DBDictionary.DatabaseInfo AS DB ON IP.IPID=DB.IPID
OPEN CUR
FETCH CUR INTO @IPAddress,@Database_name,@IPID,@DatabaseInfoID,@Database_id
WHILE @@FETCH_STATUS=0
BEGIN
	IF(@IPAddress<>'')
	BEGIN
		SET @IPAddress=N'['+@IPAddress+N'].'
	END
	SET @SQL=N'
	select t.ObjectInfoID ,col.column_id ,col.name as cname,TY.name as tname,
	case when TY.name = ''nvarchar'' then col.max_length/2 else col.max_length end as data_length,
	case when exists (select 1 from '+@IPAddress+N'['+@Database_name+'].sys.key_constraints  as ky 
	join '+@IPAddress+N'['+@Database_name+'].sys.indexes as ix on ix.name =ky.name and ky.parent_object_id=ix.[object_id]
	join '+@IPAddress+N'['+@Database_name+'].sys.index_columns as icol on icol.[object_id] =ix.[object_id] and ix.index_id=icol.index_id
	where obj.[object_id] =ky.[parent_object_id] and icol.column_id=col.column_id) then 1 else 0 end as is_primarykey, 
	col.is_nullable,
	col.is_identity,
	col.is_computed,
	CONVERT(NVARCHAR(100),ex.value) as col_property 
	from '+@IPAddress+N'['+@Database_name+'].sys.objects as obj 
	join '+@IPAddress+N'['+@Database_name+'].sys.columns as col on obj.[object_id] =col.[object_id] 
	join '+@IPAddress+N'['+@Database_name+'].sys.types as ty on col.system_type_id=ty.system_type_id and ty.user_type_id=col.user_type_id
	left join '+@IPAddress+N'['+@Database_name+'].sys.extended_properties as ex on ex.major_id=col.[object_id] and ex.minor_id=col.column_id and ex.[class]=1
	join  #temp as t on t.[Object_id] = obj.[object_id]
	where obj.type_desc=''USER_TABLE'' AND t.IPID='+CONVERT(VARCHAR(10),@IPID)+N' AND t.DatabaseInfoID='+CONVERT(VARCHAR(10),@DatabaseInfoID)+
	N' order by obj.name,col.column_id'
	INSERT INTO DBDictionary.ColumnInfo(ObjectInfoID, column_id, column_name, data_type, data_length, is_primarykey,is_nullable, is_identity, is_computed, Remark)
	EXEC (@SQL)
	FETCH CUR INTO @IPAddress,@Database_name,@IPID,@DatabaseInfoID,@Database_id
END
CLOSE CUR
DEALLOCATE CUR
DROP TABLE #temp
GO

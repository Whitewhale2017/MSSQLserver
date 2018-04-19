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


--�����ܹ�

CREATE SCHEMA DBDictionary
GO

--����IP����¼���з�����IP��Ϣ
CREATE TABLE DBDictionary.IPInfo
(
	IPID int identity(1,1) primary key not null,			--IPID������Ϊ��ʶ
	IPAddress varchar(50) not null,							--IP��ַ����¼�������ݿ��IP�Ͷ˿ں�
	Remark nvarchar(100) null								--IP��Ӧ��˵��
)
GO
--��������
INSERT INTO DBDictionary.IPInfo(IPAddress,Remark) VALUES(N'192.168.1.6',N'���ϵͳ������')
INSERT INTO DBDictionary.IPInfo(IPAddress,Remark) VALUES(N'192.168.1.19,8824',N'ERPϵͳ������')
INSERT INTO DBDictionary.IPInfo(IPAddress,Remark) VALUES(N'192.168.1.4',N'����ϵͳ������')
INSERT INTO DBDictionary.IPInfo(IPAddress,Remark) VALUES(N'',N'BI������')
GO
--�������ݿ����¼����IP�µ������û����������ݿ�

CREATE TABLE DBDictionary.DatabaseInfo
(
	DatabaseInfoID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,						--���ݿ��ʶ
	Database_id int not null,													--���ݿ���ÿ̨�������µ�Database_id������ֱ���ø�Database_idȥ��Ӧ�ķ�������sys.databases��ѯ
	Database_name varchar(128) not null,										--���ݿ���ÿ̨�������µ�name������ֱ���ø�Database_nameȥ��Ӧ�ķ�������sys.databases��ѯ
	IPID int foreign key references DBDictionary.IPInfo(IPID) not null,			--���������DBDictionary.IPInfo����ֶ�IPID��IPID+Database_id�ڸñ���Ψһ
	[CreateTime] datetime not null,												--���ݿⴴ��ʱ��
	[Recovery_model_desc] varchar(10)  null,									--���ݿ�ָ�ģʽ
	[Collation_name] varchar(50)  null,											--���ݿ��������
	[state_desc] varchar(10),													--���ݿ�״̬��ONLINE���ߣ�ֻ��ȡ����״̬�����ݿ�
	[is_read_only] int NULL,													--�Ƿ�ֻ��
	[IsPublished] int NULL,														--�Ƿ��Ƿ������ݿ�
	is_distributor int NULL,													--�Ƿ��Ƿַ����ݿ�
	Remark nvarchar(100) null													--���ݿ�˵��
)
GO
--��������
CREATE NONCLUSTERED INDEX IX_IPID ON DBDictionary.DatabaseInfo(IPID)
GO
CREATE NONCLUSTERED INDEX IX_Database_name ON DBDictionary.DatabaseInfo(Database_name)
GO
CREATE NONCLUSTERED INDEX IX_Database_id ON DBDictionary.DatabaseInfo(Database_id)
GO
--��������
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
--�����������ͱ�
CREATE TABLE DBDictionary.ObjectInfoType
(
	[Object_type_id] int identity(1,1) primary key not null,					--��ʶ
	[Object_type_desc] varchar(40) not null,									--������������
	Remark nvarchar(100) null													--��������˵��
)
GO
--�������ݣ���ǰֻ�����û������ı�
INSERT INTO DBDictionary.ObjectInfoType([Object_type_desc],Remark) VALUES(N'USER_TABLE',N'�û������ı�')
INSERT INTO DBDictionary.ObjectInfoType([Object_type_desc],Remark) VALUES(N'SQL_STORED_PROCEDURE',N'�û������Ĵ洢����')
GO
--����������Ϣ����¼�������ݿ���󣬵�ǰֻ��¼�����

CREATE TABLE DBDictionary.ObjectInfo
(
	ObjectInfoID int identity(1,1) primary key not null,													--����ID��ʶ
	[Object_id] int not null,																				--������ÿһ���������е�Object_id�������ڸö����������ݿ��sys.objects�в�ѯ��
	[Object_name] varchar(128) not null,																	--������ÿһ���������е�name�������ڸö����������ݿ��sys.objects�в�ѯ��
	[DatabaseInfoID] int foreign key references DBDictionary.DatabaseInfo(DatabaseInfoID) not null,					--��������ݿ��ʶ
	[Object_type_id] int foreign key references DBDictionary.ObjectInfoType([Object_type_id]) not null,				--������������ͱ�ʶ
	[CreateTime] datetime not null,																			--����ʱ��
	[LastUpdateTime] datetime not null,																		--���һ���޸�ʱ��
	[VersionTime] datetime not null,																		--���뵽�����ֵ�ʱ�䣬��һ�ε��������ʱ�����һ���޸�ʱ����ͬ��֮��ͬ�����ͬ�İ汾
	[Remark] nvarchar(100) null																				--����˵��
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

--�������ݣ������������һ�£�������Ҫ�ֶ�ƥ���������
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

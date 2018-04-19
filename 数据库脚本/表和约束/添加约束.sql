/*
	添加表
*/
CREATE TABLE TEST 
(
	ID INT IDENTITY(1,1) NOT NULL,
	NAME NVARCHAR(20) NOT NULL,
	SEX SMALLINT NOT NULL,
	CREATETIME DATETIME NOT NULL
)
GO
CREATE TABLE TEST1
(
	TID INT IDENTITY(1,1) NOT NULL,
	NAME NVARCHAR(20) NOT NULL,
	ID INT NOT NULL
)
GO
/*
	添加约束
*/
--添加主键约束
ALTER TABLE TEST
ADD CONSTRAINT PK_TEST PRIMARY KEY(ID)
--添加外键
ALTER TABLE TEST1
ADD CONSTRAINT FK_TEST1_ID FOREIGN KEY(ID) REFERENCES TEST(ID)
--添加默认约束
ALTER TABLE TEST
ADD CONSTRAINT DF_CREATETIME DEFAULT(GETDATE()) FOR CREATETIME
--添加检查约束
ALTER TABLE TEST
ADD CONSTRAINT CK_SEX CHECK(SEX=0 OR SEX=1)
--添加唯一约束，注意：唯一约束添加后会生成一个唯一索引
ALTER TABLE TEST
ADD CONSTRAINT UQ_NAME UNIQUE(NAME)
GO 
--添加主键非聚集索引

ALTER TABLE TEST1
ADD CONSTRAINT PK_TEST1 PRIMARY KEY NONCLUSTERED (TID) 
GO
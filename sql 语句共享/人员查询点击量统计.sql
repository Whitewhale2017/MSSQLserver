--------------统计**功能的点击量
create table CountClickAmount(
	id int identity(1,1) primary key not null,
	functionName varchar(50) null,
	amount int null
)

--------------统计**功能的详细点击量
--drop table CountClickAmountDetail
create table CountClickAmountDetail(
	id int identity(1,1) primary key not null,
	useid int null,--点击人
	clientip varchar(100) null,--点击人ip
	clickdate varchar(20) null,--点击人日期
	clicktime varchar(20) null --点击人时间
)
-------------统计查询人查询人员的次数
create table CountClickCheckHrm(
	id int identity(1,1) primary key not null,
	cxhrm int null,--查询人  
	bcxhrm varchar(50) null,--被查询人
	bcxhrmteam varchar(200) null,--被查询人公司 
	clientip varchar(100) null,--点击人ip
	clickdate varchar(20) null,--点击人日期
	clicktime varchar(20) null --点击人时间
)
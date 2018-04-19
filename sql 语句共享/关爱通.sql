)
--关爱通同步日志
create table gat_execute_log(
	id int identity(1,1) primary key NOT NULL,
	workcode varchar(50) NOT NULL,
	name varchar(50) NOT NULL,
	error_code varchar(50) NOT NULL,
	error_message varchar(100) NOT NULL,
	create_time varchar(25) NOT NULL
)
--关爱通登陆日志记录表
create table guanaitonginfo(
    id int identity(1,1) primary key not null,
    userid int null,
    workcode varchar(10) null, 
    error_code varchar(10) null,
    error_message varchar(200) null,
    auth_code char(100) null,
    operationtime char(20) null
)
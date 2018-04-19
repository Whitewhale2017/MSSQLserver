create table DepartmentFQ(
	id int IDENTITY(1,1) NOT NULL,
	subcompanyid int null,--公司
	departmentids varchar(2000) NULL --部门
)
create table DepartmentFQCheck(
	id int IDENTITY(1,1) not null,
	userid int null, --人员id
	loginid varchar(20) null, --登录名
	operatype varchar(10) null, --操作类型
	operatedate char(10) null, --操作日期
        operatetime char(8) null   --操作时间
)
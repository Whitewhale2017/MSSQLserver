create table DepartmentFQ(
	id int IDENTITY(1,1) NOT NULL,
	subcompanyid int null,--��˾
	departmentids varchar(2000) NULL --����
)
create table DepartmentFQCheck(
	id int IDENTITY(1,1) not null,
	userid int null, --��Աid
	loginid varchar(20) null, --��¼��
	operatype varchar(10) null, --��������
	operatedate char(10) null, --��������
        operatetime char(8) null   --����ʱ��
)
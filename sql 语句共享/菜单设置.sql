create table menuSetList(
	id int identity(1,1) primary key not null,--������ID
	menuName varchar(100) null,--�˵�����
	parentMenu int null,
	menuGroup int null,
	showder char(10) null,
	urlLink varchar(300) null,
	isOpen char(1)
)


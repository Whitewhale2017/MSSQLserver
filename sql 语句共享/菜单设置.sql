create table menuSetList(
	id int identity(1,1) primary key not null,--自增长ID
	menuName varchar(100) null,--菜单名称
	parentMenu int null,
	menuGroup int null,
	showder char(10) null,
	urlLink varchar(300) null,
	isOpen char(1)
)


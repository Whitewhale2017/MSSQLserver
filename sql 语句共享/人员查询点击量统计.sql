--------------ͳ��**���ܵĵ����
create table CountClickAmount(
	id int identity(1,1) primary key not null,
	functionName varchar(50) null,
	amount int null
)

--------------ͳ��**���ܵ���ϸ�����
--drop table CountClickAmountDetail
create table CountClickAmountDetail(
	id int identity(1,1) primary key not null,
	useid int null,--�����
	clientip varchar(100) null,--�����ip
	clickdate varchar(20) null,--���������
	clicktime varchar(20) null --�����ʱ��
)
-------------ͳ�Ʋ�ѯ�˲�ѯ��Ա�Ĵ���
create table CountClickCheckHrm(
	id int identity(1,1) primary key not null,
	cxhrm int null,--��ѯ��  
	bcxhrm varchar(50) null,--����ѯ��
	bcxhrmteam varchar(200) null,--����ѯ�˹�˾ 
	clientip varchar(100) null,--�����ip
	clickdate varchar(20) null,--���������
	clicktime varchar(20) null --�����ʱ��
)
/*Memery��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Page Faults/sec','ÿ���ӳ���ҳ���ƽ������',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Page Reads/sec','��ȡ�����Խ���Ӳҳ�������ٶ�',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Page Writes/sec','Ϊ���ͷ������ڴ�ռ����ҳ��д����̵��ٶ�',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pages Input/sec','�Ӵ���ȡ��ҳ���Խ���Ӳҳ�������ٶ�',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pages Output/sec','Ϊ���ͷ������ڴ�ռ����ҳ��д����̵��ٶ�',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pages/sec','Ϊ���Ӳҳ����Ӵ��̶�ȡ��д����̵��ٶ�',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pool Nonpaged Allocs','�ڷǷ�ҳ���з��ɿռ�ĵ�����',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pool Nonpaged Bytes','�ڷǷ�ҳ���е��ֽ������Ƿ�ҳ����ָϵͳ�ڴ�(����ϵͳʹ�õ������ڴ�)�пɹ�����(ָ��Щ�ڲ�����ʹ��ʱ������д������϶���ֻҪ���ɹ��ͱ��뱣���������ڴ��еĶ���)ʹ�õ�һ������',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pool Paged Allocs','�ڷ�ҳ���з��ɿռ�ĵ��ô���',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pool Paged Bytes','�ڷ�ҳ���е��ֽ�������ҳ����ϵͳ�ڴ�(����ϵͳʹ�õ������ڴ�)�пɹ�����(�ڲ�����ʹ��ʱ����д����̵�)ʹ�õ�һ������',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pool Paged Resident Bytes','��ҳ�صĵ�ǰ��С���ֽ���',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Available bytes','���ֽڱ�ʾ�������ڴ����������ڴ������̷����һ�����̻�ϵͳʹ��',NULL)
GO

/*PhysicalDisk��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\% Disk Time','��ѡ����������æ��Ϊ����д�������ṩ�������õ�ʱ��İٷֱ�',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Avg. Disk Bytes/Read','�ڶ�ȡ����ʱ�Ӵ����ϴ��͵��ֽ�ƽ����',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Avg. Disk Bytes/Write','��д�����ʱ�Ӵ����ϴ��͵��ֽ�ƽ����',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Avg. Disk Queue Length','��ȡ��д������(Ϊ��ѡ������ʵ��������жӵ�)��ƽ����',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Current Disk Queue Length','�����ռ���������ʱ�����ϵ�ǰ����������',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Disk Bytes/sec','�ڽ���д����ȡ����ʱ�Ӵ����ϴ��ͻ򴫳����ֽ�����',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Avg. Disk Read Queue Length','��ȡ����(Ϊ��ѡ������ʵ��������жӵ�)��ƽ����',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Avg. Disk Write Queue Length','д������(Ϊ��ѡ������ʵ��������жӵ�)��ƽ����',NULL)
GO

/*Process ��������Ϣ*/

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Process\Private Bytes','���������������������ġ��ѷ���ĵ�ǰ�ֽ���',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Process\Working Set','�������� Working Set �еĵ�ǰ�ֽ���',NULL)
GO

/*Processor ��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Processor\% Processor Time','����������ִ�з������߳�ʱ��İٷֱ�',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Processor\% Privileged Time','����Ȩģʽ�½����߳�ִ�д�������ʱ��İٷֱ�',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Processor\% User Time','�����������û�ģʽ��ʱ��ٷֱ�',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Processor\Interrupts/sec','���������պʹ���Ӳ���жϵ�ƽ���ٶȣ���λΪÿ��������',NULL)
GO
/*Server ��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Server\bytes Total/sec','�������������Ϸ��ͺͽ��յ��ֽ�������ֵ��ʾ�˷������������ж�æ',NULL)
GO
/*SQLServer:Access Methods ��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLServer:Access Methods\Full Scans/sec','ÿ�벻�����Ƶ���ȫɨ��������Щɨ������ǻ���ɨ�裬Ҳ������ȫ������ɨ��',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLServer:Access Methods\Index Searches/sec','ÿ��������������������������������Χɨ�衢���¶�λ��Χɨ�衢������֤ɨ��㡢��ȡ����������¼�Լ���������������ȷ�����еĲ���λ�á�',NULL)
GO
/*SQLServer:Buffer Manager ��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Buffer cache hit ratio','����������',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Checkpoint pages/sec','�����ύҳ��',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Lazy writes/sec','����д�����ύҳ��',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Page life expectancy','ҳ����������','����300')
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Stolen pages','����������������;���������̻��棩��ҳ��',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Target Pages','������������ҳ��',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Total Pages','������е�ҳ�����������ݿ�ҳ������ҳ�ͱ���ҳ��',NULL)
GO
/*SQLServer:Databases ��������Ϣ*/

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Databases\Active Transactions','���ݿ�Ļ������',NULL)
GO
/*SQLServer:General Statistics ��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:General Statistics\Active Temp Tables','����ʹ�õ���ʱ��/���������Ŀ',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:General Statistics\User Connections','��ǰ�� SQL Server ���ӵ��û���',NULL)
GO
/*SQLServer:Memory Manager ��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Memory Manager\Connection Memory (KB)','��������������ά�����ӵĶ�̬�ڴ�����',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Memory Manager\Target Server Memory (KB)','�������ܹ�ʹ�õĶ�̬�ڴ�����',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Memory Manager\SQL Cache Memory (KB)','�������������ڶ�̬ SQL ���ٻ���Ķ�̬�ڴ�����',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Memory Manager\Total Server Memory (KB)','�ӻ�����ύ���ڴ� (KB)���ⲻ�� SQL Server ʹ�õ����ڴ�',NULL)
GO
/*SQLServer:Plan Cache ��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Plan Cache\Cache Hit Ratio','���ٻ������д����Ͳ��Ҵ����ı���',NULL)
GO
/*SQLServer:SQL Statistics ��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:SQL Statistics\Auto-Param Attempts/sec','ÿ����Զ�������������',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:SQL Statistics\Batch Requests/sec','ÿ���յ��� Transact-SQL ��������',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:SQL Statistics\SQL Re-Compilations/sec','ÿ��ı�����',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:SQL Statistics\SQL Compilations/sec','ÿ��������±���Ĵ���',NULL)
GO

/*SQLServer:Transactions ��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Transactions\Transactions','��ǰ����������͵��������Ŀ',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Transactions\Free Space in tempdb (KB)','tempdb �еĿ��ÿռ��� (KB)',NULL)
GO

/*System ��������Ϣ*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('System\Context Switches/sec','������ϵ����д�����ȫ����һ���߳��л�����һ���̵߳��ۺ�����',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('System\Processor Queue Length','���������е��߳�����',NULL)
GO

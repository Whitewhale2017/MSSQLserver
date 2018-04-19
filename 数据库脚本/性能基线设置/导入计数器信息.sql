/*Memery计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Page Faults/sec','每秒钟出错页面的平均数量',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Page Reads/sec','读取磁盘以解析硬页面错误的速度',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Page Writes/sec','为了释放物理内存空间而将页面写入磁盘的速度',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pages Input/sec','从磁盘取读页面以解析硬页面错误的速度',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pages Output/sec','为了释放物理内存空间而将页面写入磁盘的速度',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pages/sec','为解决硬页错误从磁盘读取或写入磁盘的速度',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pool Nonpaged Allocs','在非分页池中分派空间的调用数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pool Nonpaged Bytes','在非分页池中的字节数，非分页池是指系统内存(操作系统使用的物理内存)中可供对象(指那些在不处于使用时不可以写入磁盘上而且只要分派过就必须保留在物理内存中的对象)使用的一个区域。',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pool Paged Allocs','在分页池中分派空间的调用次数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pool Paged Bytes','在分页池中的字节数，分页池是系统内存(操作系统使用的物理内存)中可供对象(在不处于使用时可以写入磁盘的)使用的一个区域',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Pool Paged Resident Bytes','分页池的当前大小的字节数',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Memory\Available bytes','以字节表示的物理内存数量。此内存能立刻分配给一个进程或系统使用',NULL)
GO

/*PhysicalDisk计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\% Disk Time','所选磁盘驱动器忙于为读或写入请求提供服务所用的时间的百分比',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Avg. Disk Bytes/Read','在读取操作时从磁盘上传送的字节平均数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Avg. Disk Bytes/Write','在写入操作时从磁盘上传送的字节平均数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Avg. Disk Queue Length','读取和写入请求(为所选磁盘在实例间隔中列队的)的平均数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Current Disk Queue Length','是在收集性能数据时磁盘上当前的请求数量',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Disk Bytes/sec','在进行写入或读取操作时从磁盘上传送或传出的字节速率',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Avg. Disk Read Queue Length','读取请求(为所选磁盘在实例间隔中列队的)的平均数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('PhysicalDisk\Avg. Disk Write Queue Length','写入请求(为所选磁盘在实例间隔中列队的)的平均数',NULL)
GO

/*Process 计数器信息*/

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Process\Private Bytes','这个处理不能与其他处理共享的、已分配的当前字节数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Process\Working Set','这个处理的 Working Set 中的当前字节数',NULL)
GO

/*Processor 计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Processor\% Processor Time','处理器用来执行非闲置线程时间的百分比',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Processor\% Privileged Time','在特权模式下进程线程执行代码所花时间的百分比',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Processor\% User Time','处理器处于用户模式的时间百分比',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Processor\Interrupts/sec','处理器接收和处理硬件中断的平均速度，单位为每秒事例数',NULL)
GO
/*Server 计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('Server\bytes Total/sec','服务器从网络上发送和接收的字节数。该值显示了服务器大体上有多忙',NULL)
GO
/*SQLServer:Access Methods 计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLServer:Access Methods\Full Scans/sec','每秒不受限制的完全扫描数。这些扫描可以是基表扫描，也可以是全文索引扫描',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLServer:Access Methods\Index Searches/sec','每秒索引搜索数。索引搜索用于启动范围扫描、重新定位范围扫描、重新验证扫描点、提取单个索引记录以及向下搜索索引以确定新行的插入位置。',NULL)
GO
/*SQLServer:Buffer Manager 计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Buffer cache hit ratio','缓存命中率',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Checkpoint pages/sec','检查点提交页数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Lazy writes/sec','惰性写入器提交页数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Page life expectancy','页面生存周期','大于300')
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Stolen pages','用于其他服务器用途（包括过程缓存）的页数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Target Pages','缓冲池中理想的页数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Buffer Manager\Total Pages','缓冲池中的页数（包括数据库页、可用页和被盗页）',NULL)
GO
/*SQLServer:Databases 计数器信息*/

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Databases\Active Transactions','数据库的活动事务数',NULL)
GO
/*SQLServer:General Statistics 计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:General Statistics\Active Temp Tables','正在使用的临时表/表变量的数目',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:General Statistics\User Connections','当前与 SQL Server 连接的用户数',NULL)
GO
/*SQLServer:Memory Manager 计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Memory Manager\Connection Memory (KB)','服务器正在用来维护连接的动态内存总量',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Memory Manager\Target Server Memory (KB)','服务器能够使用的动态内存总量',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Memory Manager\SQL Cache Memory (KB)','服务器正在用于动态 SQL 高速缓存的动态内存总数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Memory Manager\Total Server Memory (KB)','从缓冲池提交的内存 (KB)。这不是 SQL Server 使用的总内存',NULL)
GO
/*SQLServer:Plan Cache 计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Plan Cache\Cache Hit Ratio','高速缓存命中次数和查找次数的比率',NULL)
GO
/*SQLServer:SQL Statistics 计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:SQL Statistics\Auto-Param Attempts/sec','每秒的自动参数化尝试数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:SQL Statistics\Batch Requests/sec','每秒收到的 Transact-SQL 命令批数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:SQL Statistics\SQL Re-Compilations/sec','每秒的编译数',NULL)
GO
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:SQL Statistics\SQL Compilations/sec','每秒语句重新编译的次数',NULL)
GO

/*SQLServer:Transactions 计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Transactions\Transactions','当前活动的所有类型的事务的数目',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('SQLSERVER:Transactions\Free Space in tempdb (KB)','tempdb 中的可用空间量 (KB)',NULL)
GO

/*System 计数器信息*/
insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('System\Context Switches/sec','计算机上的所有处理器全都从一个线程切换到另一个线程的综合速率',NULL)
GO

insert into PerfMonCountInfo(PerfMonCountName, PerfMonCount_Desc, PerfMon_Value_DESC)
values('System\Processor Queue Length','处理器队列的线程数量',NULL)
GO

--DBCC 帮助命令，可以查询所有的DBCC 命令
dbcc help ('?')

--检查指定数据库的磁盘空间分配结构的一致性
DBCC checkcatalog

--检查当前数据库中指定表上的指定约束或所有约束的完整性
DBCC checkconstraints('TraceInfo.dbo.temp_trc_adv')

--通过执行下列操作检查指定数据库中所有对象的逻辑和物理完整性
DBCC checkdb('TraceInfo')

--检查当前数据库中指定文件组中的所有表和索引视图的分配和结构完整性。
DBCC checkfilegroup(1,noindex)

--检查指定表的当前标识值，如有必要，则更改标识值。还可以使用 DBCC CHECKIDENT 为标识列手动设置新的当前标识值。
DBCC checkident('TraceInfo.dbo.temp_trc_adv')
--报告标示值
DBCC CHECKIDENT ('TraceInfo.dbo.temp_trc_adv', NORESEED);
--重置标示值
DBCC CHECKIDENT ('TraceInfo.dbo.temp_trc_adv', RESEED,474);


--检查组成表或索引视图的所有页和结构的完整性。
DBCC checktable('TraceInfo.dbo.temp_trc_adv')

--回收表或索引视图中已删除的可变长度列的空间
DBCC cleantable(TraceInfo,'dbo.temp_trc_adv', 0)

--对指定数据库中的表重新生成一个或多个索引
DBCC dbreindex('dbo.temp_trc_adv','IX_Clustered_EndTime',90)

--从缓冲池中删除所有清除缓冲区
DBCC dropcleanbuffers

--删除计划缓存中的所有元素，通过指定计划句柄或 SQL 句柄从计划缓存删除特定计划，或者删除指定资源池中的所有工作负荷组。
DBCC freeproccache

--从所有缓存中释放所有未使用的缓存条目
DBCC freesystemcache('ALL')

--刷新针对 Microsoft SQL Server 实例执行的分布式查询所使用的分布式查询连接缓存
DBCC freesessioncache


--指定表或视图的索引碎片整理
DBCC indexdefrag (TraceInfo, 'dbo.temp_trc_adv', IX_Clustered_EndTime)


--显示从客户端发送到 Microsoft SQL Server 2005 实例的最后一个语句,spid为session_id或request_id
DBCC inputbuffer(spid)


--显示数据库的事务信息
DBCC opentran(11)

--以十六进制和 ASCII 格式返回指定 session_id 的当前输出缓冲区
DBCC outputbuffer(spid)

--以表格格式显示有关过程缓存的信息
DBCC proccache

--显示指定表上的指定目标的当前分发统计信息
DBCC show_statistics('dbo.temp_trc_adv','IX_Clustered_EndTime')


--显示指定的表或视图的数据和索引的碎片信息
DBCC showcontig('dbo.temp_trc_adv','IX_Clustered_EndTime')

--收缩数据库并指定可用空间的百分比
DBCC shrinkdatabase('TraceInfo',10)

--截断数据库
DBCC SHRINKDATABASE ('TraceInfo', TRUNCATEONLY);

--收缩当前数据库的指定数据或日志文件的大小，或通过将数据从指定的文件移动到相同文件组中的其他文件来清空文件，
--以允许从数据库中删除该文件。文件大小可以收缩到比创建该文件时所指定的大小更小。这样会将最小文件大小重置为新值。
DBCC shrinkfile('TestDB_log',1)


--重置等待和闩锁的统计信息
DBCC sqlperf('sys.dm_os_wait_stats',clear)
--为所有数据库提供事务日志空间用法的统计信息。
DBCC sqlperf(LOGSPACE)

--禁用指定的跟踪标记
DBCC traceoff(ID)

--启用指定的跟踪标记
DBCC traceon(ID)


--显示跟踪标志的状态
DBCC tracestatus(ID)

--返回当前连接的活动（设置）的 SET 选项
DBCC useroptions

--将数据库中的表缓存到内存中，并锁定内存不释放
DBCC PINTABLE ( database_id , table_id )

--查看表数据和索引的存储结构
DBCC IND(CSOS_NEW_2,OrderInfo,-1)
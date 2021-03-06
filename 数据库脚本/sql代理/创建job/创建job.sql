--创建job
USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'test',						--job名称
		@enabled=1,													--是否启用，1为启用，0为不启用	
		@notify_level_eventlog=0,									--用于指示是否将该作业的项放入 Microsoft Windows 应用程序日志，0从不，1成功，2失败，3始终
		@notify_level_email=3,										--用于指示完成该作业后是否发送电子邮件，0从不，1成功，2失败，3始终
		@notify_level_netsend=2,									--用于指示完成该作业后是否发送网络消息，0从不，1成功，2失败，3始终
		@notify_level_page=2,										--用于指示完成该作业后是否发送寻呼，0从不，1成功，2失败，3始终
		@delete_level=0,											--用于指示是否执行完作业后删除作业，0从不，1成功，2失败，3始终
		@description=N'这是一个测试。',								--job的描述或介绍。 
		@category_name=N'[Uncategorized (Local)]',					--job的类别
		@owner_login_name=N'HOFAN-SZ\liling',						--job所属登录账户名
		@notify_email_operator_name=N'jack',						--job的邮件操作员
		@job_id = @jobId OUTPUT										--job的标识
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver 
		@job_name=N'test',											--job的标识
		@server_name = N'DEV-LILING'								--该job的目标服务器的名称
GO
--创建步骤
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep										
		@job_name=N'test',											--要添加步骤的job的名称
		@step_name=N'step1',										--步骤的名称
		@step_id=1,													--步骤的顺序
		@cmdexec_success_code=0,									--CmdExec 子系统命令返回的值，用于指示 command 已成功执行,默认为0
		@on_success_action=1,										--步骤成功时执行的操作，1成功后退出，2失败后退出，3转到下一步,4转到步骤on_success_step_id
		@on_success_step_id=0,										--步骤成功并且 @on_success_action 的值为 4 时，该作业中要执行的步骤的 ID，默认值为 0
		@on_fail_action=2,											--步骤失败时执行的操作,1成功后退出，2失败后退出，3转到下一步,4转到步骤on_success_step_id
		@on_fail_step_id =0,										--步骤失败并且 fail_action 的值为 4 时，该作业中要执行的步骤的 ID，默认值为 0
		@retry_attempts=0,											--该步骤失败时的重试次数，默认值为 0，指示不重试
		@retry_interval=0,											--两次重试之间的间隔时间（分钟）。
		@os_run_priority=0,											--保留
		@subsystem=N'TSQL',											--SQL Server 代理服务用于执行 command 的子系统：
																	--'ACTIVESCRIPTING'活动脚本
																	--'CMDEXEC'操作系统命令或可执行程序
																	--'DISTRIBUTION'复制分发代理作业
																	--'SNAPSHOT'复制快照代理作业
																	--'LOGREADER'复制日志读取器代理作业
																	--'MERGE'复制合并代理作业
																	--'QueueReader'复制队列读取器代理作业
																	--'ANALYSISQUERY'Analysis Services 查询 (MDX、DMX)。
																	--'ANALYSISCOMMAND'Analysis Services 命令 (XMLA)。
																	--'Dts'Integration Services 包执行
																	--'PowerShell'PowerShell 脚本
																	--'TSQL'（默认）Transact-SQL 语句
		@command=N'SELECT TOP 1000 [ClassID]					
      ,[ClassName]
  FROM [TestLoggingShip].[dbo].[tb_Class]',							--SQLServerAgent 服务通过 subsystem 执行的命令
		@database_name=N'TestLoggingShip',							--在其中执行 Transact-SQL 步骤的数据库的名称
		@output_file_name=N'F:\testR\a.txt',						--用于保存该步骤输出的文件的名称
		@flags=0													--控制行为的选项，0覆盖输出文件，2追加到输出文件，4将 Transact-SQL 作业步骤输出写入步骤历史记录，
																	--8将日志写入表（覆盖现有的历史记录），16将日志写入表中（追加到现有历史记录）
GO
--更新job信息
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'test', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=3, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'这是一个测试。', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'HOFAN-SZ\liling', 
		@notify_email_operator_name=N'jack', 
		@notify_netsend_operator_name=N'', 
		@notify_page_operator_name=N''
GO
--创建计划
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule 
		@job_name=N'test',							--添加计划的job名称	
		@name=N'plan1',								--计划的名称
		@enabled=1,									--是否启用，0为不启用，1为启用
		@freq_type=4,								--指示作业执行时间的值，1一次，4每天，8每周，16每月，32每月，相对于 frequency_interval，64 在 SQL Server 代理服务启动时运行，128 在计算机空闲时运行。
		@freq_interval=1,							--执行作业的日期：
													/*
													1（一次）不使用 frequency_interval
													4（每天）每 frequency_interval 天。
													8（每周）frequency_interval 是下面的一个或多个值（用逻辑运算符 OR 组合）：
													1 = 星期日
													2 = 星期一
													4 = 星期二
													8 = 星期三
													16 = 星期四
													32 = 星期五
													64 = 星期六
													16（每月）每月的 frequency_interval 天。
													32（与“每月”选项相关）frequency_interval 是下列值之一：
													1 = 星期日
													2 = 星期一
													3 = 星期二
													4 = 星期三
													5 = 星期四
													6 = 星期五
													7 = 星期六
													8 = 天
													9 = 工作日
													10 = 休息日
													64（SQL Server 代理服务启动时）不使用 frequency_interval。
													128 不使用 frequency_interval。*/
		@freq_subday_type=1,						--指定 frequency_subday_interval 的单位
		@freq_subday_interval=0,					--两次执行作业之间间隔的 frequency_subday_type 周期数
		@freq_relative_interval=0,					--当 frequency_type 设置为 32（“每月”选项相关）时，该参数进一步定义 frequency_interval 
		@freq_recurrence_factor=1,					--作业的两次计划执行之间的间隔周数或月数
		@active_start_date=20150317,				--可以开始执行作业的日期。active_start_date 的数据类型为 int，无默认值。日期的格式为 YYYYMMDD。如果设置 active_start_date，则日期必须大于或等于 19900101
		@active_end_date=99991231,					--可以停止执行作业的日期
		@active_start_time=100000,					--在 active_start_date 和 active_end_date 之间的任意日期开始执行作业的时间。active_start_time 的数据类型为 int，无默认值。时间格式为 HHMMSS，采用 24 小时制。
		@active_end_time=235959,					--在 active_start_date 和 active_end_date 之间的任意日期停止执行作业的时间。active_end_time 的数据类型为 int，无默认值。时间格式为 HHMMSS，采用 24 小时制
		@schedule_id = @schedule_id OUTPUT			--成功创建计划时分配给计划的计划标识号
select @schedule_id
GO


/*
	查看job的执行信息
*/
select top 1 b.name as jobname,d.name as categoryname,e.step_name,
a.last_executed_step_date,
a.start_execution_date,a.stop_execution_date,c.last_outcome_message, 
f.message
from msdb.dbo.sysjobactivity as a 
join msdb.dbo.sysjobs as b on a.job_id=b.job_id 
join msdb.dbo.sysjobservers as c on c.job_id=b.job_id
join msdb.dbo.syscategories as d on d.category_id=b.category_id
join msdb.dbo.sysjobsteps as e on e.job_id=a.job_id and e.step_id=a.last_executed_step_id
join msdb.dbo.sysjobhistory as f on a.job_id=f.job_id
where b.name='FullBackupDatabase.Subplan_1'
order by a.stop_execution_date desc

/*
	查询每个job最后一次执行时失败的步骤和日志
*/
select a.name as job_name,a.job_id,b.step_name,b.step_id,
(select top 1 message from msdb.dbo.sysjobhistory as c where c.job_id=a.job_id and c.step_id=b.step_id) as message,
(select top 1 run_status from msdb.dbo.sysjobhistory as c where c.job_id=a.job_id and c.step_id=b.step_id) as run_status
into #temp
from msdb.dbo.sysjobs as a 
join msdb.dbo.sysjobsteps as b on a.job_id=b.job_id
select * from #temp where run_status=0 order by job_name,step_id
drop table #temp


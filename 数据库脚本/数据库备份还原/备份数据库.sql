BACKUP DATABASE TestLoggingShip TO DISK=N'F:\database_bak\TestLoggingShip.bak' 
WITH COMPRESSION --压缩备份
,DESCRIPTION ='数据库TestLoggingShip备份'--数据库描述,最多255个字符
,NAME='数据库TestLoggingShip备份'--数据库备份名称，最多128个字符
,PASSWORD='123'--为备份设置密码
,INIT --覆盖现有同名的备份,NOINIT追加到现有同名的备份
,NOSKIP --BACKUP 语句在可以覆盖媒体上的所有备份集之前先检查它们的过期日期。这是默认行为,SKIP禁用备份集的过期和名称检查
,NOFORMAT--是否应该在用于此备份操作的卷上写入媒体标头，以覆盖任何现有的媒体标头和备份集,FORMAT使备份操作在用于备份操作的所有媒体卷上写入新的媒体标头


--脚本创建数据库邮件
--1.开启数据库邮件
EXEC sp_configure 'show advanced options',1
RECONFIGURE WITH OVERRIDE
GO
EXEC sp_configure 'database mail xps',1
RECONFIGURE WITH OVERRIDE
GO

--2.创建邮件帐户信息
EXEC  msdb..sysmail_add_account_sp
      @ACCOUNT_NAME ='ETLErrorMailLog',--邮件帐户名称
      @EMAIL_ADDRESS ='******@126.com',--发件人邮件地址
      @DISPLAY_NAME ='系统管理员',--发件人姓名
      @REPLYTO_ADDRESS =NULL,
      @DESCRIPTION = NULL,
      @MAILSERVER_NAME = 'SMTP.126.COM',--邮件服务器地址
      @MAILSERVER_TYPE = 'SMTP',--邮件协议
      @PORT =25,--邮件服务器端口
      @USERNAME = '******@126.com',--用户名
      @PASSWORD = '******',--密码
      @USE_DEFAULT_CREDENTIALS =0,
      @ENABLE_SSL =0,
      @ACCOUNT_ID = NULL
GO

--3.数据库配置文件
IF EXISTS(SELECT name FROM msdb..sysmail_profile WHERE name=N'ETLErrorProfileLog')
BEGIN
    EXEC msdb..sysmail_delete_profile_sp
    @profile_name='ETLErrorProfileLog'
END

EXEC msdb..sysmail_add_profile_sp
    @profile_name = 'ETLErrorProfileLog',--profile名称
    @description = '数据库邮件配置文件',--profile描述
    @profile_id = null
GO

--4.用户和邮件配置文件相关联
EXEC msdb..sysmail_add_profileaccount_sp
    @profile_name = 'ETLErrorProfileLog',--profile名称
    @account_name = 'ETLErrorMailLog',--account名称
    @sequence_number = 1--account 在profile 中顺序
GO

--5.1发送简单文本的邮件
EXEC msdb..sp_send_dbmail
    @profile_name = 'ETLErrorProfileLog',--profile名称
    @recipients = '******@qq.com',--收件人
    @subject = 'Test title this is test ',--邮件标题
    @body = N'数据库邮件测试',--邮件内容
    @body_format = 'HTML'--邮件格式
GO

--5.2发送包含查询的邮件
EXEC msdb..sp_send_dbmail
    @profile_name = 'ETLErrorProfileLog',
    @recipients = '******@qq.com',
    @subject = '查询结果',
    @query = 'SELECT * FROM msdb.dbo.sysmail_faileditems'
GO

--5.2发送包含附件的邮件
EXEC msdb..sp_send_dbmail
    @profile_name = 'ETLErrorProfileLog',
    @recipients = '******@qq.com',
    @subject = '包含附件',
    @body = '有附件，请查收',
    @file_attachments = 'c:\a.txt'
GO

--5.3发送查询作为附件的邮件
EXEC msdb..sp_send_dbmail
    @profile_name = 'ETLErrorProfileLog',
    @recipients = '******@qq.com',
    @subject = '查询结果',
    @body = '查询结果在附件中',
    @query = 'SELECT * FROM msdb.dbo.sysmail_faileditems',
    @attach_query_result_as_file = 1,
    @query_attachment_filename = 'a.txt'
GO
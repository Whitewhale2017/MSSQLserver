use master      
go      
select @@servername    
select serverproperty('servername')    
    
IF serverproperty('servername')<>@@servername      
BEGIN    
DECLARE  @server SYSNAME    
SET   @server=@@servername        
EXEC  sp_dropserver @server=@server      
SET   @server=cast(serverproperty('servername') AS SYSNAME)     
EXEC  sp_addserver @server=@server,@local='LOCAL'       
END    
ELSE    
PRINT 'ʵ������������һ�£������޸ģ�' 
GO
select @@servername    
select serverproperty('servername') 



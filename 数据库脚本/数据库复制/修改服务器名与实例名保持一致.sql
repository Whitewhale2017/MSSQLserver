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
PRINT '实例名与主机名一致，无需修改！' 
GO
select @@servername    
select serverproperty('servername') 



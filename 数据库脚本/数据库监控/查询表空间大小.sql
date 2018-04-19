 
CREATE TABLE #temp  
    (  
      name VARCHAR(100),  
      rows INT ,  
      reserved varchar(20),  
      data varchar(20),  
      index_size varchar(20),  
      unused varchar(20)  
        
    )  
    
DECLARE @tablename VARCHAR(100)  
DECLARE @sql VARCHAR(500)  
DECLARE @str VARCHAR(100)  
DECLARE tablecursor CURSOR  
FOR  
    SELECT  name  
    FROM    sys.objects  
    WHERE   type_desc = 'USER_TABLE'   
OPEN tablecursor  
FETCH NEXT FROM tablecursor INTO @tablename  
WHILE @@fetch_status = 0   
    BEGIN  
        SET @str = @tablename  
        SET @sql = N'insert into  #temp EXEC sp_spaceused [' + @tablename +N']'   
        EXEC(@sql)   
        FETCH NEXT FROM tablecursor INTO @tablename  
    END  
CLOSE tablecursor  
DEALLOCATE tablecursor  
SELECT  *  
FROM    #temp ORDER BY name
--DROP TABLE #temp 


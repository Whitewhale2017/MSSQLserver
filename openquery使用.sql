
SELECT * FROM OPENQUERY([192.168.0.252],'SELECT * FROM [192.168.0.252].[User].dbo.func_GetData('201800102')')

DELETE OPENQUERY (OracleSvr, 'SELECT name FROM joe.titles WHERE name = ''NewTitle'''); 

INSERT OPENQUERY (OracleSvr, 'SELECT name FROM joe.titles')  
VALUES ('NewTitle');  

UPDATE OPENQUERY (OracleSvr, 'SELECT name FROM joe.titles WHERE id = 101')   
SET name = 'ADifferentName';  


CREATE PROCEDURE [dbo].[prd_Test]
    @UserId INT
AS
BEGIN
    DECLARE @myUserId VARCHAR(20);
    SET @myUserId = CAST(@UserId AS VARCHAR(20));
    DECLARE @sql VARCHAR(1000);
    SET @sql = 'SELECT * FROM OPENQUERY([192.168.0.252],''SELECT * FROM [User].dbo.func_GetData(' + @myUserId + ')'')';
    EXEC(@sql);
END
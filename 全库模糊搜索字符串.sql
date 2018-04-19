DECLARE @key_find NVARCHAR(MAX) = '�ڼ�';--���������ַ���"�ڼ�"
 --2.���α�Cursor_Table���������б�
 DECLARE Cursor_Table CURSOR FOR
     SELECT name from sysobjects WHERE xtype = 'u' AND name <> 'dtproperties';
 OPEN Cursor_Table;
 DECLARE @tableName NVARCHAR(MAX);
 FETCH NEXT from Cursor_Table INTO @tableName;
 WHILE @@fetch_status = 0
 BEGIN
     DECLARE @tempSQLText NVARCHAR(MAX) = '';
     --3.�ڱ��У����α�columnCursor�����������ֶΡ�ע�⣬ֻ�����ַ������͵��ֶΣ��У�
     DECLARE columnCursor CURSOR FOR 
         SELECT Name FROM SysColumns WHERE ID = Object_Id( @tableName ) and
                                                                             ( 
                                                                                 xtype = 35 or --text
                                                                                 xtype = 99 or --ntext
                                                                                 xtype = 167 or --varchar
                                                                                 xtype = 175 or --char
                                                                                 xtype = 231 or --nvarchar
                                                                                 xtype = 239 or --nchar
                                                                                 xtype = 241 --xml
                                                                             )
     OPEN columnCursor;
     DECLARE @columnName NVARCHAR(MAX);
     FETCH NEXT from columnCursor INTO @columnName;
     WHILE @@fetch_status = 0
     BEGIN
         --4.�ڱ���ֶ��У���ÿһ�н���ģ��������������ҵ�����Ϣ��
         DECLARE @DynamicSQLText NVARCHAR(MAX) = 'IF ( EXISTS ( SELECT * FROM [' + @tableName + '] WHERE [' + @columnName + '] LIKE ''%' + @key_find + '%'' ) ) 
		 BEGIN 
		 DECLARE @CurrentTableCount Bigint = ( SELECT COUNT(*) From [' + @tableName + '] ); 
		 PRINT ''Find : Table [' + @tableName + '], Column [' + @columnName + '], Row Count:'' + CAST( @CurrentTableCount AS NVARCHAR(MAX) ) + ''.'';  END';
         EXEC( @DynamicSQLText );
         FETCH NEXT from columnCursor INTO @columnName
     END
     exec(@tempSQLText);
     CLOSE columnCursor;
     DEALLOCATE columnCursor;
     FETCH NEXT from Cursor_Table INTO @tableName;
 END
 CLOSE Cursor_Table;
 DEALLOCATE Cursor_Table;
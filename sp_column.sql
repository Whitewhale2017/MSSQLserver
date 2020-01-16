CREATE proc [dbo].[sp_column] -- sp_column md_employee  
     
@Tablename varchar(100)    
    
As    
    
/*    
    
Function:ȡ��һ����������ֶ����ö��ŷָ�    
    
Declare @Columns varchar(8000)    
    
Select  @Columns=Isnull(@Columns+',','')+name From syscolumns Where Id=Object_Id(@Tablename)    
    
Print @Columns    
 */    
    
Declare @Columns varchar(8000)    
    
Select  @Columns=Isnull(@Columns+',','')+a.name From syscolumns a,sysobjects b 
  Where a.ID = b.ID and b.name=@Tablename order by colorder  
    
Print @Columns
GO
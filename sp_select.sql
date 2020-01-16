CREATE proc [dbo].[sp_Select] --exec sp_Select 'mc_roleapps',0
(@Tablename nvarchar(50),
@Retval int= 0 output)

as

	Declare @SQL nvarchar(200)

	Select @SQL = 'Select * From ' + @Tablename
	
	EXEC (@SQL)


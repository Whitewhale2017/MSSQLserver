update [ecology].[dbo].[HrmResource]
 set password = a.password
 from [ecology8].[dbo].[HrmResource] a
 where [ecology].[dbo].[HrmResource].[workcode] = a.workcode
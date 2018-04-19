 WITH Tree 	 AS  
        		( 
        		SELECT  P.id,P.supdepid,P.departmentname FROM HrmDepartment P WHERE P.id = '28'  
        		UNION ALL 
        		SELECT C.id,C.supdepid,C.departmentname FROM HrmDepartment C 
        		INNER JOIN Tree T ON C.id = T.supdepid 
        		 ) 
        		 SELECT STUFF((SELECT ','+departmentname FROM Tree for xml path('')),1,1,'') as departmentname
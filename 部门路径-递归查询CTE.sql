WITH CTE AS (
    select id,departmentname,supdepid,1 as Level 
	from HrmDepartment where supdepid=0 and (canceled<>1 or canceled is null)
    UNION ALL
    SELECT t.id,t.departmentname,t.supdepid,cte.Level+1 AS Level 
	FROM HrmDepartment t
    JOIN CTE ON t.supdepid=CTE.id
	where canceled<>1 or canceled is null
)
--SELECT * FROM CTE;
--select id,departmentname,supdepid,1 as Level from HrmDepartment where supdepid=0
SELECT 
    t1.departmentname AS [一级部门]
    ,t2.departmentname AS [二级部门]
    ,t3.departmentname AS [三级部门]
	,t3.departmentname AS [四级部门]
FROM 
(SELECT * FROM CTE WHERE LEVEL=1) AS t1 
left JOIN 
(SELECT * FROM CTE WHERE LEVEL=2) AS t2 ON t1.id=t2.supdepid
left JOIN
(SELECT * FROM CTE WHERE LEVEL=3) AS t3 ON t2.id=t3.supdepid
left JOIN
(SELECT * FROM CTE WHERE LEVEL=4) AS t4 ON t3.id=t4.supdepid
ORDER BY 1,2,3,4


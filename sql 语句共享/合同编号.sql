create view [dbo].[view_htxx] 
as
SELECT requestId, requestname,htmc,createdate, HTBH, TBRQ, lastname, htlb, htlx, htjelx, 
      htzje, subcompanyname
FROM (SELECT a.requestId,a.htmc,b.requestname, 
              b.createdate + ' ' + b.createtime AS createdate, a.HTBH, a.TBRQ, d.lastname, 
              e.selectname AS htlb, f.selectname AS htlx, g.selectname AS htjelx, a.htzje, 
              k.subcompanyname
        FROM dbo.formtable_main_166 AS a LEFT OUTER JOIN
              dbo.workflow_requestbase AS b ON 
              a.requestId = b.requestid LEFT OUTER JOIN
              dbo.workflow_base AS c ON b.workflowid = c.id LEFT OUTER JOIN
              dbo.HrmResource AS d ON a.SQE = d.id LEFT OUTER JOIN
              dbo.workflow_SelectItem AS e ON a.htlb = e.selectvalue AND 
              e.fieldid = '10534' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS f ON a.htlx = f.selectvalue AND 
              f.fieldid = '10578' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS g ON a.htjelx = g.selectvalue AND 
              g.fieldid = '10579' LEFT OUTER JOIN
              dbo.HrmSubCompany AS k ON a.SSGS = k.id
        UNION ALL
        SELECT a.requestId, a.htmc,b.requestname, 
              b.createdate + ' ' + b.createtime AS createdate, a.HTBH, a.TBRQ, d.lastname, 
              e.selectname AS htlb, f.selectname AS htlx, g.selectname AS htjelx, a.htzje, 
              k.subcompanyname
        FROM dbo.formtable_main_170 AS a LEFT OUTER JOIN
              dbo.workflow_requestbase AS b ON 
              a.requestId = b.requestid LEFT OUTER JOIN
              dbo.workflow_base AS c ON b.workflowid = c.id LEFT OUTER JOIN
              dbo.HrmResource AS d ON a.SQE = d.id LEFT OUTER JOIN
              dbo.workflow_SelectItem AS e ON a.htlb = e.selectvalue AND 
              e.fieldid = '10639' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS f ON a.htlx = f.selectvalue AND 
              f.fieldid = '10650' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS g ON a.htjelx = g.selectvalue AND 
              g.fieldid = '10651' LEFT OUTER JOIN
              dbo.HrmSubCompany AS k ON a.SSGS = k.id
        UNION ALL
        SELECT a.requestId, a.htmc,b.requestname, 
              b.createdate + ' ' + b.createtime AS createdate, a.HTBH, a.TBRQ, d.lastname, 
              e.selectname AS htlb, f.selectname AS htlx, g.selectname AS htjelx, a.htzje, 
              k.subcompanyname
        FROM dbo.formtable_main_171 AS a LEFT OUTER JOIN
              dbo.workflow_requestbase AS b ON 
              a.requestId = b.requestid LEFT OUTER JOIN
              dbo.workflow_base AS c ON b.workflowid = c.id LEFT OUTER JOIN
              dbo.HrmResource AS d ON a.SQE = d.id LEFT OUTER JOIN
              dbo.workflow_SelectItem AS e ON a.htlb = e.selectvalue AND 
              e.fieldid = '10712' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS f ON a.htlx = f.selectvalue AND 
              f.fieldid = '10722' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS g ON a.htjelx = g.selectvalue AND 
              g.fieldid = '10723' LEFT OUTER JOIN
              dbo.HrmSubCompany AS k ON a.SSGS = k.id
        UNION ALL
        SELECT a.requestId, a.htmc,b.requestname, 
              b.createdate + ' ' + b.createtime AS createdate, a.HTBH, a.TBRQ, d.lastname, 
              e.selectname AS htlb, f.selectname AS htlx, g.selectname AS htjelx, a.htzje, 
              k.subcompanyname
        FROM dbo.formtable_main_175 AS a LEFT OUTER JOIN
              dbo.workflow_requestbase AS b ON 
              a.requestId = b.requestid LEFT OUTER JOIN
              dbo.workflow_base AS c ON b.workflowid = c.id LEFT OUTER JOIN
              dbo.HrmResource AS d ON a.SQE = d.id LEFT OUTER JOIN
              dbo.workflow_SelectItem AS e ON a.htlb = e.selectvalue AND 
              e.fieldid = '10908' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS f ON a.htlx = f.selectvalue AND 
              f.fieldid = '10918' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS g ON a.htjelx = g.selectvalue AND 
              g.fieldid = '10919' LEFT OUTER JOIN
              dbo.HrmSubCompany AS k ON a.SSGS = k.id
        UNION ALL
        SELECT a.requestId, a.htmc,b.requestname, 
              b.createdate + ' ' + b.createtime AS createdate, a.HTBH, a.TBRQ, d.lastname, 
              e.selectname AS htlb, f.selectname AS htlx, g.selectname AS htjelx, a.htzje, 
              k.subcompanyname
        FROM dbo.formtable_main_177 AS a LEFT OUTER JOIN
              dbo.workflow_requestbase AS b ON 
              a.requestId = b.requestid LEFT OUTER JOIN
              dbo.workflow_base AS c ON b.workflowid = c.id LEFT OUTER JOIN
              dbo.HrmResource AS d ON a.SQE = d.id LEFT OUTER JOIN
              dbo.workflow_SelectItem AS e ON a.htlb = e.selectvalue AND 
              e.fieldid = '11106' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS f ON a.htlx = f.selectvalue AND 
              f.fieldid = '11050' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS g ON a.htjelx = g.selectvalue AND 
              g.fieldid = '11051' LEFT OUTER JOIN
              dbo.HrmSubCompany AS k ON a.SSGS = k.id
        UNION ALL
        SELECT a.requestId, a.htmc,b.requestname, 
              b.createdate + ' ' + b.createtime AS createdate, a.HTBH, a.TBRQ, d.lastname, 
              e.selectname AS htlb, f.selectname AS htlx, g.selectname AS htjelx, a.htzje, 
              k.subcompanyname
        FROM dbo.formtable_main_179 AS a LEFT OUTER JOIN
              dbo.workflow_requestbase AS b ON 
              a.requestId = b.requestid LEFT OUTER JOIN
              dbo.workflow_base AS c ON b.workflowid = c.id LEFT OUTER JOIN
              dbo.HrmResource AS d ON a.SQE = d.id LEFT OUTER JOIN
              dbo.workflow_SelectItem AS e ON a.htlb = e.selectvalue AND 
              e.fieldid = '11182' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS f ON a.htlx = f.selectvalue AND 
              f.fieldid = '11132' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS g ON a.htjelx = g.selectvalue AND 
              g.fieldid = '11133' LEFT OUTER JOIN
              dbo.HrmSubCompany AS k ON a.SSGS = k.id
        UNION ALL
        SELECT a.requestId, a.htmc,b.requestname, 
              b.createdate + ' ' + b.createtime AS createdate, a.HTBH, a.TBRQ, d.lastname, 
              e.selectname AS htlb, f.selectname AS htlx, g.selectname AS htjelx, a.htzje, 
              k.subcompanyname
        FROM dbo.formtable_main_180 AS a LEFT OUTER JOIN
              dbo.workflow_requestbase AS b ON 
              a.requestId = b.requestid LEFT OUTER JOIN
              dbo.workflow_base AS c ON b.workflowid = c.id LEFT OUTER JOIN
              dbo.HrmResource AS d ON a.SQE = d.id LEFT OUTER JOIN
              dbo.workflow_SelectItem AS e ON a.htlb = e.selectvalue AND 
              e.fieldid = '11336' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS f ON a.htlx = f.selectvalue AND 
              f.fieldid = '11286' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS g ON a.htjelx = g.selectvalue AND 
              g.fieldid = '11287' LEFT OUTER JOIN
              dbo.HrmSubCompany AS k ON a.SSGS = k.id
        UNION ALL
        SELECT a.requestId, a.htmc,b.requestname, 
              b.createdate + ' ' + b.createtime AS createdate, a.HTBH, a.TBRQ, d.lastname, 
              e.selectname AS htlb, f.selectname AS htlx, g.selectname AS htjelx, a.htzje, 
              k.subcompanyname
        FROM dbo.formtable_main_181 AS a LEFT OUTER JOIN
              dbo.workflow_requestbase AS b ON 
              a.requestId = b.requestid LEFT OUTER JOIN
              dbo.workflow_base AS c ON b.workflowid = c.id LEFT OUTER JOIN
              dbo.HrmResource AS d ON a.SQE = d.id LEFT OUTER JOIN
              dbo.workflow_SelectItem AS e ON a.htlb = e.selectvalue AND 
              e.fieldid = '11258' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS f ON a.htlx = f.selectvalue AND 
              f.fieldid = '11208' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS g ON a.htjelx = g.selectvalue AND 
              g.fieldid = '11209' LEFT OUTER JOIN
              dbo.HrmSubCompany AS k ON a.SSGS = k.id
		UNION ALL
		select a.requestId, a.htmc,b.requestname, 
              b.createdate + ' ' + b.createtime AS createdate, a.HTBH, a.txrq as TBRQ, d.lastname, 
              e.selectname AS htlb, f.selectname AS htlx, g.selectname AS htjelx, a.htje as htzje,
			  k.subcompanyname from formtable_main_266 AS a LEFT OUTER JOIN
              dbo.workflow_requestbase AS b ON 
              a.requestId = b.requestid LEFT OUTER JOIN
              dbo.workflow_base AS c ON b.workflowid = c.id LEFT OUTER JOIN
              dbo.HrmResource AS d ON a.jbr = d.id LEFT OUTER JOIN
              dbo.workflow_SelectItem AS e ON a.htlb = e.selectvalue AND 
              e.fieldid = '15653' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS f ON a.htlx = f.selectvalue AND 
              f.fieldid = '15651' LEFT OUTER JOIN
              dbo.workflow_SelectItem AS g ON a.htjelx = g.selectvalue AND 
              g.fieldid = '15674' LEFT OUTER JOIN
              dbo.HrmSubCompany AS k ON d.subcompanyid1 = k.id) AS h
GO

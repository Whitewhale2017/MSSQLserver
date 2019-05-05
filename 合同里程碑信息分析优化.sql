use ecology;
SELECT DISTINCT
                a.vbeln,a.posid,bm, lastname, ddlx, ddzt, xmlx, lcbb
				, CASE isnull(a.sfyt, '1') 
                WHEN 0 THEN '预投' WHEN 1 THEN '正式' END AS sfyt, 
				(CASE WHEN a.posid IS NULL THEN '' ELSE a.WBSstate END) AS wbszt
				,b.dt as lcbzt,c.xmztzt
FROM      (SELECT   a.VBELN, fm.sfyt, dbo.f_sapbm(a.BZIRK) AS bm, hr.lastname, dbo.f_sapddlx(a.AUART) AS ddlx, 
                                 dd.ddlx AS xmlx, a.POSID, 
                                 CASE gbstk WHEN 'A' THEN '未处理' WHEN 'B' THEN '处理中' WHEN 'C' THEN '已完成' END AS ddzt, 
                                 CASE isnull(inact, 'X') WHEN '' THEN '已关闭' WHEN 'X' THEN '未关闭' END AS WBSstate
								 --,CASE WHEN lst_actdt = '00000000' THEN 2 WHEN lst_actdt IS NULL THEN 0 ELSE 1 END AS lcb
                                 ,a.LST_ACTDT AS lcbb
                 FROM      v_sap_mst AS a LEFT OUTER JOIN
                                 b_sap_ddlx AS dd ON dd.wb = a.PROFL LEFT OUTER JOIN
                                 OAView.dbo.hth_uf_contract_formtable_284 AS f284 ON f284.ContractNo_SAP = a.VBELN LEFT OUTER JOIN
                                 HrmResource AS hr ON hr.workcode = a.KUNNR LEFT OUTER JOIN
                                 formtable_main_317 AS fm ON fm.hth = a.VBELN) AS a
			  left join 
			  (
			  	 select posid,case 
				 when count(case when lst_actdt!='00000000' and lst_actdt is  not null then 1 end)=count(1) then '全部确认' 
				 when count(case when lst_actdt='00000000' then 1 end)=count(1) then '未确认' 
				 when count(case when lst_actdt is null then 1 end)=count(1) then '未创建' 
				 else '部分确认' end
	             as dt from (
                 SELECT posid,lst_actdt,case lst_actdt when NULL then -1 when '00000000' then 1 else 0 end as t
				 ,case lst_actdt when NULL then 0 when '00000000' then 0 else 1 end as t1
	              FROM v_sap_mst
	              ) t
	             group by t.posid
			  ) b
			  on a.posid=b.posid
			  left join (
			  select vbeln,
				case 
					when count(case when inact='' then null else 1 end)=count(1) then '无WBS关闭' 
					when count(case when inact='' then 1 end)=count(1) then '项目整体关闭' 
					when count(case when substring(posid,11,2)>'14' then 1 end)=count(case when substring(posid,11,2)>'14' and inact='' then 1 end)
						 and
						 count(case when substring(posid,11,2)='14' then 1 end)>count(case when substring(posid,11,2)='14' and inact='' then 1 end)
						 then '全部子合同关闭'
					when count(case when substring(posid,11,2)>'14' then 1 end)>count(case when substring(posid,11,2)>'14' and inact='' then 1 end)
						 and
						 count(case when substring(posid,11,2)>'14' and inact='' then 1 end)>0
						 then '部分子合同关闭'
					when count(case when substring(posid,11,2)='14' then 1 end)=count(case when substring(posid,11,2)='14' and inact='' then 1 end)
						 and
						 count(case when substring(posid,11,2)>'14' and inact='' then 1 end)=0
						 then '运营/质保期关闭'
					else '数据异常'
					end as xmztzt
				from v_sap_mst
				group by vbeln
			  ) c
			  on a.vbeln=c.vbeln


--where a.posid like 'DA1800051N%'

-------------------------------------
              SELECT posid,lst_actdt,count(case when lst_actdt is null then 1 end) as N,
				 count(case when lst_actdt='00000000' then 1 end) as O,
				 count(case when lst_actdt!='00000000' and lst_actdt is  not null then 1 end) as Y
	              FROM v_sap_mst
	            -- where posid='DA1800051N15000000'
				 group by posid,lst_actdt

			select * from v_sap_mst where posid='DA1800051N15000000'
---------------------------

select vbeln,posid,inact,substring(posid,11,2) as lxt
,case when substring(posid,11,2)='14' then '运营/质保期' 
      when substring(posid,11,2)>'14' then '子合同'
	  end
	  as lx
,case when inact='' then '已关闭' else '未关闭' end as zt
from v_sap_mst 
where vbeln='DT1890044N'
order by posid desc
----------------------------------------
select * from (
select vbeln,
case 
	when count(case when inact='' then null else 1 end)=count(1) then '无WBS关闭' 
	when count(case when inact='' then 1 end)=count(1) then '项目整体关闭' 
	when count(case when substring(posid,11,2)>'14' then 1 end)=count(case when substring(posid,11,2)>'14' and inact='' then 1 end)
	     and
		 count(case when substring(posid,11,2)='14' then 1 end)>count(case when substring(posid,11,2)='14' and inact='' then 1 end)
		 then '全部子合同关闭'
    when count(case when substring(posid,11,2)>'14' then 1 end)>count(case when substring(posid,11,2)>'14' and inact='' then 1 end)
	     and
		 count(case when substring(posid,11,2)>'14' and inact='' then 1 end)>0
	     then '部分子合同关闭'
	when count(case when substring(posid,11,2)='14' then 1 end)=count(case when substring(posid,11,2)='14' and inact='' then 1 end)
	     and
		 count(case when substring(posid,11,2)>'14' and inact='' then 1 end)=0
		 then '运营/质保期关闭'
    else '数据异常'
	end as xmztzt
from v_sap_mst
group by vbeln
) t
where t.xmztzt='项目整体关闭' 



select count(case when substring(posid,11,2)>'14' and inact='' then 1 end),count(1)
from v_sap_mst
where vbeln='DW1940078N'
group by vbeln
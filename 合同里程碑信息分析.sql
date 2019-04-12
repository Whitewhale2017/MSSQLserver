SELECT DISTINCT 
                vbeln,a.posid,bm, lastname, ddlx, ddzt, xmlx, lcbb, xmztzt, CASE isnull(a.sfyt, '1') 
                WHEN 0 THEN '预投' WHEN 1 THEN '正式' END AS sfyt, 
				(CASE WHEN a.posid IS NULL THEN '' ELSE a.WBSstate END) AS wbszt
				--, (CASE WHEN a.posid IS NULL THEN '' ELSE a.lcb END) AS lcb
				,b.dt as lcbzt
				--,dbo.f_jslcbzt(posid) AS lcbzt
FROM      (SELECT   a.VBELN, fm.sfyt, dbo.f_sapbm(a.BZIRK) AS bm, hr.lastname, dbo.f_sapddlx(a.AUART) AS ddlx, 
                                 dd.ddlx AS xmlx, a.POSID, 
                                 CASE gbstk WHEN 'A' THEN '未处理' WHEN 'B' THEN '处理中' WHEN 'C' THEN '已完成' END AS ddzt, 
                                 CASE isnull(inact, 'X') WHEN '' THEN '已关闭' WHEN 'X' THEN '未关闭' END AS WBSstate
								 --,CASE WHEN lst_actdt = '00000000' THEN 2 WHEN lst_actdt IS NULL THEN 0 ELSE 1 END AS lcb
                                 ,a.LST_ACTDT AS lcbb, '' AS xmztzt
                 FROM      v_sap_mst AS a LEFT OUTER JOIN
                                 b_sap_ddlx AS dd ON dd.wb = a.PROFL LEFT OUTER JOIN
                                 OAView.dbo.hth_uf_contract_formtable_284 AS f284 ON f284.ContractNo_SAP = a.VBELN LEFT OUTER JOIN
                                 HrmResource AS hr ON hr.workcode = a.KUNNR LEFT OUTER JOIN
                                 formtable_main_317 AS fm ON fm.hth = a.VBELN) AS a
			  left join 
			  (
			  	 select posid,case 
				 when sum(t1)=count(1) then '全部确认' 
				 when count(1)=sum(t) then '未确认' 
				 when count(1)+sum(t)=0 
				 then '未创建' 
				 else '部分确认' end
	             as dt from (
                 SELECT posid,lst_actdt,case lst_actdt when NULL then -1 when '00000000' then 1 else 0 end as t
				 ,case lst_actdt when NULL then 0 when '00000000' then 0 else 1 end as t1
	              FROM v_sap_mst
	              ) t
	             --where posid='DA1800051N15000000'
	              group by t.posid
			  ) b
			  on a.posid=b.posid
where a.posid like 'DA1800051N%'
								

-------------------------------------------------------------------------------------
create view [dbo].[v_sap_mst]
as
select * from openquery
(HANAPRD,'select  distinct a.vbeln,b.auart,b.gbstk,c.profl,d.posid,e.inact,f.kunnr,g.bzirk,h.lst_actdt from SAPABAP1.VBAP a 
left join (select distinct auart,vbeln,gbstk from SAPABAP1.vbak where mandt=800) b on b.vbeln=a.vbeln
left join (select distinct pspid,profl from SAPABAP1.proj where mandt=800)c on c.pspid=a.vbeln
left join (select * from (
select pspnr,posid,stufe,SUBSTRING(posid,11,2) as fg,left(posid,10) as hth,objnr from SAPABAP1.prps  where stufe=1 and mandt=800) a
where a.fg>=''14'' and a.hth in (select  distinct vbeln from SAPABAP1.vbak where auart=''ZPS1''or auart=''ZPS2''and mandt=800))d on d.hth= a.vbeln
left join (select  objnr,stat,inact from SAPABAP1.jest where stat=''I0045'' and mandt=800 ) e on e.objnr=d.objnr
left join (select vbeln,right(kunnr,6)as kunnr from SAPABAP1.vbpa  where  mandt=800 and parvw=''ZM'') f on f.vbeln=b.vbeln
left join (select vbeln,bzirk from SAPABAP1.vbkd  where  mandt=800) g on g.vbeln=b.vbeln
left join (select pspnr,lst_actdt from SAPABAP1.mlst  where  mlst_mandt=800 ) h on h.pspnr=d.pspnr
where a.mandt=800 and a.abgru=''''')
GO

--------------------------------------------------------------------------------------------------------------

--SELECT posid,lst_actdt
--       --,case when lst_actdt = '00000000' then 2 when lst_actdt is null then 0 else 1 end as lcb
--FROM v_sap_mst a
--    --where lst_actdt='00000000'
--where posid='DA1800229N15000000'
----------------------------------
create function f_jslcbzt(@posid varchar(30))
    returns varchar(20)
as
begin
    declare @res varchar(20)
        if(not exists (SELECT 1 FROM v_sap_mst  where posid=@posid and lst_actdt is not null))
        begin
            set @res='未创建'
        end
        else if (not exists (SELECT 1 FROM v_sap_mst  where posid=@posid and (lst_actdt is null or lst_actdt='00000000')))
             begin
                 set @res='全部确认'
             end
        else if(not exists (SELECT 1 FROM v_sap_mst where posid=@posid and lst_actdt<>'00000000'))
              begin
                 set @res='未确认'
              end
        else
            begin
                set  @res='部分确认'
            end
    return @res
end

------------------------------------------
create function f_jslcbzt_y(@posid varchar(30))
    returns varchar(20)
as
begin
    declare @res varchar(20)
	 
	 select posid,count(*) as nt,sum(t) as dt from (
      SELECT posid,lst_actdt,case lst_actdt when NULL then 0 when '00000000' then 1 else -1 end as t
	  FROM v_sap_mst
	  ) t


    return @res
end

----------------------------------------------
create function [dbo].[f_sapbm](@bm varchar(200))
returns varchar(200)
as 
begin
	declare @res varchar(200)
	set @res=(select case @bm when 'Z00001' then '营销中心销售一部' when 'Z00002' then '营销中心销售二部' when 'Z00003' then '营销中心销售三部' when 'Z00004' then '营销中心销售四部'
	when 'Z00005' then '营销中心销售五部'when 'Z00006' then '营销中心销售六部'when 'Z00007' then '第二营销中心国内线上部'when 'Z00008' then '第二营销中心国内线下部'
	when 'Z00009' then '第二营销中心国外线上部'when 'Z00010' then '第二营销中心国外线下部'when 'Z00011' then '工程部'when 'Z00000' then '通用' end)
	return @res
end
---------------------------------
create function [dbo].[f_sapddlx](@ddlx varchar(200))
returns varchar(200)
as 
begin
	declare @res varchar(200)
	set @res=(case @ddlx when 'ZOR1' then'ZOR1国内产品销售订单' when 'ZOR2' then'ZOR2国际产品销售订单'when 'ZOR3' then'ZOR3国内跨公司产品销售订单'
when 'ZOR4' then'ZOR4国际跨公司产品销售订单'when 'ZOR5' then'ZOR5服务类销售订单'when 'ZOR6' then'ZOR6电商结算订单'
when 'ZPS1' then'ZPS1国内项目类销售订单'when 'ZPS2' then'ZPS2国际项目类销售订单'when 'ZRE1' then'ZRE1标准产品退货订单'
when 'ZRE2' then'ZRE2跨公司产品退货订单' when 'ZCR' then 'ZCR项目退票销售订单'end )
	return @res
end

--------------------------------------------

   


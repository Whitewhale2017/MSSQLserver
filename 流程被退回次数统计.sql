select t.creater
	   ,dbo.f_bmqc((select departmentid from hrmresource where id=t.creater)) as bm
	   ,(select lastname from hrmresource where id=t.creater) as lastname
       ,count(requestid) as ����,
       sum(case
             when currentnodetype = 3 then
              1
             else
              0
           end) as �鵵,
       sum(case
             when currentnodetype = 3 then
              0
             else
              1
           end) as δ�鵵,
       sum(case
             when hours >= 15 * 24 then
              1
             else
              0
           end) as ����15��,
       sum(case
             when thcs = 0 or thcs is null then
              0
             else
              1
           end) as �˻���������,
       sum(thcs) as �˻ش���
  from (select (select workflowtype from workflow_base where id = workflowid) as workflowtype,
               workflowid,
               (select id
                  from HrmSubCompany
                 where id = (select subcompanyid1
                               from hrmresource
                              where id = creater)) as companyid,
               createdate,
               lastoperatedate,
               requestid,
               creater,
               currentnodetype,
               dbo.Jisuanshichang(w.createdate,w.createtime,w.lastoperatedate,w.lastoperatetime) as hours,
               (select sum(case
                             when logtype = '3' then
                              1
                             else
                              0
                           end)
                  from workflow_requestLog
                 where requestid = w.requestid) as thcs
          from workflow_requestbase w
         where w.createdate >= '2018-11-01'
           and w.createdate < '2018-11-30'
		   ) t
 group by creater
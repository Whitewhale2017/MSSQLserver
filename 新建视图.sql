IF EXISTS (SELECT * FROM sysobjects WHERE /*����Ƿ����*/
                         name = 'view_PersonInfo')
DROP VIEW view_PersonInfo /*ɾ����ͼ*/
GO
CREATE VIEW view_PersonInfo /*������ͼ*/
  AS
    SELECT c.subcompanyname as '��˾',d.departmentname as '����',j.jobtitlename as '��λ',r.id as '���',
	r.lastname as '����',case when r.sex=0 then '��' else 'Ů' end as '�Ա�',r.telephone as '������'
    FROM HrmResource r,HrmDepartment d,HrmJobTitles j,HrmSubCompany c
    where c.id=r.subcompanyid1 and d.id=r.departmentid and r.jobtitle=j.id

GO
SELECT * FROM view_PersonInfo /*ʹ����ͼ*/



 /*from��ʱ�� ��Ҫ������õı� ������ֵѿ�����������������ѯ*/
 SELECT d.departmentname as '����',r.id,r.lastname as '����'
               FROM HrmResource r,HrmDepartment d
               where d.id=r.departmentid;

 SELECT d.departmentname as '����',r.id,r.lastname as '����'
               FROM HrmResource r,HrmDepartment d,HrmJobTitles j
               where d.id=r.departmentid;

/*����ͼ���в������Ը���ԭ�������*/
select * from view_PersonInfo where ����='������'
update view_PersonInfo set ��λ='�ܲ�' where ���='3';

select * from (select lastname,loginid,email,departmentid from HrmResource where sex=0) a
inner join HrmDepartment d on d.id=a.departmentid; 

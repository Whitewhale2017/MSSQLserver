IF EXISTS (SELECT * FROM sysobjects WHERE /*检测是否存在*/
                         name = 'view_PersonInfo')
DROP VIEW view_PersonInfo /*删除视图*/
GO
CREATE VIEW view_PersonInfo /*创建视图*/
  AS
    SELECT c.subcompanyname as '公司',d.departmentname as '部门',j.jobtitlename as '岗位',r.id as '编号',
	r.lastname as '姓名',case when r.sex=0 then '男' else '女' end as '性别',r.telephone as '座机号'
    FROM HrmResource r,HrmDepartment d,HrmJobTitles j,HrmSubCompany c
    where c.id=r.subcompanyid1 and d.id=r.departmentid and r.jobtitle=j.id

GO
SELECT * FROM view_PersonInfo /*使用视图*/



 /*from的时候 不要添加无用的表 否则出现笛卡尔积，如下两个查询*/
 SELECT d.departmentname as '部门',r.id,r.lastname as '姓名'
               FROM HrmResource r,HrmDepartment d
               where d.id=r.departmentid;

 SELECT d.departmentname as '部门',r.id,r.lastname as '姓名'
               FROM HrmResource r,HrmDepartment d,HrmJobTitles j
               where d.id=r.departmentid;

/*对视图进行操作可以更新原表的数据*/
select * from view_PersonInfo where 姓名='王阳阳'
update view_PersonInfo set 岗位='总裁' where 编号='3';

select * from (select lastname,loginid,email,departmentid from HrmResource where sex=0) a
inner join HrmDepartment d on d.id=a.departmentid; 

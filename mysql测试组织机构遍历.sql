/*创建测试数据库*/
DROP TABLE IF EXISTS vrv_org_tab; 
CREATE TABLE vrv_org_tab ( 
id bigint(8) NOT NULL AUTO_INCREMENT, 
org_name varchar(50) NOT NULL, 
org_level int(4) NOT NULL DEFAULT 0, 
org_parent_id bigint(8) NOT NULL DEFAULT 0, 
PRIMARY KEY (id), 
UNIQUE KEY unique_org_name (org_name) 
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*导入数据*/
INSERT INTO vrv_org_tab VALUES (1,"北信源", 1, 0); 
INSERT INTO vrv_org_tab VALUES ("2", "北京", "2", "1"); 
INSERT INTO vrv_org_tab VALUES ("3", "南京", "2", "1"); 
INSERT INTO vrv_org_tab VALUES ("4", "武汉", "2", "1"); 
INSERT INTO vrv_org_tab VALUES ("5", "上海", "2", "1"); 
INSERT INTO vrv_org_tab VALUES ("6", "北京研发中心", "3", "2"); 
INSERT INTO vrv_org_tab VALUES ("7", "南京研发中心", "3", "3"); 
INSERT INTO vrv_org_tab VALUES ("8", "武汉研发中心", "3", "4"); 
INSERT INTO vrv_org_tab VALUES ("9", "上海研发中心", "3", "5"); 
INSERT INTO vrv_org_tab VALUES ("10", "北京EMM项目组", "4", "6"); 
INSERT INTO vrv_org_tab VALUES ("11", "北京linkdd项目组", "4", "6"); 
INSERT INTO vrv_org_tab VALUES ("12", "南京EMM项目组", "4", "7"); 
INSERT INTO vrv_org_tab VALUES ("13", "南京linkdd项目组", "4", "7"); 
INSERT INTO vrv_org_tab VALUES ("14", "武汉EMM项目组", "4", "8"); 
INSERT INTO vrv_org_tab VALUES ("15", "武汉linkdd项目组", "4", "8"); 
INSERT INTO vrv_org_tab VALUES ("16", "上海EMM项目组", "4", "9"); 
INSERT INTO vrv_org_tab VALUES ("17", "上海linkdd项目组", "4", "9");


select * from vrv_org_tab;

create function getChildrenOrg(orgid INT)
returns varchar(4000)
BEGIN
DECLARE oTemp VARCHAR(4000);
declare oTempChild VARCHAR(4000);
SET oTemp = '';
SET oTempChild = CAST(orgid AS CHAR);
WHILE oTempChild IS NOT NULL
DO
SET oTemp = CONCAT(oTemp,',',oTempChild);
SELECT GROUP_CONCAT(id) INTO oTempChild FROM vrv_org_tab WHERE FIND_IN_SET(org_parent_id,oTempChild) > 0;
END WHILE;
RETURN oTemp;
END
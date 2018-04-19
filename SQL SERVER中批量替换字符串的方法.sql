在SQL SERVER中批量替换字符串的方法 

update table[表名] set Fields[字段名]=replace(Fields[字段名],'被替换原内容','要替换 

成的内容') 

update ProgInfo set JoinTime=replace(JoinTime,'2007-3-2','2007-03-02') 

实例： 

问题：某数据库里 flash 表 的 url 字段 

现在想找到url字段里的所有 

game.网址.com/不变部分 

批量改成 

game_new.网址.com/不变部分 

只变前半部分！ 

不知道怎么用SQL语句呢？ 


答： 

方法一： 

update flash set url=replace(url,'game','game_new') 

方法二： 

update flash set url=replace(url,substring(url,1,4),'game_new')